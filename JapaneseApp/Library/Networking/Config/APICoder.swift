//
//  APICoder.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol APIDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, contentType: ContentType) throws -> T
}

protocol APIEncoder {
    func encode<T: Encodable>(_ object: T, contentType: ContentType) throws -> Data
}

class DecoderManager: APIDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, contentType: ContentType = .json) throws -> T {
        switch contentType {
        case .json:
            return try JSONDecoder.iso8601withOptionalFractionalSeconds.decode(type, from: data)
        case .formURLEncoded:
            fatalError("Decoder not exists.")
        }
    }
}

class EncoderManager: APIEncoder {
    func encode<T: Encodable>(_ object: T, contentType: ContentType = .json) throws -> Data {
        switch contentType {
        case .json:
            return try JSONEncoder.iso8601withFractionalSeconds.encode(object)
        case .formURLEncoded:
            return try formURLEncode(object)
        }
    }

    func formURLEncode<T: Encodable>(_ object: T) throws -> Data {
        let data = try encode(object, contentType: .json)
        let escapedOpt = try [String: String].jsonDecode(data)
            .map { String(format: "%@=%@", $0, $1) }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        guard let escaped = escapedOpt else {
            throw NSError(domain: "Failed '.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)'", code: 0, userInfo: [:])
        }
        
        return escaped.data(using: .utf8)!
    }
}
