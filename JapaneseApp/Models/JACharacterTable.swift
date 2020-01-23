//
//  CharacterTable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 13/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct JACharacterTable: Codable {

    public enum TableType: String, Codable {
        case hiragana
        case katakana
    }
    
    // MARK: - Instance Properties
    
    public var title: String { return self.tableType.rawValue.capitalized }
    public var tableType: TableType
    public var characters: [JACharacter]

    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case tableType, characters
    }
    
    enum CharacterTableCodingError: Error {
        case decoding(String)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let decodedTableType = try values.decode(String.self, forKey: .tableType)
        
        guard let tableType = JACharacterTable.TableType(rawValue: decodedTableType) else {
            throw CharacterTableCodingError.decoding("TableType not supported")
        }
        
        self.tableType = tableType
        self.characters = try values.decode([JACharacter].self, forKey: .characters)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tableType.rawValue, forKey: .tableType)
        try container.encode(characters, forKey: .characters)

    }
    
}
