//
//  PracticeGroupViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 05/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

protocol PracticeGroupViewModelInputs {
    func configure(_ practiceType: PracticeType, withPracticeGroupAtIndex index: Int)
    func prepareForReuse()
    func practiceButtonTapped()
    func timedPracticeButtonTapped()
    func historyButtonTapped()
}

protocol PracticeGroupViewModelOutputs {
    var title: Observable<String?> { get }
    var groupImage: Observable<String?> { get }
    var level: Observable<String?> { get }
    var experience: Observable<String?> { get }
    var isLocked: Observable<Bool> { get }
    var isSelected: Observable<Bool> { get }
}

protocol PracticeGroupViewModelType {
    var inputs: PracticeGroupViewModelInputs { get }
    var outputs: PracticeGroupViewModelOutputs { get }
}

final class PracticeGroupViewModel: PracticeGroupViewModelType, PracticeGroupViewModelInputs, PracticeGroupViewModelOutputs, StoreSubscriber {
    
    typealias StoreSubscriberStateType = RepositoryState
    
    private var index: Int!
    private var practiceType: PracticeType!
    private var practiceGroup: PracticeGroup!
    
    init() { }
    
    func newState(state: RepositoryState) {
        switch practiceType! {
        case .hiragana:
            practiceGroup = state.practiceHiragana[index]
        case .katakana:
            practiceGroup = state.practiceKatakana[index]
        case .kanji:
            practiceGroup = state.practiceKanji[index]
        case .vocabulary:
            practiceGroup = state.practiceVocabulary[index]
        case .phrase:
            practiceGroup = state.practicePhrase[index]
        }
        
        title.value = practiceGroup.title
        groupImage.value = state.kanaCharacters.hiragana.first { $0.id == practiceGroup.groupImage }?.value
        level.value = "Level 1"
        experience.value = "99999 xp"
        isLocked.value = practiceGroup.id != "hiragana-1"
        
        isSelected.value = practiceGroup == state.selectedPracticeGroup
    }
    
    func configure(_ practiceType: PracticeType, withPracticeGroupAtIndex index: Int) {
        self.practiceType = practiceType
        self.index = index
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
    }
    
    func prepareForReuse() {
        AppStore.shared.unsubscribe(self)
        isSelected.value = false
    }
    
    func practiceButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.preparePractice(practiceGroup)
        )
    }
    
    func timedPracticeButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.prepareTimePractice(practiceGroup)
        )
    }
    
    func historyButtonTapped() {
        AppStore.shared.dispatch(
            ViewHistory(practiceGroup: practiceGroup)
        )
    }
    
    let title = Observable<String?>()
    let groupImage = Observable<String?>()
    let level = Observable<String?>()
    let experience = Observable<String?>()
    let isLocked = Observable(false)
    let isSelected = Observable(false)
    
    var inputs: PracticeGroupViewModelInputs { self }
    var outputs: PracticeGroupViewModelOutputs { self }
}
