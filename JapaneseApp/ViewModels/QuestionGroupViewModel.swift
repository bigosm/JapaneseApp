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
    func setSelected(with isSelected: Bool)
}

public protocol QuestionGroupViewModelOutputs {
    var title: Observable<String?> { get }
    var level: Observable<String?> { get }
    var experience: Observable<String?> { get }
    var isLocked: Observable<Bool> { get }
    var isBodyHidden: Observable<Bool> { get }
}

public protocol QuestionGroupViewModelType {
    var inputs: QuestionGroupViewModelInputs { get }
    var outputs: QuestionGroupViewModelOutputs { get }
}

public final class QuestionGroupViewModel: QuestionGroupViewModelType, QuestionGroupViewModelInputs, QuestionGroupViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = RepositoryState
    
    public init() { }
    
    private var repositoryState: RepositoryState? = AppStore.shared.state.repositoryState
    public func newState(state: RepositoryState) {
        self.repositoryState = state
        if let questionGroup = self.questionGroup {
            self.questionGroup = state.getQuestionGroup(byId: questionGroup.id)
        }
    }
    
    private var questionGroup: QuestionGroup? {
        didSet {
            self.title.value = self.questionGroup?.title
            self.level.value = "Level 1"
            self.experience.value = "99999 xp"
            /// - TODO: "figure out how to handle student related data, and change this 'isLocked' to check from store")
            if self.questionGroup?.id == "hiragana-1" {
                self.isLocked.value = false
            } else {
                self.isLocked.value = true
            }
            self.isBodyHidden.value = true
        }
    }
    public func configureWith(questionGroupAtIndex index: Int) {
        AppStore.shared.subscribe(self) {
            $0.select { $0.repositoryState }
        }
        self.questionGroup = self.repositoryState?.getQuestionGroup(atIndex: index)
    }
    
    public func prepareForReuse() {
        AppStore.shared.unsubscribe(self)
    }
    
    public func practiceButtonTapped() {
        guard let questionGroup = self.questionGroup else { return }
        AppStore.shared.dispatch(
            StartPractice(questionGroup: questionGroup)
        )
    }
    
    public func timedPracticeButtonTapped() {
        guard let questionGroup = self.questionGroup else { return }
        AppStore.shared.dispatch(
            StartTimedPractice(questionGroup: questionGroup)
        )
    }
    
    public func historyButtonTapped() {
        guard let questionGroup = self.questionGroup else { return }
        AppStore.shared.dispatch(
            ViewHistory(questionGroup: questionGroup)
        )
    }
    
    public func setSelected(with isSelected: Bool) {
        if self.isLocked.value == false {
            self.isBodyHidden.value = !isSelected
        }
    }
    
    public let title: Observable<String?> = Observable(nil)
    public let level: Observable<String?> = Observable(nil)
    public let experience: Observable<String?> = Observable(nil)
    public let isLocked: Observable<Bool> = Observable(true)
    public let isBodyHidden: Observable<Bool> = Observable(true)
    
    public var inputs: QuestionGroupViewModelInputs { return self }
    public var outputs: QuestionGroupViewModelOutputs { return self }
    
}
