//
//  NextQuestionMiddleware.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 20/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal let nextQuestionMiddleware: Middleware<AppState> = { dispatch, getState in
    return { next in
        return { action in
            guard case CurrentPracticeAction.nextQuestion = action else {
                return next(action)
            }
                
            guard let state = getState()?.practiceState,
                case .inProgress(let practiceGroup) = state.current,
                let practice = state.practice else {
                    print("Something went wrong... Looks like state is not \"nextQuestion\" compatibile.")
                    return
            }
                
            return practice.currentQuestionIndex >= practice.questions.count - 1
                ? next(PracticeAction.complete(practiceGroup))
                : next(action)
        }
    }
}
