//
//  QuestionRepository.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionRepository {
    
    // MARK: - Instance Properties
    
    private let appSettings = AppSettings.shared
    private let questionGroupCaretaker: QuestionGroupCaretaker
    private let questionGroupAnswersCaretaker: QuestionGroupAnswersCaretaker
    
    // MARK: - Object Lifecycle
    
    init() {
        self.questionGroupCaretaker = QuestionGroupCaretaker()
        self.questionGroupAnswersCaretaker = QuestionGroupAnswersCaretaker(
            questionGroups: self.questionGroupCaretaker.questionGroups)
    }
    
    // MARK: - Instance Methods
    
    public func addNewQuestionGroup(_ questionGroup: QuestionGroup) {
        self.questionGroupCaretaker.questionGroups.append(questionGroup)
        try? self.questionGroupCaretaker.save()
    }
    
    public func level(forQuestionGroupAt index: Int) -> Int {
        self.questionGroupCaretaker.questionGroups[index].questionLevel
    }
    
    public var numberOfQuestionGroups: Int {
        return self.questionGroupCaretaker.questionGroups.count
    }
    
    public func questionStrategy(forQuestionGroupAt index: Int) -> QuestionStrategy {
        let questionGroup = self.questionGroupCaretaker.questionGroups[index]
        let questionGroupAnswers = QuestionGroupAnswers(questionAnswers: [])
        let questionGroupHandler = QuestionGroupHandler(questionGroup: questionGroup, answers: questionGroupAnswers)
        return self.appSettings.questionStrategy(for: questionGroupHandler)
    }
    
    public func title(forQuestionGroupAt index: Int) -> String {
        return self.questionGroupCaretaker.questionGroups[index].title
    }
    
}
