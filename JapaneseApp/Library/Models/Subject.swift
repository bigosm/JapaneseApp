//
//  Subject.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Subject: Equatable {
    
    public enum WordType: String, Codable, Equatable {
        case noun
        case particle
        case verb
    }
    
    // MARK: - Instance Properties
    
    let id: String
    let value: String
    let readingAid: String?
    let altNotation: String?
    let audio: String?
    let meaning: [String]?
    let type: WordType?
    let category: String?
    
}

// MARK: - Codable

extension Subject: Codable {

    private enum CodingKeys: String, CodingKey {
        case id, value, readingAid, altNotation, audio, meaning, type, category
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.value = try values.decode(String.self, forKey: .value)
        self.readingAid = try values.decodeIfPresent(String.self, forKey: .readingAid)
        self.altNotation = try values.decode(String.self, forKey: .altNotation)
        self.audio = try values.decodeIfPresent(String.self, forKey: .audio)
        
        self.meaning = try values.decodeIfPresent([String].self, forKey: .meaning)
        if let decodedWordType = try values.decodeIfPresent(String.self, forKey: .type) {
            self.type = WordType(rawValue: decodedWordType)
        } else {
            self.type = nil
        }
        self.category = try values.decodeIfPresent(String.self, forKey: .category)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(value, forKey: .value)
        try container.encodeIfPresent(readingAid, forKey: .altNotation)
        try container.encode(altNotation, forKey: .altNotation)
        try container.encodeIfPresent(audio, forKey: .audio)
        
        try container.encodeIfPresent(meaning, forKey: .meaning)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encodeIfPresent(category, forKey: .category)
    }
}
