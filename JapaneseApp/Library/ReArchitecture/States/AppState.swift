//
//  AppState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public let config = URLSessionConfiguration.default
public struct AppState: StateType {
    
    
    public let urlSession: URLSession
    
    public let navigationState: NavigationState
    public let repositoryState: RepositoryState
    public let practiceState: PracticeState
    public let userProfileState: UserProfileState
    public let userSessionState: UserSessionState
    
}


