//
//  QuestionGroupBuilder.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 09/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionGroupBuilder {
    
    // MARK: - Instance Properties
    
    public var questions = [QuestionBuilder()]
    public var title = ""
    
    // MARK: - Instance Methods
    
    public func addNewQuestion() {
        let question = QuestionBuilder()
        self.questions.append(question)
    }
    
    public func removeQuestion(at index: Int) {
        self.questions.remove(at: index)
    }
    
    public func build() throws -> QuestionGroup {
        guard !self.title.isEmpty else { throw Error.missingTitle }
        guard !self.questions.isEmpty else { throw Error.missingQuestion }
        
        let questions = try self.questions.map { try $0.build() }
        return QuestionGroup(questions: questions, title: self.title)
    }
    
    public enum Error: String, Swift.Error {
        case missingTitle
        case missingQuestion
    }
}

public class QuestionBuilder {
    
    public var answer = ""
    public var hint = ""
    public var prompt = ""
    
    public func build() throws -> Question {
        guard !self.answer.isEmpty else { throw Error.missingAnswer }
        guard !self.prompt.isEmpty else { throw Error.missingPrompt }
        
        return Question(answer: self.answer, hint: self.hint ,prompt: self.prompt)
    }
    
    public enum Error: String, Swift.Error {
        case missingAnswer
        case missingPrompt
    }
}
