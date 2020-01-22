//
//  QuestionScore.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 20/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroupHandler: Codable {
    
    // MARK: - Instance Properites
    
    public var questionGroup: QuestionGroup
    public var questionGroupAnswers: QuestionGroupAnswers
    
    // MARK: - Object Lifecycle
    
    init(questionGroup: QuestionGroup, answers: QuestionGroupAnswers) {
        self.questionGroup = questionGroup
        self.questionGroupAnswers = answers
    }

}
