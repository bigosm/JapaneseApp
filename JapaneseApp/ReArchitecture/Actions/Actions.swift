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

public struct StartPractice: Action {
    let questionGroup: QuestionGroup
}
public struct StartTimedPractice: Action {
    let questionGroup: QuestionGroup
}
public struct ViewHistory: Action {
    let questionGroup: QuestionGroup
}
