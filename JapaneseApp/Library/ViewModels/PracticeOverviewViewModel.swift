//
//  PracticeOverviewViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol PracticeOverviewViewModelInputs {
    func select(practiceGroupAtIndex index: Int)
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol PracticeOverviewViewModelOutputs {
    var numberOfItems: Observable<Int> { get }
}

public protocol PracticeOverviewViewModelType {
    var inputs: PracticeOverviewViewModelInputs { get }
    var outputs: PracticeOverviewViewModelOutputs { get }
}

public final class PracticeOverviewViewModel: PracticeOverviewViewModelType, PracticeOverviewViewModelInputs, PracticeOverviewViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = RepositoryState
    
    // MARK: - Object Lifecycle
    
    private let practiceType: PracticeType
    
    public init(practiceType: PracticeType) {
        self.practiceType = practiceType
    }
    
    public func newState(state: RepositoryState) {
        switch practiceType {
        case .hiragana:
            numberOfItems.value = state.practiceHiragana.count
        case .katakana:
            numberOfItems.value = state.practiceKatakana.count
        case .kanji:
            numberOfItems.value = state.practiceKanji.count
        case .vocabulary:
            numberOfItems.value = state.practiceVocabulary.count
        case .phrase:
            numberOfItems.value = state.practicePhrase.count
        }
    }
    
    // MARK: - Inputs
    
    public func select(practiceGroupAtIndex index: Int) {
        AppStore.shared.dispatch(
            RepositoryAction.selectPracticeGroupAtIndex(index)
        )
    }
    
    public func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
    }
    
    public func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Outputs
    
    public let numberOfItems = Observable(0)

    public var inputs: PracticeOverviewViewModelInputs { self }
    public var outputs: PracticeOverviewViewModelOutputs { self }
    
    // MARK: - Private
}
