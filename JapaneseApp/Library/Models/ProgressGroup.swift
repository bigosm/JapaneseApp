//
//  ProgressGroup.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct ProgressGroup: Codable, Equatable {
    let levels: [String: Progress]
    let hiragana: [String: Progress]
    let katakana: [String: Progress]
    let kanji: [String: Progress]
    let vocabulary: [String: Progress]
    let phrase: [String: Progress]
}
