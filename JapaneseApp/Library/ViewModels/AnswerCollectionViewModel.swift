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
        guard let state = state.practice else { return }
        
        if case .subjectMeaning(_, _, _) = state.currentQuestion {
            self.numberOfItems = 1
            self.contentUpdate.value = true
            
        } else if case .sentenceMeaning(_, let phrase, _) = state.currentQuestion {
            self.numberOfItems = phrase.value.count
            self.contentUpdate.value = true
        }
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
