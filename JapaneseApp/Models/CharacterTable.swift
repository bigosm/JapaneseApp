//
//  CharacterTable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct CharacterTable: Codable {

    public enum TableType: String, Codable {
        case hiragana
        case katakana
    }
    
    // MARK: - Instance Properties
    
    public var title: String { return self.type.rawValue.capitalized }
    public var type: TableType
    public var characters: [Character]

    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case type, characters
    }
    
    enum CharacterTableCodingError: Error {
        case decoding(String)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let decodedTableType = try values.decode(String.self, forKey: .type)
        
        guard let type = CharacterTable.TableType(rawValue: decodedTableType) else {
            throw CharacterTableCodingError.decoding("Table type not supported")
        }
        
        self.type = type
        self.characters = try values.decode([Character].self, forKey: .characters)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(characters, forKey: .characters)

    }
    
}
