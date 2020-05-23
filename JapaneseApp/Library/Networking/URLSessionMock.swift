//
//  URLSessionMock.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

fileprivate let accessTokenExpireIn = 60
fileprivate let refreshTokenExpireIn = 3600

class URLSessionMock: URLSession {
    
    enum Response {
        static let success = { httpURLResponse($0, 200) }
        static let unauthorized = { httpURLResponse($0, 401) }
        static let notFound = { httpURLResponse($0, 404) }
        static let internalServerErrpr = { httpURLResponse($0, 500) }
        
        private static let httpURLResponse = {
            HTTPURLResponse(url: $0, statusCode: $1, httpVersion: nil, headerFields: [:])
        }
    }
    
    override init() {}
    
    typealias CompletionHandler = (Data?, URLResponse?, Swift.Error?) -> Void

    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        
        if let data = data {
            return URLSessionDataTaskMock {
                completionHandler(data, self.response, nil)
            }
        }
        
        if let error = error {
            return URLSessionDataTaskMock {
                completionHandler(nil, self.response, error)
            }
        }
        
        
        var data: Data? = nil
        var error: Swift.Error? = NSError(domain: "", code: 0, userInfo: [:])
        var response: HTTPURLResponse? = nil
        
        
        var request = request
        let authoriation = request.value(forHTTPHeaderField: "Authorization")
        request.setValue(nil, forHTTPHeaderField: "Authorization")
        
        switch request {
            
            // MARK: - LoginRequest
            
        case LoginRequest(username: "", password: "").urlRequest:
            struct Resource: Codable {
                struct User: Codable {
                    let username: String
                    let password: String
                }
                let users: [User]
            }
            
            let resource = bundleLoad(resource: "UserCredentials", type: Resource.self)
            
            let user = resource.users.first {
                request.isEqual(LoginRequest(username: $0.username, password: $0.password).urlRequest)
            }
            
            if let user = user {
                data = try! token(user.username).jsonEncode()
                response = Response.success(request.url!)
                error = nil
            } else {
                data = try! [
                    "error" : "invalid_grant",
                    "error_description" : "Invalid user credentials"
                    ].jsonEncode()
                response = Response.unauthorized(request.url!)
                error = nil
            }
            
            // MARK: - RefreshSessionRequest
            
        case RefreshSessionRequest(refreshToken: "").urlRequest:
            struct Resource: Codable {
                let refresh_token: String
            }
            
            let resource = try! Resource.jsonDecode(request.httpBody!)
            
            guard let authorized = refreshSession(resource.refresh_token) else {
                let message = "Session expired"
                data = try! ServerResponse<String>(data: nil, error: true, message: message).jsonEncode()
                response = Response.unauthorized(request.url!)
                error = nil
                break
            }
            
            data = try! token(authorized.username, sessionId: authorized.sessionId).jsonEncode()
            response = Response.success(request.url!)
            error = nil
            
            // MARK: - ProfileRequest
            
        case UserProfileRequest().urlRequest:
            struct Resource: Codable, Equatable {
                let users: [UserProfile]
            }
            
            guard let authorized = authorization(authoriation!) else {
                return unauthorizedResposnse(request, completionHandler)
            }
            
            let resource = bundleLoad(resource: "UserProfiles", type: Resource.self)
            
            if let user = resource.users.first(where: { $0.username == authorized.username }) {
                data = try! user.jsonEncode()
                response = Response.success(request.url!)
                error = nil
            } else {
                let message = "Something bad happen..."
                data = try! ServerResponse<String>(data: nil, error: true, message: message).jsonEncode()
                response = Response.internalServerErrpr(request.url!)
                error = nil
            }
            
            
        case PracticeGroupRequest().urlRequest:
            guard authorization(authoriation!) != nil else {
                return unauthorizedResposnse(request, completionHandler)
            }
            
            let resource = bundleLoad(resource: "PracticeGroups", type: PracticeGroupEnvelope.self)
            
            data = try! resource.jsonEncode()
            response = Response.success(request.url!)
            error = nil
            
        case KanaCharactersRequest().urlRequest:
            let resource = bundleLoad(resource: "KanaCharacters", type: KanaCharacters.self)
            
            data = try! resource.jsonEncode()
            response = Response.success(request.url!)
            error = nil
            
        default:
            break
        }
        
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
    
    func unauthorizedResposnse(_ request: URLRequest, _ completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
        let message = "Request unauthorized"
        return URLSessionDataTaskMock {
            completionHandler(
                try! ServerResponse<String>(data: nil, error: true, message: message)
                    .jsonEncode(),
                Response.unauthorized(request.url!),
                nil)
        }
    }
}

// MARK: - URLSessionDataTask

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.closure()
        }
    }
}

fileprivate extension URLRequest {
    func isEqual(_ object: URLRequest) -> Bool {
        return object.url == self.url
            && object.mainDocumentURL == self.mainDocumentURL
            && object.httpMethod == self.httpMethod
            && object.cachePolicy == self.cachePolicy
            && object.httpBodyStream == self.httpBodyStream
            && object.allowsCellularAccess == self.allowsCellularAccess
            && object.httpShouldHandleCookies == self.httpShouldHandleCookies
            && object.httpBody == self.httpBody
//            && object.allHTTPHeaderFields == self.allHTTPHeaderFields
    }
}

fileprivate func token(_ username: String, sessionId: String? = nil) -> Token {
    let expireIn = accessTokenExpireIn
    let refreshExpireIn = refreshTokenExpireIn
    let now = Date()
    
    let sessionId = sessionId ?? UUID().uuidString
    
    let prepare: (String, Int) -> String = {
        [
            $0,
            Date(timeInterval: Double($1), since: now).iso8601WithFractionalSeconds,
            username,
            sessionId,
        ].joined(separator: "&")
    }
    
    return Token(
        accessToken: prepare("AccessToken", expireIn),
        expiresIn: expireIn,
        refreshExpiresIn: refreshExpireIn,
        refreshToken: prepare("RefreshToken", refreshExpireIn),
        tokenType: "Bearer",
        notBeforePolicy: 0,
        sessionState: sessionId
    )
}

fileprivate typealias Authorization = (username: String, sessionId: String)

fileprivate func authorization(_ token: String) -> Authorization? {
    verifyToken(token, tokenType: "AccessToken")
}

fileprivate func refreshSession(_ token: String) -> Authorization? {
    verifyToken(token, tokenType: "RefreshToken")
}

fileprivate func verifyToken(_ token: String, tokenType: String) -> Authorization? {
    let tokenComponents = token.split(separator: "&")
    
    guard tokenComponents.count == 4, tokenComponents[0] == tokenType else {
        return nil
    }
    
    let formatter = Formatter.iso8601WithFractionalSeconds
    if let date = formatter.date(from: String(tokenComponents[1])), date > Date() {
        return (String(tokenComponents[2]), String(tokenComponents[3]))
    } else {
        return nil
    }
}


