//
//  Question.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct AnyQuestion: Equatable {
    public static func == (lhs: AnyQuestion, rhs: AnyQuestion) -> Bool {
        return lhs.equals(rhs)
    }
    
    let value: QuestionType
    private let equals: (AnyQuestion) -> Bool
    
    public init<T: QuestionType & Equatable>(_ value: T) {
        self.value = value
        self.equals = { $0 as? T == value }
    }
}

public protocol QuestionType {
    var prompt: String { get }
    var correctAnswerList: [String] { get }
    var answerFeed: [String] { get }
    var answer: String? { get }
    var isCorrect: String? { get }
}

public protocol SubjectQuestionType: QuestionType {
    var subject: Subject { get }
}

public protocol PhraseQuestionType: QuestionType {
    var phrase: Phrase { get }
}

public struct MatchSoundToCharacter: SubjectQuestionType, Equatable {
    public let prompt: String
    public let correctAnswerList: [String]
    public var answerFeed: [String]
    public let answer: String?
    public let isCorrect: String?
    public let subject: Subject
}

public struct RomajiNotation: SubjectQuestionType, Equatable {
    public let prompt: String
    public let correctAnswerList: [String]
    public var answerFeed: [String]
    public let answer: String?
    public let isCorrect: String?
    public let subject: Subject
}

public struct WordMeaning: SubjectQuestionType, Equatable {
    public let prompt: String
    public let correctAnswerList: [String]
    public var answerFeed: [String]
    public let answer: String?
    public let isCorrect: String?
    public let subject: Subject
}

public struct TranslateWord: SubjectQuestionType, Equatable {
    public let prompt: String
    public let correctAnswerList: [String]
    public var answerFeed: [String]
    public let answer: String?
    public let isCorrect: String?
    public let subject: Subject
}

//public struct WordMeaning: PhraseQuestionType, Equatable {
//    public var prompt: String
//    public let correctAnswerList: [String]
//    public let answer: String?
//    public let isCorrect: String?
//    public let phrase: Phrase
//}
