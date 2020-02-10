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
    case RepositoryAction.selectPracticeGroupAtIndex(let index):
        return RepositoryState(
            characterTables: state.characterTables,
            vocabulary: state.vocabulary,
            practiceGroups: state.practiceGroups,
            selectedPracticeGroup: state.practiceGroups[index]
        )
    case let startPractice as ViewHistory:
        print("[RepositoryReducer] View history for question group: \(startPractice.practiceGroup.title)")
    default: ()
    }
    return state
}
