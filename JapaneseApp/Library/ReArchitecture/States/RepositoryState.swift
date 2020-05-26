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
    
    let selectedPracticeGroup: PracticeGroup?
    
    let errorMessage: String?
    let isLoading: Bool
}
