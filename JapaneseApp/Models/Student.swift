//
//  Student.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct Student: Codable {
    
    // MARK: - Instance Properties
    
    public let id: String
    public let name: String
    public var experience: Experience
    public var progress: [String: Experience]
    
}
