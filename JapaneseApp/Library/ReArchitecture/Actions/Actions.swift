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
    let questionGroup: QuestionGroup
}

public enum PracticeAction: Action {
    case cancel
    case toggleReadingAid
    case startPractice(QuestionGroup)
    case startTimePractice(QuestionGroup)
}

public enum RepositoryAction: Action {
    case selectQuestionGroupAtIndex(Int)
}
