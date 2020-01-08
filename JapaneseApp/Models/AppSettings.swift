//
//  AppSettings.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class AppSettings {
    
    // MARK: - Keys
    
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
    
    // MARK: - Static Properties
    
    public static let shared = AppSettings()
    
    // MAK: - Instance Properties
    
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = self.userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            self.userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Object Lifecycle
    
    private init() { }
    
    // MARK: - Instance Methods
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        return self.questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }

}

//MARK: - QuestionStrategyType

public enum QuestionStrategyType: Int, CaseIterable {
    
    case random
    case sequential
    
    // MARK: - Instance Methods
    
    public var title: String {
        switch self {
        case .random: return "Random"
        case .sequential: return "Sequential"
        }
    }
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        switch self {
        case .random: return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        case .sequential: return SequentionalQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        }
    }

}
