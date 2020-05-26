//
//  RepositoryReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

extension RepositoryState {
    static let initial = RepositoryState(
        kanaCharacters: KanaCharacters(hiragana: [], katakana: []),
        kanji: [],
        vocabulary: [],
        phrase: [],
        practiceHiragana: [],
        practiceKatakana: [],
        practiceKanji: [],
        practiceVocabulary: [],
        practicePhrase: [],
        selectedPracticeGroup: nil,
        errorMessage: nil,
        isLoading: false
    )
}

internal func repositoryReducer(action: Action, state: RepositoryState?) -> RepositoryState {
    let state = state ?? .initial
    
    guard action is RepositoryAction else { return state }
    
    var kanaCharacters = state.kanaCharacters
    let kanji = state.kanji
    var vocabulary = state.vocabulary
    let phrase = state.phrase
    
    var practiceHiragana = state.practiceHiragana
    var practiceKatakana = state.practiceKatakana
    var practiceKanji = state.practiceKanji
    var practiceVocabulary = state.practiceVocabulary
    var practicePhrase = state.practicePhrase
    
    var selectedPracticeGroup = state.selectedPracticeGroup
    
    var errorMessage: String? = state.errorMessage
    var isLoading: Bool = state.isLoading
    
    switch action {
        // MARK: - 📬 AppActions.RequestResult
        
        // MARK: PracticeGroups
        
    case let action as AppActions.RequestResult.PracticeGroups:
        switch action.state {
        case .success(let resource):
            practiceHiragana = resource.hiragana
            practiceKatakana = resource.katakana
            practiceKanji = resource.kanji
            practiceVocabulary = resource.vocabulary
            practicePhrase = resource.phrase
            isLoading = false
        case .failure(let error):
            errorMessage = error.localizedDescription
            isLoading = false
        case .inProgress:
            isLoading = true
        }
        
        // MARK: KanaCharacters
        
    case let action as AppActions.RequestResult.KanaCharacters:
        switch action.state {
        case .success(let resource):
            kanaCharacters = resource
        case .failure(let error):
            errorMessage = error.localizedDescription
        case .inProgress:
            isLoading = true
        }
        
        // TODO: Kanji
        
        // MARK: Vocabulary
        
    case let action as AppActions.RequestResult.Vocabulary:
        switch action.state {
        case .success(let resource):
            vocabulary = resource
        case .failure(let error):
            errorMessage = error.localizedDescription
        case .inProgress:
            isLoading = true
        }

        // TODO: Phrase
        
        // MARK: - ❤️ UserActions.PracticeOveriew
        
        // MARK: selectPracticeGroup
        
    case UserActions.PracticeOveriew.selectPracticeGroup(let practiceGroup):
        selectedPracticeGroup = selectedPracticeGroup == practiceGroup ? nil : practiceGroup
        
    default: break
    }
    
    return RepositoryState(
        kanaCharacters: kanaCharacters,
        kanji: kanji,
        vocabulary: vocabulary,
        phrase: phrase,
        practiceHiragana: practiceHiragana,
        practiceKatakana: practiceKatakana,
        practiceKanji: practiceKanji,
        practiceVocabulary: practiceVocabulary,
        practicePhrase: practicePhrase,
        selectedPracticeGroup: selectedPracticeGroup,
        errorMessage: errorMessage,
        isLoading: isLoading
    )
}
