//
//  PracticeOverviewViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

protocol PracticeOverviewViewModelInputs {
    func practiceGroupTapped(atIndex index: Int)
    
    func viewWillAppear()
    func viewWillDisappear()
}

protocol PracticeOverviewViewModelOutputs {
    var isLoading: Observable<Bool> { get }
    var numberOfItems: Observable<Int> { get }
    var selectedPracticeGroup: Observable<PracticeGroup?> { get }
    
    var practiceType: PracticeType { get }
}

protocol PracticeOverviewViewModelType {
    var inputs: PracticeOverviewViewModelInputs { get }
    var outputs: PracticeOverviewViewModelOutputs { get }
}

final class PracticeOverviewViewModel: PracticeOverviewViewModelType, PracticeOverviewViewModelInputs, PracticeOverviewViewModelOutputs, StoreSubscriber {
    typealias StoreSubscriberStateType = RepositoryState
    
    // MARK: - Object Lifecycle
    
    private var practiceGroups: [PracticeGroup] = []
    
    init(practiceType: PracticeType) {
        self.practiceType = practiceType
    }
    
    func newState(state: RepositoryState) {
        switch practiceType {
        case .hiragana: practiceGroups = state.practiceHiragana
        case .katakana: practiceGroups = state.practiceKatakana
        case .kanji: practiceGroups = state.practiceKanji
        case .vocabulary: practiceGroups = state.practiceVocabulary
        case .phrase: practiceGroups = state.practicePhrase
        }
        
        isLoading.value = state.isLoading
        numberOfItems.value = practiceGroups.count
        selectedPracticeGroup.value = state.selectedPracticeGroup
    }
    
    // MARK: - Inputs
    
    func practiceGroupTapped(atIndex index: Int) {
        AppStore.shared.dispatch(
            UserActions.PracticeOveriew.selectPracticeGroup(practiceGroups[index])
        )
    }

    func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
    }
    
    func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Outputs
    
    let isLoading = Observable(false)
    let numberOfItems = Observable(0)
    let selectedPracticeGroup = Observable<PracticeGroup?>()
    
    let practiceType: PracticeType

    var inputs: PracticeOverviewViewModelInputs { self }
    var outputs: PracticeOverviewViewModelOutputs { self }
}
