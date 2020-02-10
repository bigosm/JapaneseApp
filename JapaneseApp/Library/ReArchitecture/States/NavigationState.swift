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
    
    public enum CurrentView: Equatable {
        case practiceOverview
        case practice
    }
    
    public let currentView: CurrentView
}
