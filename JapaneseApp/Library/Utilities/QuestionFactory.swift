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
    internal let numberOfCharactersToPractice: Int = 5
    internal let numberOfWordsToPractice: Int = 5
    internal let numberOfPhraseToPractice: Int = 0
    
    public func prepare() -> [AnyQuestion] {
        let currentPracticeLevel = self.practiceGroup.levels.filter { $0.level <= level }
        let charactersIds = currentPracticeLevel.map { $0.hiragana }.flatMap { $0 }
        let vocabularyIds = currentPracticeLevel.map { $0.vocabulary }.flatMap { $0 }
        //        let phrasesIds = currentPracticeLevel.map { $0.phrases }.flatMap { $0 }
        
        let characters = self.getCharacters(byIds: charactersIds)
        let charactersQuestions = prepareCharacterQuestions(characters: characters)
        
        let vocabulary = self.getVocabulary(byIds: vocabularyIds)
        let vocabularyQuestions = prepareVocabularyQuestions(vocabulary: vocabulary)
        
        return (charactersQuestions + vocabularyQuestions).shuffled()
    }
    
    private func prepareAnswerFeed(answer: String, feed: [String], maxNumberOfFeed count: Int) -> [String] {
        let countFeed = feed.count < count ? feed.count : count - 1
        let onlyFeed = feed.shuffled().prefix(upTo: countFeed)
        let preparedFeed = onlyFeed + [answer]
        return preparedFeed.shuffled()
    }
    
    private func prepareCharacterQuestions(characters: [Subject]) -> [AnyQuestion] {
        let numberOfCharacters = characters.count < self.numberOfCharactersToPractice ? characters.count : self.numberOfCharactersToPractice
        let charactersToPractice = characters.shuffled().prefix(upTo: numberOfCharacters)
        return charactersToPractice.map { character -> AnyQuestion? in
            func answerFeed(_ transform: (Subject) -> String?) -> [String] {
                charactersToPractice
                    .filter { $0 != character }
                    .map(transform)
                    .compactMap { $0 }
            }
            switch [0,1].randomElement() {
            case 1:
                return AnyQuestion(MatchSoundToCharacter(
                    prompt: "What character make this sound?",
                    correctAnswerList: [character.value],
                    answerFeed: prepareAnswerFeed(
                        answer: character.value,
                        feed: answerFeed { $0.value },
                        maxNumberOfFeed: 4),
                    answer: nil,
                    isCorrect: nil,
                    subject: character
                ))
            default:
                guard let altNotation = character.altNotation else { return nil }
                return AnyQuestion(RomajiNotation(
                    prompt: "What is the character romaji notation?",
                    correctAnswerList: [altNotation],
                    answerFeed: prepareAnswerFeed(
                        answer: altNotation,
                        feed: answerFeed { $0.altNotation },
                        maxNumberOfFeed: 4),
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
            func answerFeed(_ transform: (Subject) -> String?) -> [String] {
                vocabularyToPractice
                    .filter { $0 != word }
                    .map(transform)
                    .compactMap { $0 }
            }
            switch [0,1].randomElement() {
            case 1:
                guard let meaning = word.meaning else { return nil }
                return AnyQuestion(WordMeaning(
                    prompt: "What is the meaning",
                    correctAnswerList: meaning,
                    answerFeed: prepareAnswerFeed(
                        answer: meaning[0],
                        feed: answerFeed { $0.meaning?.first },
                        maxNumberOfFeed: 4),
                    answer: nil,
                    isCorrect: nil,
                    subject: word)
                )
            default:
                return AnyQuestion(TranslateWord(
                    prompt: "Translate the word",
                    correctAnswerList: [word.value] + [word.readingAid].compactMap { $0 },
                    answerFeed: prepareAnswerFeed(
                        answer: word.value,
                        feed: answerFeed { $0.value },
                        maxNumberOfFeed: 4),
                    answer: nil,
                    isCorrect: nil,
                    subject: word)
                )
            }
        }.compactMap { $0 }
    }
    
    public func getCharacters(byIds charactersIds: [String]) -> [Subject] {
        let characters = AppStore.shared.state.repositoryState.kanaCharacters.hiragana
        return charactersIds.map { id in
            characters.first { $0.id == id }
        }.compactMap { $0 }
    }
    
    public func getVocabulary(byIds vocabularyIds: [String]) -> [Subject] {
        let vocabulary = AppStore.shared.state.repositoryState.vocabulary
        return vocabularyIds.map { id in
            vocabulary.first { $0.id == id }
        }.compactMap { $0 }
    }
    
}
