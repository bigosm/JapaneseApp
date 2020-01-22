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
    
    // MARK: - Instance Properties
    
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
    
    public func questionStrategy(for questionGroupHandler: QuestionGroupHandler) -> QuestionStrategy {
        return self.questionStrategyType.questionStrategy(for: questionGroupHandler)
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
    
    public func questionStrategy(for questionGroupHandler: QuestionGroupHandler) -> QuestionStrategy {
        switch self {
        case .random: return RandomQuestionStrategy(questionGroupHandler: questionGroupHandler)
        case .sequential: return SequentionalQuestionStrategy(questionGroupHandler: questionGroupHandler)
        }
    }

}
