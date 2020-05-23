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
    
    let kanaCharacters: KanaCharacters
    let kanji: [Subject]
    let vocabulary: [Subject]
    let phrase: [Subject]
    
    let practiceHiragana: [PracticeGroup]
    let practiceKatakana: [PracticeGroup]
    let practiceKanji: [PracticeGroup]
    let practiceVocabulary: [PracticeGroup]
    let practicePhrase: [PracticeGroup]
    
    let errorMessage: String?
    let isLoading: Bool
    
    internal let characterTables: [KanaCharacters] = []
    public let selectedPracticeGroup: PracticeGroup? = nil
    
    var numberOfPracticeGroups: Int { practiceHiragana.count }
    
    public func isSelected(practiceGroup: PracticeGroup) -> Bool {
        selectedPracticeGroup == practiceGroup
    }
    
    public func getPracticeGroup(atIndex index: Int) -> PracticeGroup {
        practiceHiragana[index]
    }
    
    public func getPracticeGroup(byId id: String) -> PracticeGroup? {
        practiceHiragana.first { $0.id == id }
    }
}
