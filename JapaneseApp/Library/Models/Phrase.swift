//
//  Phrase.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Phrase: Codable, Equatable {
    
    public let value: [Subject]
    public let audio: String?
    public let meaning: [String]?
    
}
