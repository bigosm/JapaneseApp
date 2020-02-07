//
//  CurrentlyPracticeState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct PracticeState: StateType, Equatable {

    public enum Current: Equatable {
        case noPractice
        case inProgress(QuestionGroup)
    }
    
    public var current: Current = .noPractice
    public var isReadingAidVisible = false
    
}
