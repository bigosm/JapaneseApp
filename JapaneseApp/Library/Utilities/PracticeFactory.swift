//
//  PracticeFactory.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct PracticeFactory {
    
    let practiceGroup: PracticeGroup
    let level: Int
    
    public func prepare() -> Practice {
        
        let currentPracticeLevel = practiceGroup.levels
        let charactersIds = currentPracticeLevel.map { $0.characters }.flatMap { $0 }
        let vocabularyIds = currentPracticeLevel.map { $0.vocabulary }.flatMap { $0 }
//        let phrasesIds = currentPracticeLevel.map { $0.phrases }.flatMap { $0 }
        
        let characters = self.getCharacters(byIds: charactersIds)
        let vocabulary = self.getVocabulary(byIds: vocabularyIds)
        
        return Practice(questions: [
            Question(prompt: "test", subject: vocabulary, answer: []),
            Question(prompt: "test", subject: characters, answer: [])
        ])
    }
    
    public func getCharacters(byIds charactersIds: [String]) -> [Subject] {
        let characterTables = AppStore.shared.state.repositoryState.characterTables
        return charactersIds.map { id in
            id.contains("hiragana")
                ? characterTables.first(where: { $0.type == .hiragana })?.characters.first(where: {$0.id == id})
                : characterTables.first(where: { $0.type == .katakana })?.characters.first(where: {$0.id == id})
        }.compactMap { $0 }
    }
    
    public func getVocabulary(byIds vocabularyIds: [String]) -> [Subject] {
        let vocabulary = AppStore.shared.state.repositoryState.vocabulary
        return vocabularyIds.map { id in
            vocabulary.first(where: {$0.id == id})
        }.compactMap { $0 }
    }
    
}
