//
//  RepositoryReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func repositoryReducer(action: Action, state: RepositoryState?) -> RepositoryState {
    
    let state = state ?? .initial
    
    switch action {
    case RepositoryAction.selectQuestionGroupAtIndex(let index):
        return RepositoryState(
            characterTables: state.characterTables,
            vocabulary: state.vocabulary,
            questionGroups: state.questionGroups,
            selectedQuestionGroup: state.questionGroups[index]
        )
    case let startPractice as ViewHistory:
        print("[RepositoryReducer] View history for question group: \(startPractice.questionGroup.title)")
    default: ()
    }
    return state
}
