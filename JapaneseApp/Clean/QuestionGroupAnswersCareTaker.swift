//
//  QuestionGroupAnswersCareTaker.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 22/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

//public final class AnswersLogCaretaker {
//    
//    // MARK: - Instance Properties
//    
//    private let fileName = "QuestionGroupsAnswersData"
//    public var questionGroupAnswersList: [QuestionGroupAnswersData] = []
//    
//    // MARK: - Object Lifecycle
//    
//    public init(questionGroups: [QuestionGroup]) {
//        self.loadQuestionGroupsAnswers(questionGroups: questionGroups)
//    }
//    
//    // MARK: - Instance Methods
//    
//    public func save() throws {
//        try DiskCaretaker.save(self.questionGroupAnswersList, to: self.fileName)
//    }
//    
//    // MARK: - Private Methods
//    
//    private func loadQuestionGroupsAnswers(questionGroups: [QuestionGroup]) {
//        if let questionGroupAnswersList = try? DiskCaretaker.retrieve([QuestionGroupAnswersData].self, from: self.fileName) {
//            self.questionGroupAnswersList = questionGroupAnswersList
//        } else {
//            questionGroups.forEach {
//                let questionGroupAnswers = QuestionGroupAnswersData(
//                    questionGroupId: $0.id,
//                    quesionGroupAnswers: [])
//                self.questionGroupAnswersList.append(questionGroupAnswers)
//            }
//                
//            try! save()
//        }
//    }
//
//}
