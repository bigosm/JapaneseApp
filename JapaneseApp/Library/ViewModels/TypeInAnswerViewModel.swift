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
}

public protocol TypeInAnswerViewModelOutputs {
    var textInput: String? { get set }
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
    
    // MARK: - Outputs
    
    public var textInput: String?
    
    public var inputs: TypeInAnswerViewModelInputs { return self }
    public var outputs: TypeInAnswerViewModelOutputs { return self }
    
    // MARK: - Private
}


