//
//  CharacterCellViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 07/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public protocol CharacterCellViewModelInputs {
    func configureWith(characterAtIndex index: Int)
    func prepareForReuse()
}

public protocol CharacterCellViewModelOutputs {
    var title: Observable<String?> { get }
    var readingAid: Observable<String?> { get }
    var readingAidVisibility: Observable<Bool> { get }
}

public protocol CharacterCellViewModelType {
    var inputs: CharacterCellViewModelInputs { get }
    var outputs: CharacterCellViewModelOutputs { get }
}

public final class CharacterCellViewModel: CharacterCellViewModelType, CharacterCellViewModelInputs, CharacterCellViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState

    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        self.title.value = ["あ","名前","い","お","う"][index]
        self.readingAid.value = [nil, "なまえ", nil,nil,nil][index]
        self.readingAidVisibility.value = state.isReadingAidVisible
    }
    
    private var index: Int!
    
    // MARK: - Inputs
    
    public func configureWith(characterAtIndex index: Int) {
        self.index = index
        AppStore.shared.subscribe(self) {
            $0.select { $0.practiceState }
        }
    }
    
    public func prepareForReuse() {
        AppStore.shared.unsubscribe(self)
    }
    
    // MARK: - Outputs
    
    public let title: Observable<String?> = Observable(nil)
    public let readingAid: Observable<String?> = Observable(nil)
    public let readingAidVisibility: Observable<Bool> = Observable(false)
    
    public var inputs: CharacterCellViewModelInputs { return self }
    public var outputs: CharacterCellViewModelOutputs { return self }
    
    // MARK: - Private
}
