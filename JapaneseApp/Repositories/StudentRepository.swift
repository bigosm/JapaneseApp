//
//  StudentRepository.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class StudentRepository {
    
    // MARK: - Static Properties
    
    private static let _shared = StudentRepository()
    public class var shared: StudentRepository {
        return StudentRepository._shared
    }
    
    // MARK: - Instance Properties
    
    private let studentCaretaker = StudentCaretaker()
    private var currentStudent: Student { return self.studentCaretaker.student }
    private let experienceModel: [String: Int]

    // MARK: - Object Lifecycle
    
    private init() {
        let bundle = Bundle.main
        let url = bundle.url(forResource: "Vocabulary", withExtension: "json")!
        
        self.experienceModel = try! DiskCaretaker.retrieve([String: Int].self, from: url)
    }
    
}
