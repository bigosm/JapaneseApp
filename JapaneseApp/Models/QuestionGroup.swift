//
//  QuestionGroup.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 03/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public struct QuestionGroup: Codable {
    
    // MARK: - Instance Properties
    
    public let id: String
    public let title: String
    public let requirements: [String]
    public let levels: [QuestionLevel]

}
