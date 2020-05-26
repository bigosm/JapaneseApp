//
//  QuestionLevel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct PracticeLevel: Codable, Equatable {
    let id: String
    let level: Int
    let requirements: [String]
    let hiragana: [String]
    let katakana: [String]
    let kanji: [String]
    let vocabulary: [String]
    let phrase: [String]
}
