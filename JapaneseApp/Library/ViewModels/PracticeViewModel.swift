//
//  PracticeViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 06/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol PracticeViewModelInputs {
    func cancelButtonTapped()
    func listenButtonTapped()
    func readingAidVisibilityButtonTapped()
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol PracticeViewModelOutputs {
    var title: Observable<String?> { get }
    var question: Observable<String?> { get }
    var isReadingAidButtonHidden: Observable<Bool> { get }
}

public protocol PracticeViewModelType {
    var inputs: PracticeViewModelInputs { get }
    var outputs: PracticeViewModelOutputs { get }
}

public final class PracticeViewModel: PracticeViewModelType, PracticeViewModelInputs, PracticeViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard let current = state.currentQuestion else { return }
        switch current {
        case .sentenceMeaning(let prompt, _, _),
             .translateMeaning(let prompt, _, _),
             .subjectMeaning(let prompt, _, _):
            self.question.value = prompt
        }
        self.isReadingAidButtonHidden.value = !state.hasReadingAid
    }
    
    // MARK: - Inputs
    
    public func cancelButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.cancel
        )
    }
    
    public func listenButtonTapped() { }
    
    public func readingAidVisibilityButtonTapped() {
        AppStore.shared.dispatch(
            PracticeAction.toggleReadingAid
        )
    }
    
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
    
    public let title: Observable<String?> = Observable(nil)
    public let question: Observable<String?> = Observable(nil)
    public let isReadingAidButtonHidden: Observable<Bool> = Observable(false)

    public var inputs: PracticeViewModelInputs { return self }
    public var outputs: PracticeViewModelOutputs { return self }
    
    // MARK: - Private
}

