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
    guard let state = state else {
        return NavigationState(
            currentView: .practiceOverview,
            previousView: nil,
            routeToView: .practiceOverview
        )
    }
    switch action {
    case PracticeAction.cancel:
        return NavigationState(
            currentView: .practiceOverview,
            previousView: state.currentView,
            routeToView: .practiceOverview
        )
    case PracticeAction.startPractice(_):
        return NavigationState(
            currentView: .practice,
            previousView: state.previousView,
            routeToView: .practice
        )
    default:
        return state
    }
}
