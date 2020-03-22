//
//  PracticeGroupViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 05/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol PracticeGroupViewModelInputs {
    func configureWith(practiceGroupAtIndex index: Int)
    func prepareForReuse()
    func practiceButtonTapped()
    func timedPracticeButtonTapped()
    func historyButtonTapped()
}

public protocol PracticeGroupViewModelOutputs {
    var title: Observable<String?> { get }
    var level: Observable<String?> { get }
    var experience: Observable<String?> { get }
    var isLocked: Observable<Bool> { get }
    var isSelected: Observable<Bool> { get }
}

public protocol PracticeGroupViewModelType {
    var inputs: PracticeGroupViewModelInputs { get }
    var outputs: PracticeGroupViewModelOutputs { get }
}

public final class PracticeGroupViewModel: PracticeGroupViewModelType, PracticeGroupViewModelInputs, PracticeGroupViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = RepositoryState
    
    public init() { }
    
    public func newState(state: RepositoryState) {
        let practiceGroup = state.getPracticeGroup(atIndex: self.index)
        self.practiceGroup = practiceGroup
        
        self.title.value = practiceGroup.title
        self.level.value = "Level 1"
        self.experience.value = "99999 xp"
        self.isLocked.value = practiceGroup.id != "hiragana-1"

        // Skip the same value
        if self.isSelected.value != state.isSelected(practiceGroup: practiceGroup) && !self.isLocked.value {
            self.isSelected.value.toggle()
        }
    }
    
    private var index: Int!
    private var practiceGroup: PracticeGroup!
    
    public func configureWith(practiceGroupAtIndex index: Int) {
        self.index = index
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
    }
    
    public func prepareForReuse() {
        AppStore.shared.unsubscribe(self)
        self.isSelected.value = false
    }
    
    public func practiceButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.preparePractice(practiceGroup)
        )
    }
    
    public func timedPracticeButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.prepareTimePractice(practiceGroup)
        )
    }
    
    public func historyButtonTapped() {
        AppStore.shared.dispatch(
            ViewHistory(practiceGroup: practiceGroup)
        )
    }
    
    public let title: Observable<String?> = Observable(nil)
    public let level: Observable<String?> = Observable(nil)
    public let experience: Observable<String?> = Observable(nil)
    public let isLocked: Observable<Bool> = Observable(false)
    public let isSelected: Observable<Bool> = Observable(false)
    
    public var inputs: PracticeGroupViewModelInputs { return self }
    public var outputs: PracticeGroupViewModelOutputs { return self }
    
}
