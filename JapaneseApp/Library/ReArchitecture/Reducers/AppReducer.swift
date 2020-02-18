//
//  AppReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        navigationState: navigationReducer(action: action, state: state?.navigationState),
        repositoryState: repositoryReducer(action: action, state: state?.repositoryState),
        practiceState: practiceReducer(action: action, state: state?.practiceState),
        studentState: studentReducer(action: action, state: state?.studentState)
    )
}
