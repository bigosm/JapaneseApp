////
////  QuestionGroupCatetaker.swift
////  JapaneseApp
////
////  Created by Michal Bigos on 08/01/2020.
////  Copyright © 2020 Example. All rights reserved.
////
//
//import Foundation
//
//public final class QuestionGroupCaretaker {
//    
//    // MARK: - Instance Properties
//    
//    private let fileName = "QuestionGroupData"
//    public var questionGroups: [QuestionGroup] = []
//    
//    // MARK: - Object Lifecycle
//    
//    public init() {
//        self.loadQuestionGroups()
//    }
//    
//    // MARK: - Instance Methods
//    
//    public func save() throws {
//        try DiskCaretaker.save(self.questionGroups, to: self.fileName)
//    }
//    
//    // MARK: - Private Methods
//    
//    private func loadQuestionGroups() {
//        if let questionGroups = try? DiskCaretaker.retrieve([QuestionGroup].self, from: self.fileName) {
//            
//            self.questionGroups = questionGroups
//        } else {
//            let bundle = Bundle.main
//            let url = bundle.url(forResource: self.fileName, withExtension: "json")!
//            
//            self.questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url)
//            try! save()
//        }
//    }
//
//}
