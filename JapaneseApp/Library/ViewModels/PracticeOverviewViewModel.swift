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
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol PracticeOverviewViewModelOutputs {

    var numberOfItems: Int { get }

}

public protocol PracticeOverviewViewModelType {
    var inputs: PracticeOverviewViewModelInputs { get }
    var outputs: PracticeOverviewViewModelOutputs { get }
}

public final class PracticeOverviewViewModel: PracticeOverviewViewModelType, PracticeOverviewViewModelInputs, PracticeOverviewViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = RepositoryState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: RepositoryState) {
        self.numberOfItems = state.numberOfPracticeGroups
    }
    
    // MARK: - Inputs
    
    public func select(practiceGroupAtIndex index: Int) {
        AppStore.shared.dispatch(
            RepositoryAction.selectPracticeGroupAtIndex(index)
        )
    }
    
    public func viewDidLoad() { }
    
    public func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
    }
    
    public func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Outputs
    
    public var numberOfItems: Int = 0

    public var inputs: PracticeOverviewViewModelInputs { return self }
    public var outputs: PracticeOverviewViewModelOutputs { return self }
    
    // MARK: - Private
}
