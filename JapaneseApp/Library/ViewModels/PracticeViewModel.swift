//
//  PracticeViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol PracticeViewModelInputs {
    func cancelButtonTapped()
    func checkButtonTapped()
    func continueButtonTapped()
    func listenButtonTapped()
    func readingAidVisibilityButtonTapped()
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol PracticeViewModelOutputs {
    var title: Observable<String?> { get }
    var question: Observable<String?> { get }
    var isReadingAidButtonHidden: Observable<Bool> { get }
    var isCheckButtonHidden: Observable<Bool> { get }
    var isCheckButtonEnabled: Observable<Bool> { get }
    var isContinueButtonHidden: Observable<Bool> { get }
    var answerCheck: Observable<Bool?> { get }
}

public protocol PracticeViewModelType {
    var inputs: PracticeViewModelInputs { get }
    var outputs: PracticeViewModelOutputs { get }
}

public final class PracticeViewModel: PracticeViewModelType, PracticeViewModelInputs, PracticeViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard case .inProgress = state.current,
            let state = state.practice else {
                return
        }
        self.title.value = "Question \(state.currentQuestionIndex + 1)/\(state.questions.count)"
        self.question.value = state.currentQuestion.prompt
        self.isReadingAidButtonHidden.value = false
        self.isCheckButtonHidden.value = state.answerCheck != nil
        self.isCheckButtonEnabled.value = !(state.currentQuestionAnswer?.isEmpty ?? true)
        self.isContinueButtonHidden.value = state.answerCheck == nil
        self.answerCheck.value = state.answerCheck?.isCorrect
    }
    
    // MARK: - Inputs
    
    public func cancelButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.cancel
        )
    }
    
    public func checkButtonTapped() {
        AppStore.shared.dispatch(
            CurrentPracticeAction.checkAnswer
        )
    }
    
    public func continueButtonTapped() {
        AppStore.shared.dispatch(
            CurrentPracticeAction.nextQuestion
        )
    }
    
    public func listenButtonTapped() { }
    
    public func readingAidVisibilityButtonTapped() {
        AppStore.shared.dispatch(
            CurrentPracticeAction.toggleReadingAid
        )
    }
    
    public func viewDidLoad() { }
    
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
    public let question: Observable<String?> = Observable(nil)
    public let isReadingAidButtonHidden: Observable<Bool> = Observable(false)
    public let isCheckButtonHidden: Observable<Bool> = Observable(false)
    public let isCheckButtonEnabled: Observable<Bool> = Observable(false)
    public let isContinueButtonHidden: Observable<Bool> = Observable(true)
    public let answerCheck: Observable<Bool?> = Observable(nil)

    public var inputs: PracticeViewModelInputs { return self }
    public var outputs: PracticeViewModelOutputs { return self }
    
    // MARK: - Private
}

