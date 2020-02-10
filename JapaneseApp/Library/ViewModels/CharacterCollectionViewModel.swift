//
//  CharacterCollectionViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol CharacterCollectionViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

public protocol CharacterCollectionViewModelOutputs {
    var numberOfItems: Int { get }
    var contentUpdate: Observable<Bool> { get }
}

public protocol CharacterCollectionViewModelType {
    var inputs: CharacterCollectionViewModelInputs { get }
    var outputs: CharacterCollectionViewModelOutputs { get }
}

public final class CharacterCollectionViewModel: CharacterCollectionViewModelType, CharacterCollectionViewModelInputs, CharacterCollectionViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
    
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        self.contentUpdate.value = true
    }
    
    // MARK: - Inputs
    
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
    
    public var numberOfItems: Int = 5
    public let contentUpdate: Observable<Bool> = Observable(false)
    
    public var inputs: CharacterCollectionViewModelInputs { return self }
    public var outputs: CharacterCollectionViewModelOutputs { return self }
    
    // MARK: - Private
}
