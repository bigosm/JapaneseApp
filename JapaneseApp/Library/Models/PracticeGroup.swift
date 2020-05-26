//
//  QuestionGroup.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct PracticeGroup: Equatable {
    let id: String
    let title: String
    let groupImage: String
    let type: PracticeType?
    let requirements: [String]
    let progress: ProgressGroup
    let levels: [PracticeLevel]
}

extension PracticeGroup: Codable {

    private enum CodingKeys: String, CodingKey {
        case id, title, groupImage, type, requirements, levels, progress
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.groupImage = try values.decode(String.self, forKey: .groupImage)
        if let decoded = try values.decodeIfPresent(String.self, forKey: .type) {
            self.type = PracticeType(rawValue: decoded)
        } else {
            self.type = nil
        }
        self.requirements = try values.decode([String].self, forKey: .requirements)
        self.progress = try values.decode(ProgressGroup.self, forKey: .progress)
        self.levels = try values.decode([PracticeLevel].self, forKey: .levels)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(groupImage, forKey: .groupImage)
        try container.encodeIfPresent(type?.rawValue, forKey: .type)
        try container.encode(requirements, forKey: .requirements)
        try container.encode(progress, forKey: .progress)
        try container.encode(levels, forKey: .levels)
    }
}
