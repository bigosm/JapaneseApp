//
//  APIRequest.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol APIRequest: Equatable {
    associatedtype Response: Decodable
    associatedtype Body: Encodable

    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var resource: String { get }
    var contentType: ContentType { get }
    var responseContentType: ContentType { get }
    var requiresAuth: Bool { get }
    var params: [URLQueryItem]? { get }
    var body: Body? { get }
}

extension APIRequest {
    var urlRequest: URLRequest {
        guard let url = URL(string: resource, relativeTo: baseURL) else {
            fatalError("Bad Resource: \(resource)")
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            fatalError("Failed to create components from url: \(url)")
        }
        
        components.queryItems = params
        
        guard let composedURL = components.url else {
            fatalError("Failed to create url from components: \(components)")
        }
        
        var urlRequest = URLRequest(url: composedURL)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                urlRequest.httpBody = try NetworkConfig.encoder.encode(body, contentType: contentType)
            } catch {
                assertionFailure("Failed to encode request body with contentType: '\(contentType)', Error: \(error)")
            }
        }
        
        return urlRequest
    }
}
