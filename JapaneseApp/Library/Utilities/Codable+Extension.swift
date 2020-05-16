//
//  Codable+Extension.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 15/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

extension Decodable {
    static func jsonDecode(_ data: Data) throws -> Self {
        return try JSONDecoder.iso8601withOptionalFractionalSeconds.decode(Self.self, from: data)
    }
}

extension Encodable {
    func jsonEncode() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
