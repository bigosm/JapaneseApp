//
//  RepositoryReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func repositoryReducer(action: Action, state: RepositoryState?) -> RepositoryState {
    var kanaCharacters: KanaCharacters = state?.kanaCharacters ??
        KanaCharacters(hiragana: [], katakana: [])
    var kanji = state?.kanji ?? []
    var vocabulary = state?.vocabulary ?? []
    var phrase = state?.phrase ?? []
    var practiceHiragana = state?.practiceHiragana ?? []
    var practiceKatakana = state?.practiceKatakana ?? []
    var practiceKanji = state?.practiceKanji ?? []
    var practiceVocabulary = state?.practiceVocabulary ?? []
    var practicePhrase = state?.practicePhrase ?? []
    
    var errorMessage: String? = nil
    var isLoading: Bool = state?.isLoading ?? false
    
    switch action {
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
    case let action as AppActions.RequestResult.KanaCharacters:
        switch action.state {
        case .success(let resource):
            kanaCharacters = resource
        case .failure(let error):
            errorMessage = error.localizedDescription
        case .inProgress:
            isLoading = true
        }
    case RepositoryAction.selectPracticeGroupAtIndex: break
//        return RepositoryState(
//            characterTables: state.characterTables,
//            vocabulary: state.vocabulary,
//            practiceGroups: state.practiceGroups,
//            selectedPracticeGroup: state.practiceGroups[index]
//        )
    case let startPractice as ViewHistory:
        print("[RepositoryReducer] View history for question group: \(startPractice.practiceGroup.title)")
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
        errorMessage: errorMessage,
        isLoading: isLoading
    )
}
