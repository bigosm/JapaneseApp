//
//  PracticeCompletionCellViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 24/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import ReSwift

public protocol PracticeCompletionCellViewModelInputs {
    func configureWith(practiceAnswerAtIndex index: Int)
    func prepareForReuse()
}

public protocol PracticeCompletionCellViewModelOutputs {
    var isCorrect: Observable<Bool> { get }
    var title: Observable<String?> { get }
    var experience: Observable<String?> { get }
    var prompt: Observable<String?> { get }
    var subject: Observable<String?> { get }
    var answer: Observable<String?> { get }
    var correctAnswer: Observable<String?> { get }
    var meaning: Observable<String?> { get }
    var isSelected: Observable<Bool> { get }
}

public protocol PracticeCompletionCellViewModelType {
    var inputs: PracticeCompletionCellViewModelInputs { get }
    var outputs: PracticeCompletionCellViewModelOutputs { get }
}

public final class PracticeCompletionCellViewModel: PracticeCompletionCellViewModelType, PracticeCompletionCellViewModelInputs, PracticeCompletionCellViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    private var index: Int!
    private var practiceGroup: PracticeGroup!
    
    public func newState(state: PracticeState) {
        guard case .completed(_) = state.current,
            let index = self.index,
            let practice = state.practice else {
                return
        }
        let state = practice.practiceAnswers[index]
        let question = practice.questions[index].value
        
        self.isCorrect.value = state.isCorrect
        self.title.value = "Question \(index + 1)"
        self.experience.value = "\(state.isCorrect ? 1 : 0) xp"
        self.prompt.value = question.prompt
        switch question {
        case let q as RomajiNotation:
            self.subject.value = q.subject.value
        case let q as MatchSoundToCharacter:
            self.subject.value = q.subject.altNotation
        case let q as WordMeaning:
            self.subject.value = q.subject.value
        case let q as TranslateWord:
            self.subject.value = q.subject.meaning?.first
        default:
            self.subject.value = nil
        }
        self.answer.value = state.answer
        self.correctAnswer.value = state.correctAnswer
        self.meaning.value = state.answerMeaning
        self.isSelected.value = practice.isSelected(answerCheck: state)
    }
    
    // MARK: - Inputs
    
    public func configureWith(practiceAnswerAtIndex index: Int) {
        self.index = index
        AppStore.shared.subscribe(self) {
            $0.select { $0.practiceState }
        }
    }
    
    public func prepareForReuse() {
        AppStore.shared.unsubscribe(self)
        self.isSelected.value = false
    }
    
    // MARK: - Outputs
    
    public let isCorrect: Observable<Bool> = Observable(false)
    public let title: Observable<String?> = Observable(nil)
    public let experience: Observable<String?> = Observable(nil)
    public let prompt: Observable<String?> = Observable(nil)
    public let subject: Observable<String?> = Observable(nil)
    public let answer: Observable<String?> = Observable(nil)
    public let correctAnswer: Observable<String?> = Observable(nil)
    public let meaning: Observable<String?> = Observable(nil)
    public let isSelected: Observable<Bool> = Observable(false)
    
    public var inputs: PracticeCompletionCellViewModelInputs { return self }
    public var outputs: PracticeCompletionCellViewModelOutputs { return self }
    
    // MARK: - Private
}
