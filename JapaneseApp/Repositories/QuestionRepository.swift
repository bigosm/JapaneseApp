//
//  QuestionRepository.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class QuestionRepository {
    
    // MARK: - Static Properties
    
    private static let _shared = QuestionRepository()
    public class var shared: QuestionRepository {
        return QuestionRepository._shared
    }
    
    // MARK: - Instance Properties
    
//    private let appSettings = AppSettings.shared
//    private let questionGroupCaretaker: QuestionGroupCaretaker
//    private let questionGroupAnswersCaretaker: QuestionGroupAnswersCaretaker

    private let questionGroups: [QuestionGroup]
    
    // MARK: - Object Lifecycle
    
    private init() {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "QuestionGroupData1", withExtension: "json")!
        
        self.questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url)
    }
    
    // MARK: - Instance Methods
    
    public var numberOfQuestionGroups: Int {
        return self.questionGroups.count
    }
    
    public func title(forQuestionGroupAt index: Int) -> String {
        return self.questionGroups[index].title
    }
    
    
//    public func addNewQuestionGroup(_ questionGroup: QuestionGroup) {
//        self.questionGroupCaretaker.questionGroups.append(questionGroup)
//        try? self.questionGroupCaretaker.save()
//    }
//
//    public func level(forQuestionGroupAt index: Int) -> Int {
//        self.questionGroupCaretaker.questionGroups[index].questionLevel
//    }
//
//    public func experience(forQuestionGroupAt index: Int) -> Int {
//        self.questionGroupAnswersCaretaker.questionGroupAnswersList[index].experienceEarned
//    }
//

//
//    public func questionStrategy(forQuestionGroupAt index: Int) -> QuestionStrategy {
//        let questionGroupHandler = self.questionGroupHandler(forQuestionGroupAt: index)
//        let questionStrategy = self.appSettings.questionStrategy(for: questionGroupHandler)
//        questionStrategy.didCompleteQuestionGroup = { [weak self] questionGroupHandler in
//            if let currentAnswers = questionGroupHandler.questionGroupAnswersData.current {
//                currentAnswers.experienceEarned = ExperienceService.shared
//                    .experience(forQuestionAnswers: currentAnswers.questionAnswers)
//                questionGroupHandler.questionGroupAnswersData.questionGroupAnswers.append(currentAnswers)
//                questionGroupHandler.questionGroupAnswersData.current = nil
//                try? self?.questionGroupAnswersCaretaker.save()
//            }
//
//            print("QuestionGroup: \(questionGroupHandler.questionGroup.title), experience: \(questionGroupHandler.questionGroupAnswersData.experienceEarned)xp")
//        }
//        return questionStrategy
//    }
//
//    public func questionGroupHandler(forQuestionGroupAt index: Int) -> QuestionGroupHandler {
//        let questionGroup = self.questionGroupCaretaker.questionGroups[index]
//        let answersData = self.questionGroupAnswersCaretaker.questionGroupAnswersList
//            .first { $0.questionGroupId == questionGroup.id }!
//        return QuestionGroupHandler(questionGroup: questionGroup, answersData: answersData)
//    }

}
