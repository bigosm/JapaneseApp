//
//  CharacterViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 11/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public enum CharacterConfiguartion {
    case subject
    case sentenceElement
}

public protocol PracticeCharacterViewModelInputs {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func configureWith(characterAtIndex index: Int)
}

public protocol PracticeCharacterViewModelOutputs {
    var value: Observable<String?> { get }
    var readingAid: Observable<String?> { get }
    var readingAidVisibility: Observable<Bool> { get }
    var configuration: Observable<CharacterConfiguartion> { get }
}

public protocol PracticeCharacterViewModelType {
    var inputs: PracticeCharacterViewModelInputs { get }
    var outputs: PracticeCharacterViewModelOutputs { get }
}

public final class PracticeCharacterViewModel: PracticeCharacterViewModelType, PracticeCharacterViewModelInputs, PracticeCharacterViewModelOutputs, StoreSubscriber {
    public typealias StoreSubscriberStateType = PracticeState
 
    // MARK: - Object Lifecycle
    
    public init() { }
    
    public func newState(state: PracticeState) {
        guard let state = state.practice else { return }

        switch state.currentQuestion {
        case .matchSoundToCharacter(_, let value, _):
            self.value.value = value
            self.readingAid.value = nil
            self.configuration.value = .subject
        case .romajiNotation(_, let value, _):
            self.value.value = value.value
            self.readingAid.value = nil
            self.configuration.value = .subject
        case .subjectMeaning(_, let value, _):
            self.value.value = value.value
            self.readingAid.value = nil
            self.configuration.value = .subject
        case .sentenceMeaning(_, let value, _):
            if let index = self.characterIndex {
                let subject = value.value[index]
                self.value.value = subject.value
                self.readingAid.value = subject.readingAid
                self.configuration.value = .sentenceElement
            }
        case .translateMeaning(_, let value, _):
            self.value.value = value
            self.readingAid.value = nil
            self.configuration.value = .subject
        }

        self.readingAidVisibility.value = state.isReadingAidVisible
    }
    
    private var characterIndex: Int?
    
    // MARK: - Inputs
    
    public func configureWith(characterAtIndex index: Int) {
        self.characterIndex = index
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
    
    public let value: Observable<String?> = Observable(nil)
    public let readingAid: Observable<String?> = Observable(nil)
    public let readingAidVisibility: Observable<Bool> = Observable(false)
    public let configuration: Observable<CharacterConfiguartion> = Observable(.subject)
    
    public var inputs: PracticeCharacterViewModelInputs { return self }
    public var outputs: PracticeCharacterViewModelOutputs { return self }
    
    // MARK: - Private
}
