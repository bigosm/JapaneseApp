//
//  URLSessionMock.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    
    override init() {}
    
    typealias CompletionHandler = (Data?, URLResponse?, Swift.Error?) -> Void

    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        
        let successResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
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
            
            let isAuthorized = resource.users.contains {
                request.isEqual(LoginRequest(username: $0.username, password: $0.password).urlRequest)
            }
            
            if isAuthorized {
                data = try? "login".jsonEncode()
                response = successResponse
                error = nil
            } else {
                data = try! [
                    "error" : "invalid_grant",
                    "error_description" : "Invalid user credentials"
                    ].jsonEncode()
                response = HTTPURLResponse(url: request.url!, statusCode: 401, httpVersion: nil, headerFields: [:])
                error = nil
            }
        default:
            break
        }
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
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
            && object.allHTTPHeaderFields == self.allHTTPHeaderFields
    }
}
