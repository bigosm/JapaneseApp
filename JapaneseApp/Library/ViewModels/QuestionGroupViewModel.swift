//
//  QuestionGroupViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 05/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol QuestionGroupViewModelInputs {
    func configureWith(questionGroupAtIndex index: Int)
    func prepareForReuse()
    func practiceButtonTapped()
    func timedPracticeButtonTapped()
    func historyButtonTapped()
}

public protocol QuestionGroupViewModelOutputs {
    var title: Observable<String?> { get }
    var level: Observable<String?> { get }
    var experience: Observable<String?> { get }
    var isLocked: Observable<Bool> { get }
    var isSelected: Observable<Bool> { get }
}

public protocol QuestionGroupViewModelType {
    var inputs: QuestionGroupViewModelInputs { get }
    var outputs: QuestionGroupViewModelOutputs { get }
}

public final class QuestionGroupViewModel: QuestionGroupViewModelType, QuestionGroupViewModelInputs, QuestionGroupViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = RepositoryState
    
    public init() { }
    
    public func newState(state: RepositoryState) {
        let questionGroup = state.getQuestionGroup(atIndex: self.index)
        self.questionGroup = questionGroup
        
        self.title.value = questionGroup.title
        self.level.value = "Level 1"
        self.experience.value = "99999 xp"
        self.isLocked.value = questionGroup.id != "hiragana-1"

        // Skip the same value
        if self.isSelected.value != state.isSelected(questionGroup: questionGroup) && !self.isLocked.value {
            self.isSelected.value.toggle()
        }
    }
    
    private var index: Int!
    private var questionGroup: QuestionGroup!
    
    public func configureWith(questionGroupAtIndex index: Int) {
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
            PracticeAction.startPractice(questionGroup)
        )
    }
    
    public func timedPracticeButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.startTimePractice(questionGroup)
        )
    }
    
    public func historyButtonTapped() {
        AppStore.shared.dispatch(
            ViewHistory(questionGroup: questionGroup)
        )
    }
    
    public let title: Observable<String?> = Observable(nil)
    public let level: Observable<String?> = Observable(nil)
    public let experience: Observable<String?> = Observable(nil)
    public let isLocked: Observable<Bool> = Observable(false)
    public let isSelected: Observable<Bool> = Observable(false)
    
    public var inputs: QuestionGroupViewModelInputs { return self }
    public var outputs: QuestionGroupViewModelOutputs { return self }
    
}
