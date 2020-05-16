//
//  URLRequest+debugDescription.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension URLRequest {
    var debugDescription: String {
        var headers = allHTTPHeaderFields ?? [:]
        
        if headers["Authorization"] != nil && NetworkConfig.shouldLogAuthorizationHeader {
            headers["Authorization"] = "Secret"
        }
        
        let preparedHeaders = try? NetworkConfig.encoder.encode(headers, contentType: .json).debugDescription
        let _url = "🔹 \(httpMethod ?? "nil") - \(url?.relativeString ?? "nil")\n"
        let _headers = "🔹 headers: \(preparedHeaders ?? "nil")\n"
        let _body = "🔹 body: \(httpBody?.debugDescription ?? "nil")"
        return _url + _headers + _body
    }
}
