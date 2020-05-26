//
//  Actions.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

enum UserActions {
    enum UserSession: Action {
        case login(username: String, password: String)
        case logout
    }
    
    enum PracticeOveriew: Action {
        case selectPracticeGroup(PracticeGroup)
    }
}


// MARK: -

enum AppActions {
    
    enum UserSession: Action {
        case sessionExpired
    }

    enum Request: Action {
        case refreshSession
        
        case getUserProfile
        
        case getPracticeGroups
        case getKanaCharacters
        case getVocabulary
    }

    enum RequestResult {
        class Request<T>: Action {
            enum State<T> {
                case success(T)
                case failure(Error)
                case inProgress
            }
            
            let state: State<T>
            
            init(state: State<T>) {
                self.state = state
            }
        }
        
        class Login: Request<LoginRequest.Response> { }
        class RefreshSession: Request<RefreshSessionRequest.Response> { }
        
        class UserProfile: Request<UserProfileRequest.Response> { }
        class PracticeGroups: Request<PracticeGroupRequest.Response> { }
        class KanaCharacters: Request<KanaCharactersRequest.Response> { }
        class Vocabulary: Request<VocabularyRequest.Response> { }
    }
}

protocol RepositoryAction { }
extension UserActions.PracticeOveriew: RepositoryAction { }

extension AppActions.RequestResult.KanaCharacters: RepositoryAction { }
extension AppActions.RequestResult.Vocabulary: RepositoryAction { }
extension AppActions.RequestResult.PracticeGroups: RepositoryAction { }

// MARK: - Deprecated functionality

public struct SelectQuestionGroup: Action {
    let indexOf: Int
}

public struct ViewHistory: Action {
    let practiceGroup: PracticeGroup
}

public enum PracticeAction: Action {
    case cancel
    case preparePractice(PracticeGroup)
    case prepareTimePractice(PracticeGroup)
    case startPractice([AnyQuestion])
    case startTimePractice([AnyQuestion])
    case complete
    case selectPracticeAnswerAtIndex(Int)
    case finish
    
}

public enum CurrentPracticeAction: Action {
    case answer(String?)
    case answerAt(Int)
    case checkAnswer
    case answerState(AnswerCheck)
    case nextQuestion
    case toggleReadingAid
}
