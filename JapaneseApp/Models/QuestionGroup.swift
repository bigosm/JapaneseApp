//
//  QuestionGroup.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    
    public class Score: Codable {
        
        public var correctCount: Int = 0 {
            didSet { self.updaRunningPercentage() }
        }
        public var incorrectCount: Int = 0 {
            didSet { self.updaRunningPercentage() }
        }
        public lazy var runningPercentage = Observable(self.calculateRunningPercentage())
        
        public init() { }
        
        public func reset() {
            self.correctCount = 0
            self.incorrectCount = 0
        }
        
        private func updaRunningPercentage() {
            self.runningPercentage.value = self.calculateRunningPercentage()
        }
        
        private func calculateRunningPercentage() -> Double {
            let totalCount = self.correctCount + self.incorrectCount
            guard totalCount > 0 else {
                return 0
            }
            
            return Double(self.correctCount) / Double(totalCount)
        }
        
    }
    
    public let questions: [Question]
    public let title: String
    public private(set) var score: Score
    
    public init (questions: [Question],
                 score: Score = Score(),
                 title: String) {
        
        self.questions = questions
        self.score = score
        self.title = title
    }

}


