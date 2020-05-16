//
//  APIClient.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension URLSession {
    
    enum Error: LocalizedError {
        case invalidResponse
        case server(statusCode: Int, message: String)
        
        var errorDescription: String? {
            switch self {
            case .invalidResponse: return "Invalid server response."
            case .server(_, let message): return message
            }
        }
    }
    
    func request<T: APIRequest>(_ request: T) -> APIClientTask<T.Response?> {
        let promise = Promise<T.Response?>()
        let urlRequest = request.urlRequest
        let uuid = UUID()
        
        NetworkConfig.logger?.info("[✈️ \(type(of: self))] [\(uuid)] Request: \n\(urlRequest.debugDescription)")
   
        let task = dataTask(with: urlRequest) { [weak self] data, response, error in
            
            if let error = error {
                NetworkConfig.logger?.error("[📬 \(type(of: self))] [\(uuid)] Response: Error \(error)")
                promise.reject(with: error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = Error.invalidResponse
                NetworkConfig.logger?.error("[📬 \(type(of: self))] [\(uuid)] Response: Error \(error)")
                promise.reject(with: error)
                return
            }
            
            guard let data = data else {
                if httpResponse.statusCode == 204 {
                    NetworkConfig.logger?.success("[📬 \(type(of: self))] [\(uuid)] Response: Success, No content")
                    promise.resolve(with: .none)
                } else {
                    let error = Error.server(statusCode: httpResponse.statusCode, message: "No content")
                    NetworkConfig.logger?.error("[📬 \(type(of: self))] [\(uuid)] Response: Error \(error)")
                    promise.reject(with: error)
                }
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                
                do {
                    let decoded = try NetworkConfig.decoder.decode(T.Response.self, from: data, contentType: request.responseContentType)
                    NetworkConfig.logger?.success("[📬 \(type(of: self))] [\(uuid)] Response: Success")
                    promise.resolve(with: decoded)
                } catch {
                    NetworkConfig.logger?.error("[📬 \(type(of: self))] [\(uuid)] Response: Error \(error)")
                    promise.reject(with: error)
                }
            default:
                let result = NetworkConfig.errorDecoder(data)
                
                if let decodedError = result.decodedError {
                    let error = Error.server(statusCode: httpResponse.statusCode, message: decodedError.localizedDescription)
                    NetworkConfig.logger?.error("[📬 \(type(of: self))] [\(uuid)] Response: Error \(error)")
                    promise.reject(with: error)
                } else if let errors = result.errors {
                    errors.forEach { NetworkConfig.logger?.error($0) }
                    promise.reject(with: Error.invalidResponse)
                } else {
                    let error = Error.invalidResponse
                    NetworkConfig.logger?.error("[📬 \(type(of: self))] [\(uuid)] Response: Error \(error)")
                    promise.reject(with: error)
                }
            }
        }

        return APIClientTask(task: task, id: uuid, promise: promise)
    }
    

}
