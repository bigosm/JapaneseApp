//
//  Question.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public enum Question: Equatable {
    case sentenceMeaning(prompt: String, phrase: Phrase, answers: [String])
    case translateMeaning(prompt: String, subject: String, answers: [Subject])
}
