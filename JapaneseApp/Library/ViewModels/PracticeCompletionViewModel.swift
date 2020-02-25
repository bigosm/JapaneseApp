//
//  PracticeCompletionViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 21/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol PracticeCompletionViewModelInputs {
    func select(practiceAnswerAtIndex index: Int)
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol PracticeCompletionViewModelOutputs {
    var title: Observable<String?> { get }
    var numberOfItems: Int { get }
}

public protocol PracticeCompletionViewModelType {
    var inputs: PracticeCompletionViewModelInputs { get }
    var outputs: PracticeCompletionViewModelOutputs { get }
}

public final class PracticeCompletionViewModel: PracticeCompletionViewModelType, PracticeCompletionViewModelInputs, PracticeCompletionViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard case .completed(_) = state.current,
            let state = state.practice else {
                return
        }
        
        self.numberOfItems = state.practiceAnswers.count
        self.title.value = "Practice Completion"
    }
    
    // MARK: - Inputs
    
    public func select(practiceAnswerAtIndex index: Int) {
        AppStore.shared.dispatch(
            PracticeAction.selectPracticeAnswerAtIndex(index)
        )
    }
    
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
    public var numberOfItems: Int = 0
    
    public var inputs: PracticeCompletionViewModelInputs { return self }
    public var outputs: PracticeCompletionViewModelOutputs { return self }
    
    // MARK: - Private
}
