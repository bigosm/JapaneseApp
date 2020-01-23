//
//  QuestionGroupAnswersData.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroupAnswersData: Codable {
    
    // MARK: - Instance Properties
    
    public var questionGroupId: String
    public var questionGroupAnswers: [QuestionGroupAnswers]
    public var current: QuestionGroupAnswers?
    
    // MARK: - Object Lifecycle
    
    init(questionGroupId: String, quesionGroupAnswers: [QuestionGroupAnswers]) {
        self.questionGroupId = questionGroupId
        self.questionGroupAnswers = quesionGroupAnswers
    }
    
}
