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
}


// MARK: -

enum AppActions {
    
    enum UserSession: Action {
        case refreshSession
        case sessionExpired
    }
    
    enum UserProfile: Action {
        case getUserProfile
    }

    enum Networking {
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
    }
}

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

public enum RepositoryAction: Action {
    case selectPracticeGroupAtIndex(Int)
}
