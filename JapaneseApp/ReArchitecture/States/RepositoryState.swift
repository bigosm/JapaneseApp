//
//  RepositoryState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct RepositoryState: StateType, Equatable {
    
    internal let characterTables: [CharacterTable]
    internal let vocabulary: [Word]
    internal let questionGroups: [QuestionGroup]
    public let selectedQuestionGroup: QuestionGroup?
    
    public var numberOfQuestionGroups: Int { return self.questionGroups.count }
    
    public func isSelected(questionGroup: QuestionGroup) -> Bool {
        return questionGroup == selectedQuestionGroup
    }
    
    public func getQuestionGroup(atIndex index: Int) -> QuestionGroup {
        return self.questionGroups[index]
    }
    
    public func getQuestionGroup(byId id: String) -> QuestionGroup? {
        return self.questionGroups.first { $0.id == id }
    }
}

extension RepositoryState {
    
    static var initial = RepositoryState(
        characterTables: bundleLoad(resource: "Characters", type: [CharacterTable].self),
        vocabulary: bundleLoad(resource: "Vocabulary", type: [Word].self),
        questionGroups: bundleLoad(resource: "QuestionGroupData1", type: [QuestionGroup].self),
        selectedQuestionGroup: nil
    )
    
}


