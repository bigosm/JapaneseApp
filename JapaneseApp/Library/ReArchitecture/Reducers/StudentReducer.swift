//
//  StudentReducer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

internal func studentReducer(action: Action, state: StudentState?) -> StudentState {
    return state ?? StudentState()
}
