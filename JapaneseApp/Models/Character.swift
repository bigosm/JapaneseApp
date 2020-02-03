//
//  Character.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Character: Writable, Codable {
    
    // MARK: - Instance Properties
    
    public let id: String
    public let value: String
    public let kanaNotation: String?
    public let romajiNotation: String
    public let audio: String?
    
}
