//
//  Actions.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct SelectQuestionGroup: Action {
    let indexOf: Int
}

public struct ViewHistory: Action {
    let practiceGroup: PracticeGroup
}

public enum PracticeAction: Action {
    case cancel
    case startPractice(PracticeGroup)
    case startTimePractice(PracticeGroup)
}

public enum CurrentPracticeAction: Action {
    case answer(String?)
    case checkAnswer
    case answerState(isCorrect: Bool, correctAnswer: String?, meaning: String?)
    case nextQuestion
    case toggleReadingAid
}

public enum RepositoryAction: Action {
    case selectPracticeGroupAtIndex(Int)
}
