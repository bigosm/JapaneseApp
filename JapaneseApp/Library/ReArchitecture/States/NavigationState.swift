//
//  NavigationState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct NavigationState: StateType, Equatable {
    
    public enum View: Equatable {
        case practiceOverview
        case practice
        case practiceCompletion
    }
    
    public let currentView: View
    public let previousView: View?
    public let routeToView: View?
    
}
