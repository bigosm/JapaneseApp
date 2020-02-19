//
//  AnswerCompletionViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 18/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol AnswerCompletionViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol AnswerCompletionViewModelOutputs {
    var title: Observable<String?> { get }
    var correctAnswer: Observable<String?> { get }
    var meaing: Observable<String?> { get }
    var isAnswerCorrect: Observable<Bool> { get }
}

public protocol AnswerCompletionViewModelType {
    var inputs: AnswerCompletionViewModelInputs { get }
    var outputs: AnswerCompletionViewModelOutputs { get }
}

public final class AnswerCompletionViewModel: AnswerCompletionViewModelType, AnswerCompletionViewModelInputs, AnswerCompletionViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard let state = state.practice,
            let answerState = state.correctAnswerState else { return }
        
        self.title.value = answerState ? "You are Correct!" : "Correct:"
        self.correctAnswer.value = state.correctAnswer
        self.meaing.value = state.answerMeaning == nil ? nil : "Meaning: \(state.answerMeaning!)"
        self.isAnswerCorrect.value = answerState
    }
    
    // MARK: - Inputs
    
    public func viewDidLoad() {
        
    }
    
    public func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.practiceState }
        }
    }
    
    public func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Outputs
    
    public let title: Observable<String?> = Observable(nil)
    public let correctAnswer: Observable<String?> = Observable(nil)
    public let meaing: Observable<String?> = Observable(nil)
    public let isAnswerCorrect: Observable<Bool> = Observable(false)
    
    public var inputs: AnswerCompletionViewModelInputs { return self }
    public var outputs: AnswerCompletionViewModelOutputs { return self }
    
    // MARK: - Private
}
