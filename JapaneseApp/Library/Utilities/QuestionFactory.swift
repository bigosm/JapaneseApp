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
    internal let numberOfCharactersToPractice: Int = 5
    internal let numberOfWordsToPractice: Int = 5
    internal let numberOfPhraseToPractice: Int = 0

    public func prepare() -> [AnyQuestion] {
        let currentPracticeLevel = self.practiceGroup.levels.filter { $0.level <= level }
        let charactersIds = currentPracticeLevel.map { $0.characters }.flatMap { $0 }
        let vocabularyIds = currentPracticeLevel.map { $0.vocabulary }.flatMap { $0 }
//        let phrasesIds = currentPracticeLevel.map { $0.phrases }.flatMap { $0 }
        
        let characters = self.getCharacters(byIds: charactersIds)
        let charactersQuestions = prepareCharacterQuestions(characters: characters)
        
        let vocabulary = self.getVocabulary(byIds: vocabularyIds)
        let vocabularyQuestions = prepareVocabularyQuestions(vocabulary: vocabulary)
        
        return (charactersQuestions + vocabularyQuestions).shuffled()
    }
    
    private func prepareCharacterQuestions(characters: [Subject]) -> [AnyQuestion] {
        let numberOfCharacters = characters.count < self.numberOfCharactersToPractice ? characters.count : self.numberOfCharactersToPractice
        let charactersToPractice = characters.shuffled().prefix(upTo: numberOfCharacters)
        return charactersToPractice.map { character -> AnyQuestion? in
            
            switch [0,1].randomElement() {
            case 1:
                return AnyQuestion(MatchSoundToCharacter(
                prompt: "What character make this sound?",
                correctAnswerList: [character.value],
                answer: nil,
                isCorrect: nil,
                subject: character
            ))
            default:
                guard let altNotation = character.altNotation else { return nil }
                return AnyQuestion(RomajiNotation(
                prompt: "What is the character romaji notation?",
                correctAnswerList: [altNotation],
                answer: nil,
                isCorrect: nil,
                subject: character
            ))
            }
        }.compactMap { $0 }
    }
    
    private func prepareVocabularyQuestions(vocabulary: [Subject]) -> [AnyQuestion] {
        let numberOfWords = vocabulary.count < self.numberOfWordsToPractice ? vocabulary.count : self.numberOfWordsToPractice
        let vocabularyToPractice = vocabulary.shuffled().prefix(upTo: numberOfWords)
        return vocabularyToPractice.map { word -> AnyQuestion? in
            
            switch [0,1].randomElement() {
            case 1:
                guard let meaning = word.meaning else { return nil }
                return AnyQuestion(WordMeaning(
                    prompt: "What is the meaning",
                    correctAnswerList: meaning,
                    answer: nil,
                    isCorrect: nil,
                    subject: word)
                )
            default:
                return AnyQuestion(TranslateWord(
                    prompt: "Translate the word",
                    correctAnswerList: [word.value] + [word.readingAid].compactMap { $0 },
                    answer: nil,
                    isCorrect: nil,
                    subject: word)
                )
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
