//
//  QuestionGroup.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    
    public let questions: [Question]
    public let title: String
    
    public init (questions: [Question],
                 title: String) {
        
        self.questions = questions
        self.title = title
    }

}


