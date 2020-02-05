//
//  AppStore.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 05/02/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation
import ReSwift

public final class AppStore {
    
    // MARK: Class Properties
    
    public static let shared = Store<AppState>(
        reducer: appReducer,
        state: nil
    )
    
    // MARK: - Object Lifecycle
    
    private init() { }
}
