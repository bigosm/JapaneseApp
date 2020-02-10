//
//  Question.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Question: Codable, Equatable {

    public let prompt: String
    public let subject: [Subject]
    public let answer: [String]
    
}
