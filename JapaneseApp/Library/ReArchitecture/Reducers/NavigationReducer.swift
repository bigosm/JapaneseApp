//
//  NavigationReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    switch action {
    case PracticeAction.cancel:
        return NavigationState(currentView: .practiceOverview)
    case PracticeAction.startPractice(_):
        return NavigationState(currentView: .practice)
    default:
        return state ?? NavigationState(currentView: .practiceOverview)
    }
}
