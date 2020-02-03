//
//  RepositoryState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct RepositoryState: StateType {
    
    var characterTables: [CharacterTable]
    var vocabulary: [Word]
    var questionGroups: [QuestionGroup]
    
}

extension RepositoryState {
    
    static var initial = RepositoryState(
        characterTables: bundleLoad(resource: "Characters", type: [CharacterTable].self),
        vocabulary: bundleLoad(resource: "Vocabulary", type: [Word].self),
        questionGroups: bundleLoad(resource: "QuestionGroupData1", type: [QuestionGroup].self)
    )
    
}


