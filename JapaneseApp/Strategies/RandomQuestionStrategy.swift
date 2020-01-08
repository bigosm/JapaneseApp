//
//  RandomQuestionStrategy.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy {

    // MARK: - Object Lifecycle
    
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }

}
