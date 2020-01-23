//
//  QuestionGroup.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    
    // MARK: - Instance Properties
    
    public let id: String
    public let title: String
    
    public let questions: [Question]
    public let questionLevel: Int = 0
    
    public init (questions: [Question],
                 title: String) {
        self.id = UUID().uuidString
        self.questions = questions
        self.title = title
    }

}


