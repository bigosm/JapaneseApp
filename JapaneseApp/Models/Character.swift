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
    
    public var id: String
    public var value: String
    public var kanaNotation: String?
    public var romajiNotation: String
    public var audio: String?
    
}
