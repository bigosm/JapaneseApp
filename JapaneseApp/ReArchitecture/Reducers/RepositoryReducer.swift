//
//  RepositoryReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public func repositoryReducer(action: Action, state: RepositoryState?) -> RepositoryState {
    return state ?? .initial
}
