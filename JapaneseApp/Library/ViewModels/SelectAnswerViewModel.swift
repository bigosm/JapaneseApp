//
//  SelectAnswerViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 26/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol SelectAnswerViewModelInputs {
    func select(answerAtIndex index: Int)
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol SelectAnswerViewModelOutputs {
    var numberOfItems: Int { get }
    var contentUpdate: Observable<Bool> { get }
}

public protocol SelectAnswerViewModelType {
    var inputs: SelectAnswerViewModelInputs { get }
    var outputs: SelectAnswerViewModelOutputs { get }
}

public final class SelectAnswerViewModel: SelectAnswerViewModelType, SelectAnswerViewModelInputs, SelectAnswerViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }

    public func newState(state: PracticeState) {
        guard case .inProgress(_) = state.current,
            let state = state.practice else {
                return
        }
        self.numberOfItems = state.currentQuestion.answerFeed.count
        self.contentUpdate.value = true
    }
    
    // MARK: - Inputs
    
    public func select(answerAtIndex index: Int) {
        AppStore.shared.dispatch(
            CurrentPracticeAction.answerAt(index)
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
    
    private var answerFeed: [Observable<String?>] = []
    public var numberOfItems: Int = 0
    public let contentUpdate: Observable<Bool> = Observable(false)
    
    public var inputs: SelectAnswerViewModelInputs { return self }
    public var outputs: SelectAnswerViewModelOutputs { return self }
    
    // MARK: - Private
}
