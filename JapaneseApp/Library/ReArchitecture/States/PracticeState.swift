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
        case inProgress(PracticeGroup)
    }
    
    public var current: Current = .noPractice
    public var numberOfQuestions = 10
    public var currentQuestion: PracticeGroup?
    public var isReadingAidVisible = false
    public var hasReadingAid: Bool {
        guard case .inProgress(_) = self.current else {
            return false
        }
        
        return true
    }
    
}
