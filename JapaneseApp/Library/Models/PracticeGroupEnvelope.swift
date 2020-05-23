//
//  PracticeGroupEnvelope.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct PracticeGroupEnvelope: Codable, Equatable {
    let hiragana: [PracticeGroup]
    let katakana: [PracticeGroup]
    let kanji: [PracticeGroup]
    let vocabulary: [PracticeGroup]
    let phrase: [PracticeGroup]
}
