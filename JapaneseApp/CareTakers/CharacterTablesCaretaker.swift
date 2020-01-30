//
//  CharacterTablesCaretaker.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 13/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public final class CharacterTablesCaretaker {
    
    // MARK: - Instance Properties
    
    private let fileName = "Characters"
    public var characterTableList: [CharacterTable] = []
    public var selectedCharacterTable: CharacterTable!
    
    // MARK: - Object Lifecycle
    
    public init() {
        self.loadCharacterTables()
    }
    
    // MARK: - Instance Methods
    
    public func save() throws {
        try DiskCaretaker.save(self.characterTableList, to: self.fileName)
    }
    
    // MARK: - Private Methods
    
    private func loadCharacterTables() {
        if let characterTableList = try? DiskCaretaker.retrieve([CharacterTable].self, from: self.fileName) {
            
            self.characterTableList = characterTableList
        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: self.fileName, withExtension: "json")!
            
            self.characterTableList = try! DiskCaretaker.retrieve([CharacterTable].self, from: url)
            try! save()
        }
    }

}
