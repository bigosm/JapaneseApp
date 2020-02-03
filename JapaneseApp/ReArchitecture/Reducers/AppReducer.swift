//
//  AppReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        repositoryState: repositoryReducer(action: action, state: state?.repositoryState),
        studentState: studentReducer(action: action, state: state?.studentState)
    )
}
