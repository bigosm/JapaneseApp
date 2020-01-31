//
//  VocabularyRepository.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class VocabularyRepository {
    
    // MARK: - Static Properties
    
    private static let _shared = VocabularyRepository()
    public class var shared: VocabularyRepository {
        return VocabularyRepository._shared
    }
    
    // MARK: - Instance Properties
    
    public let vocabulary: [Word]

    // MARK: - Object Lifecycle
    
    private init() {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "Vocabulary", withExtension: "json")!
        
        self.vocabulary = try! DiskCaretaker.retrieve([Word].self, from: url)
    }
    
}
