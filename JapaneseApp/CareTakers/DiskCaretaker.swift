//
//  DiskCaretaker.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 08/01/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public final class DiskCaretaker {
    
    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()
    
    public static func save<T: Codable>(_ object: T, to fileName: String) throws {
        do {
            let url = self.createDocumentURL(withFileName: fileName)
            let data = try encoder.encode(object)
            
            try data.write(to: url, options: .atomic)

        } catch let error {
            print("[‼️ \(Date().iso8601) \(self.self): \(#function)] Save failed: Object: `\(object)`, Error: `\(error)`")
            throw error
        }
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        
        let url = self.createDocumentURL(withFileName: fileName)
        
        return try retrieve(type, from: url)
    }
    
    public static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
            
            return try decoder.decode(type, from: data)
        } catch let error {
            print("[‼️ \(Date().iso8601) \(self.self): \(#function)] Retrieve failed: URL: `\(url)`, Error: `\(error)`")
            throw error
        }
    }
    
    public static func createDocumentURL(withFileName fileName: String) -> URL {
        
        let fileManager = FileManager.default
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return url.appendingPathComponent(fileName).appendingPathExtension("json")
    }
    
}
