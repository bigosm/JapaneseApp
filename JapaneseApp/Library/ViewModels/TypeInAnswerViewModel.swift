//
//  TypeInAnswerViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol TypeInAnswerViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func textInput(text: String)
}

public protocol TypeInAnswerViewModelOutputs {
    var textInput: Observable<String?> { get set }
    var canChangeTextInput: Bool { get }
}

public protocol TypeInAnswerViewModelType {
    var inputs: TypeInAnswerViewModelInputs { get }
    var outputs: TypeInAnswerViewModelOutputs { get }
}

public final class TypeInAnswerViewModel: TypeInAnswerViewModelType, TypeInAnswerViewModelInputs, TypeInAnswerViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard case .inProgress = state.current,
            let state = state.practice else {
                return
        }
        self.textInput.value = state.currentQuestionAnswer
        self.canChangeTextInput = state.answerCheck == nil
    }
    
    // MARK: - Inputs
    
    public func viewDidLoad() {
        
    }
    
    public func viewWillAppear() {
        AppStore.shared.subscribe(self) {
            $0.select { $0.practiceState }
        }
    }
    
    public func viewWillDisappear() {
        AppStore.shared.unsubscribe(self)
    }
    
    public func textInput(text: String) {
        AppStore.shared.dispatch(
            CurrentPracticeAction.answer(text)
        )
    }
    
    // MARK: - Outputs
    
    public var textInput: Observable<String?> = Observable(nil)
    public private(set) var canChangeTextInput: Bool = true
    
    public var inputs: TypeInAnswerViewModelInputs { return self }
    public var outputs: TypeInAnswerViewModelOutputs { return self }
    
    // MARK: - Private
}


