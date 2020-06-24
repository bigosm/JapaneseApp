//
//  PracticeFlashcardViewModel.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 05/06/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

protocol PracticeFlashcardViewModelInputs {
    func didTapCancelButton()
    func didTapInfoButton()
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
}

protocol PracticeFlashcardViewModelOutputs {
    
}

protocol PracticeFlashcardViewModelType {
    var inputs: PracticeFlashcardViewModelInputs { get }
    var outputs: PracticeFlashcardViewModelOutputs { get }
}

final class PracticeFlashcardViewModel: PracticeFlashcardViewModelType, PracticeFlashcardViewModelInputs, PracticeFlashcardViewModelOutputs, StoreSubscriber {
    typealias StoreSubscriberStateType = RepositoryState
    
    // MARK: - Object Lifecycle
    
    init() { }
    
    func newState(state: RepositoryState) {
        
    }
    
    // MARK: - Inputs
    
    func didTapCancelButton() {
        
    }
    
    func didTapInfoButton() {
        
    }
    
    func viewDidLoad() {
        
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
    
    var title: Observable<String?> = Observable(nil)
    
    var inputs: PracticeFlashcardViewModelInputs { return self }
    var outputs: PracticeFlashcardViewModelOutputs { return self }
    
    // MARK: - Private
}
