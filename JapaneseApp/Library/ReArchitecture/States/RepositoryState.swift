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
    internal let practiceGroups: [PracticeGroup]
    public let selectedPracticeGroup: PracticeGroup?
    
    public var numberOfPracticeGroups: Int { return self.practiceGroups.count }
    
    public func isSelected(practiceGroup: PracticeGroup) -> Bool {
        return practiceGroup == selectedPracticeGroup
    }
    
    public func getPracticeGroup(atIndex index: Int) -> PracticeGroup {
        return self.practiceGroups[index]
    }
    
    public func getPracticeGroup(byId id: String) -> PracticeGroup? {
        return self.practiceGroups.first { $0.id == id }
    }
}

extension RepositoryState {
    
    static var initial = RepositoryState(
        characterTables: bundleLoad(resource: "Characters", type: [CharacterTable].self),
        vocabulary: bundleLoad(resource: "Vocabulary", type: [Word].self),
        practiceGroups: bundleLoad(resource: "QuestionGroupData1", type: [PracticeGroup].self),
        selectedPracticeGroup: nil
    )
    
}


