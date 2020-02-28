//
//  PracticeCompletionSummaryCellViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 25/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol PracticeCompletionSummaryCellViewModelInputs {
    func configure()
    func prepareForReuse()
    func completeButtonTapped()
}

public protocol PracticeCompletionSummaryCellViewModelOutputs {
    var experience: Observable<String?> { get }
}

public protocol PracticeCompletionSummaryCellViewModelType {
    var inputs: PracticeCompletionSummaryCellViewModelInputs { get }
    var outputs: PracticeCompletionSummaryCellViewModelOutputs { get }
}

public final class PracticeCompletionSummaryCellViewModel: PracticeCompletionSummaryCellViewModelType, PracticeCompletionSummaryCellViewModelInputs, PracticeCompletionSummaryCellViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard case .completed = state.current,
            let practice = state.practice else {
                return
        }
        
        self.experience.value = "\(practice.practiceAnswers.reduce(0) { $0 + ($1.isCorrect ? 1 : 0) }) xp"
    }
    
    // MARK: - Inputs
    
    public func configure() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.practiceState }
        }
    }

    public func prepareForReuse() {
        AppStore.shared.unsubscribe(self)
    }
    
    public func completeButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.finish
        )
    }

    // MARK: - Outputs
    
    public var experience: Observable<String?> = Observable(nil)
    
    public var inputs: PracticeCompletionSummaryCellViewModelInputs { return self }
    public var outputs: PracticeCompletionSummaryCellViewModelOutputs { return self }
    
    // MARK: - Private
}
