//
//  StudentCaretaker.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 30/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public final class StudentCaretaker {
    
    // MARK: - Instance Properties
    
    private let fileName = "StudentData"
    public var student: Student!
    
    // MARK: - Object Lifecycle
    
    public init() {
        self.load()
    }
    
    // MARK: - Instance Methods
    
    public func save() throws {
        try DiskCaretaker.save(self.student, to: self.fileName)
    }
    
    // MARK: - Private Methods
    
    private func load() {
        if let student = try? DiskCaretaker.retrieve(Student.self, from: self.fileName) {
            self.student = student
        } else {
            self.student = Student(id: "new-student-id",
                                   name: "Name",
                                   experience: Experience(totalExperience: 0,
                                                          currentLevelExperience: 0,
                                                          nextLevelExperience: 0,
                                                          level: 1),
                                   progress: [:])
            try! save()
        }
    }

}
