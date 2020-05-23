//
//  CharacterTable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct KanaCharacters: Codable, Equatable {
    public let hiragana: [Subject]
    public let katakana: [Subject]
}
