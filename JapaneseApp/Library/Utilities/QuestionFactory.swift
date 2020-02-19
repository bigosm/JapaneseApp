//
//  PracticeFactory.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct QuestionFactory {

    let practiceGroup: PracticeGroup
    let level: Int

    public func prepare() -> [Question] {
        
        let currentPracticeLevel = practiceGroup.levels
        let charactersIds = currentPracticeLevel.map { $0.characters }.flatMap { $0 }
        let vocabularyIds = currentPracticeLevel.map { $0.vocabulary }.flatMap { $0 }
//        let phrasesIds = currentPracticeLevel.map { $0.phrases }.flatMap { $0 }
        
        let characters = self.getCharacters(byIds: charactersIds)
        let vocabulary = self.getVocabulary(byIds: vocabularyIds).shuffled().map { word in
            return Question.subjectMeaning(prompt: "What is the meaning", subject: word, answers: word.meaning ?? [])
        }
        let randomWord = vocabulary.randomElement()!
        return vocabulary
//            .subjectMeaning(prompt: "What is the meaning", subject: AppStore.shared.state.repositoryState.vocabulary.randomElement()!, answers: randomWord.meaning!),
//            .sentenceMeaning(prompt: "Translate the sentence", phrase: Phrase(value: vocabulary, audio: nil, meaning: nil), answers: []),
//            .sentenceMeaning(prompt: "Translate the sentence", phrase: Phrase(value: characters, audio: nil, meaning: nil), answers: [])
//        ])
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
