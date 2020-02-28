//
//  SelectAnswerCellViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 28/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol SelectAnswerCellViewModelInputs {
    func configureWith(answerFeedAtIndex index: Int)
    func prepareForReuse()
}

public protocol SelectAnswerCellViewModelOutputs {
    var answerFeed: Observable<String?> { get }
    var isSelected: Observable<Bool> { get }
}

public protocol SelectAnswerCellViewModelType {
    var inputs: SelectAnswerCellViewModelInputs { get }
    var outputs: SelectAnswerCellViewModelOutputs { get }
}

public final class SelectAnswerCellViewModel: SelectAnswerCellViewModelType, SelectAnswerCellViewModelInputs, SelectAnswerCellViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    private var index: Int!
    
    public func newState(state: PracticeState) {
        guard case .inProgress(_) = state.current,
            let index = self.index,
            let practice = state.practice else {
                return
        }
        
        let answerFeed = practice.currentQuestion.answerFeed[index]
        
        self.answerFeed.value = answerFeed
        self.isSelected.value = answerFeed == practice.currentQuestionAnswer
    }
    
    // MARK: - Inputs
    
    public func configureWith(answerFeedAtIndex index: Int) {

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
    
    public var answerFeed: Observable<String?> = Observable(nil)
    public let isSelected: Observable<Bool> = Observable(false)
    
    public var inputs: SelectAnswerCellViewModelInputs { return self }
    public var outputs: SelectAnswerCellViewModelOutputs { return self }
    
    // MARK: - Private
}
