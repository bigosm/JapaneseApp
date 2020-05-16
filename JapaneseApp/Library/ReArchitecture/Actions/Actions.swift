//
//  Actions.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public enum UserSessionAction: Action {
    case logout
    case login(UserSession)
    case tryLogin(username: String, password: String)
    case loginAttemptFailed(Error)
    case loginRequestInProcess
}

public struct SelectQuestionGroup: Action {
    let indexOf: Int
}

public struct ViewHistory: Action {
    let practiceGroup: PracticeGroup
}

public enum PracticeAction: Action {
    case cancel
    case preparePractice(PracticeGroup)
    case prepareTimePractice(PracticeGroup)
    case startPractice([AnyQuestion])
    case startTimePractice([AnyQuestion])
    case complete
    case selectPracticeAnswerAtIndex(Int)
    case finish
    
}

public enum CurrentPracticeAction: Action {
    case answer(String?)
    case answerAt(Int)
    case checkAnswer
    case answerState(AnswerCheck)
    case nextQuestion
    case toggleReadingAid
}

public enum RepositoryAction: Action {
    case selectPracticeGroupAtIndex(Int)
}
