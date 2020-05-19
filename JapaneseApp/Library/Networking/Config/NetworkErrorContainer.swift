//
//  NetworkErrorContainer.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 16/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol NetwrokErrorContainer: Codable {
    var localizedDescription: String { get }
}

struct LoginErrorContainer: NetwrokErrorContainer {
    let error: String
    let error_description: String
    
    var localizedDescription: String { error_description }
}

struct ServerResponse<T: Codable>: NetwrokErrorContainer {
    let data: T?
    let error: Bool
    let message: String
    
    var localizedDescription: String { message }
}

