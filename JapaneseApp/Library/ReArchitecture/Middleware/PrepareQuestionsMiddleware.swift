//
//  PrepareQuestionsMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 28/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal let prepareQuestionsMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            switch action {
            case PracticeAction.preparePractice(let practiceGroup):
                let questions = QuestionFactory(practiceGroup: practiceGroup, level: 1).prepare()
                return next(PracticeAction.startPractice(questions))
                
            case PracticeAction.prepareTimePractice(let practiceGroup):
                let questions = QuestionFactory(practiceGroup: practiceGroup, level: 1).prepare()
                return next(PracticeAction.startTimePractice(questions))
                
            default:
                return next(action)
            }
        }
    }
}

//
