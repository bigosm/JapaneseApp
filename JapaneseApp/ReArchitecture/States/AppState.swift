//
//  AppState.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public struct AppState: StateType {
    
    let repositoryState: RepositoryState
    var studentState: StudentState
    
}


