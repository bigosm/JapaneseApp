//
//  SequentionalQuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class SequentionalQuestionStrategy: BaseQuestionStrategy {
    
    // MARK: - Object Lifecycle
    
    public convenience init(questionGroupHandler: QuestionGroupHandler) {
        
        let questionGroup = questionGroupHandler.questionGroup
        let questions = questionGroup.questions
        
        self.init(questionGroupHandler: questionGroupHandler, questions: questions)
    }
}
