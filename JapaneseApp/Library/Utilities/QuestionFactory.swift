//
//  PracticeFactory.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

internal struct QuestionFactory {

    internal let practiceGroup: PracticeGroup
    internal let level: Int
    internal let numberOfQuestions: Int = 10
    internal let numberOfCharactersToPractice: Int = 3
    internal let numberOfWordsToPractice: Int = 3
    internal let numberOfPhraseToPractice: Int = 3

    public func prepare() -> [Question] {
        let currentPracticeLevel = self.practiceGroup.levels.filter { $0.level <= level }
        let charactersIds = currentPracticeLevel.map { $0.characters }.flatMap { $0 }
        let vocabularyIds = currentPracticeLevel.map { $0.vocabulary }.flatMap { $0 }
//        let phrasesIds = currentPracticeLevel.map { $0.phrases }.flatMap { $0 }
        
        let characters = self.getCharacters(byIds: charactersIds)
        let charactersQuestions = prepareCharacterQuestions(characters: characters)
        
        let vocabulary = self.getVocabulary(byIds: vocabularyIds).shuffled().map { word in
            return Question.subjectMeaning(prompt: "What is the meaning", subject: word, answers: word.meaning ?? [])
        }
        let randomWord = vocabulary.randomElement()!
        return charactersQuestions
    }
    
    private func prepareCharacterQuestions(characters: [Subject]) -> [Question] {
        let numberOfCharacters = characters.count < self.numberOfCharactersToPractice ? characters.count : self.numberOfCharactersToPractice
        let charactersToPractice = characters.shuffled().prefix(upTo: self.numberOfCharactersToPractice)
        return charactersToPractice.map { character -> Question? in
            guard let altNotation = character.altNotation else { return nil }
            switch [0,1].randomElement() {
            case 1:  return Question.matchSoundToCharacter(
                prompt: "What character make this sound?",
                subject: altNotation,
                answer: character.value)
            default: return Question.romajiNotation(
                prompt: "What is the character romaji notation?",
                subject: character,
                answer: altNotation)
            }
        }.compactMap { $0 }
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
