//
//  CharacterRepository.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class CharacterRepository {
    
    private static let _shared = CharacterRepository()
    public class var shared: CharacterRepository {
        return CharacterRepository._shared
    }
    
    public var tables: [CharacterTable]
    public var selectedTable: CharacterTable!

    private init() {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "Characters", withExtension: "json")!
        
        self.tables = try! DiskCaretaker.retrieve([CharacterTable].self, from: url)
    }
    
}
