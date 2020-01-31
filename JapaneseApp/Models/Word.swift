//
//  Word.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Word: Writable {
    
    public enum WordType: String, Codable {
        case noun
        case particle
        case verb
    }
    
    // MARK: - Instance Properties
    
    public let id: String
    public let value: String
    public let kanaNotation: String?
    public let romajiNotation: String
    public let audio: String?
    
    public let meaning: String
    public let type: WordType?
    
}

// MARK: - Codable

extension Word: Codable {

    private enum CodingKeys: String, CodingKey {
        case id, value, kanaNotation, romajiNotation, audio, meaning, type
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.value = try values.decode(String.self, forKey: .value)
        self.kanaNotation = try values.decodeIfPresent(String.self, forKey: .kanaNotation)
        self.romajiNotation = try values.decode(String.self, forKey: .romajiNotation)
        self.audio = try values.decode(String.self, forKey: .audio)
        
        self.meaning = try values.decode(String.self, forKey: .meaning)
        let decodedWordType = try values.decode(String.self, forKey: .type)
        self.type = WordType(rawValue: decodedWordType)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(value, forKey: .value)
        try container.encodeIfPresent(kanaNotation, forKey: .kanaNotation)
        try container.encode(romajiNotation, forKey: .romajiNotation)
        try container.encodeIfPresent(audio, forKey: .audio)
        
        try container.encode(meaning, forKey: .type)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
    }
}
