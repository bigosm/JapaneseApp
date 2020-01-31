//
//  ExperienceService.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 23/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation


public class ExperienceService {
    
    // MARK: - Class Properties
    
    public static let shared = ExperienceService()
    
    // MARK: - Instance Properties
    
    public var hiraganaCharExp = 1
    public var katakanaCharExp = 1
    public var kanjiCharExp = 2
    
    // MARK: - Object Lifecycle
    
    private init() { }
    
    // MARK: - Instance Methods
    
    public func experience(forQuestion question: Question) -> Int {
        let hiraganaCharacters = question.answer.numberOfHiraganaCharacters
            + question.subject.numberOfHiraganaCharacters
        
        let katakanaCharacters = question.answer.numberOfKatakanaCharacters
            + question.subject.numberOfKatakanaCharacters
        
        let kanjiCharacters = question.answer.numberOfKanjiCharacters
            + question.subject.numberOfKanjiCharacters
        
        return hiraganaCharacters * self.hiraganaCharExp
            + katakanaCharacters  * self.katakanaCharExp
            + kanjiCharacters * self.kanjiCharExp
    }
    
    public func experience(forQuestions questions: [Question]) -> Int {
        return questions.reduce(into: 0) { $0 += self.experience(forQuestion: $1) }
    }
    
    public func experience(forQuestionAnswers questionAnswers: [QuestionAnswer]) -> Int {
        return questionAnswers.reduce(into: 0) { $0 += self.experience(forQuestionAnswer: $1) }
    }
    
    public func experience(forQuestionAnswer questionAnswer: QuestionAnswer) -> Int {
        return self.experience(forQuestion: questionAnswer.question) * (questionAnswer.isCorrect ? 1 : 0)
    }
    
}
