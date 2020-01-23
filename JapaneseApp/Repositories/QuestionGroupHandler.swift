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
    public var questionGroupAnswersData: QuestionGroupAnswersData
    
    // MARK: - Object Lifecycle
    
    init(questionGroup: QuestionGroup, answersData: QuestionGroupAnswersData) {
        self.questionGroup = questionGroup
        self.questionGroupAnswersData = answersData
        self.questionGroupAnswers = QuestionGroupAnswers(questionAnswers: [])
        self.questionGroupAnswersData.current = self.questionGroupAnswers
    }

}
