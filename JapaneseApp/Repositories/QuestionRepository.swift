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
    
    public func experience(forQuestionGroupAt index: Int) -> Int {
        self.questionGroupAnswersCaretaker.questionGroupAnswersList[index].experienceEarned
    }
    
    public var numberOfQuestionGroups: Int {
        return self.questionGroupCaretaker.questionGroups.count
    }
    
    public func questionStrategy(forQuestionGroupAt index: Int) -> QuestionStrategy {
        let questionGroupHandler = self.questionGroupHandler(forQuestionGroupAt: index)
        let questionStrategy = self.appSettings.questionStrategy(for: questionGroupHandler)
        questionStrategy.didCompleteQuestionGroup = { [weak self] questionGroupHandler in
            if let currentAnswers = questionGroupHandler.questionGroupAnswersData.current {
                currentAnswers.experienceEarned = ExperienceService.shared
                    .experience(forQuestionAnswers: currentAnswers.questionAnswers)
                questionGroupHandler.questionGroupAnswersData.questionGroupAnswers.append(currentAnswers)
                questionGroupHandler.questionGroupAnswersData.current = nil
                try? self?.questionGroupAnswersCaretaker.save()
            }
            
            print("QuestionGroup: \(questionGroupHandler.questionGroup.title), experience: \(questionGroupHandler.questionGroupAnswersData.experienceEarned)xp")
        }
        return questionStrategy
    }
    
    public func questionGroupHandler(forQuestionGroupAt index: Int) -> QuestionGroupHandler {
        let questionGroup = self.questionGroupCaretaker.questionGroups[index]
        let answersData = self.questionGroupAnswersCaretaker.questionGroupAnswersList
            .first { $0.questionGroupId == questionGroup.id }!
        return QuestionGroupHandler(questionGroup: questionGroup, answersData: answersData)
    }
    
    public func title(forQuestionGroupAt index: Int) -> String {
        return self.questionGroupCaretaker.questionGroups[index].title
    }
    
}
