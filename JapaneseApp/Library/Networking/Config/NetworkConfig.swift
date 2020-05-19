//
//  NetworkConfig.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

class NetworkConfig {
    
    enum BaseURL {
        static let standard = URL(string: "http://exmaple.com/")!
    }
    
    // MARK: - Logger
    
    struct Logger {
        typealias LoggerFunc = (Any) -> Void
        let warning: LoggerFunc
        let error: LoggerFunc
        let success: LoggerFunc
        let info: LoggerFunc
    }
    
    static var shouldLogAuthorizationHeader = true
    static var logger: Logger? = Logger(
        warning: Log.warning,
        error: Log.error,
        success: Log.success,
        info: Log.info)
    
    // MARK: - Coder
    
    typealias ErrorDecoderResult = (decodedError: NetwrokErrorContainer?, errors: [Error]?)

    static var decoder: APIDecoder = DecoderManager()
    static var encoder: APIEncoder = EncoderManager()

    static var errorDecoder: (Data) -> ErrorDecoderResult = { data in
        var errors: [Error] = []

        if let success = decodedError(type: LoginErrorContainer.self, data: data, errors: &errors) {
            return (success, nil)
        } else if let success = decodedError(type: ServerResponse<String>.self, data: data, errors: &errors) {
            return (success, nil)
        } else {
            return (nil, errors)
        }
    }
    
    private static func decodedError<T: NetwrokErrorContainer>(type: T.Type, data: Data, errors: inout [Error]) -> NetwrokErrorContainer? {
        do {
            return try NetworkConfig.decoder.decode(type, from: data, contentType: .json)
        } catch {
            errors.append(error)
            return nil
        }
    }
}
