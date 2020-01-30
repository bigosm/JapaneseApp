//
//  Writable.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

protocol Writable {
    
    var id: String { get }
    var value: String { get }
    var kanaNotation: String? { get }
    var romajiNotation: String { get }
    var audio: String? { get }
    
}
