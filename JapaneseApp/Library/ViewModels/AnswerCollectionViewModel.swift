//
//  AnswerCollectionViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol AnswerCollectionViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol AnswerCollectionViewModelOutputs {
    var numberOfItems: Int { get }
    var contentUpdate: Observable<Bool> { get }
}

public protocol AnswerCollectionViewModelType {
    var inputs: AnswerCollectionViewModelInputs { get }
    var outputs: AnswerCollectionViewModelOutputs { get }
}

public final class AnswerCollectionViewModel: AnswerCollectionViewModelType, AnswerCollectionViewModelInputs, AnswerCollectionViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard case .inProgress(_) = state.current,
            let state = state.practice else {
                return
        }
        
        if let _ = state.currentQuestion as? SubjectQuestionType {
            self.numberOfItems = 1
        } else if let currentQuestion = state.currentQuestion as? PhraseQuestionType {
            self.numberOfItems = currentQuestion.phrase.value.count
        }
        
        self.contentUpdate.value = true
    }
    
    // MARK: - Inputs
    
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
    
    public var numberOfItems: Int = 0
    public let contentUpdate: Observable<Bool> = Observable(false)
    
    public var inputs: AnswerCollectionViewModelInputs { return self }
    public var outputs: AnswerCollectionViewModelOutputs { return self }
    
    // MARK: - Private
}
