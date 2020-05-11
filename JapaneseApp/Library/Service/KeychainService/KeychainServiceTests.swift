//
//  KeychainServiceTests.swift
//  JapaneseAppTests
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import XCTest
@testable import JapaneseApp

class KeychainServiceTests: XCTestCase {
    
    private var keychainService: KeychainService!
    private let testKey = "testKey"
    private let testString = "This is a test one"
    
    private let testKey2 = "testKey2"
    private let testString2 = "This is a test two"
    
    override func setUp() {
        keychainService = KeychainService(serviceName: "testServiceName")
    }
    
    override func tearDown() {
        keychainService.removeObject(forKey: testKey)
        keychainService = nil
    }
    
    func testDataSave() {
        let testData = testString.data(using: String.Encoding.utf8)
        
        if let data = testData {
            XCTAssertTrue(keychainService.set(data, forKey: testKey), "Data should save to Keychain")
        } else {
            XCTFail("Failed to create Data")
        }
    }
    
    func testStringSave() {
        XCTAssertTrue(keychainService.set(testString, forKey: testKey), "Data should save to Keychain")
    }

    func testDataRetrieval() {
        let testData = testString.data(using: .utf8)!
        
        keychainService.set(testData, forKey: testKey)
        
        if let stringRetrived = self.keychainService.data(forKey: self.testKey) {
            XCTAssertEqual(testData, stringRetrived, "Data retrieved for testKey should match data saved to testKey")
        } else {
            XCTFail("Data for testKey could not be retrieved")
        }
    }
    
    func testStringRetrieval() {
        keychainService.set(testString, forKey: testKey)
        
        if let stringRetrived = keychainService.string(forKey: testKey) {
            XCTAssertEqual(testString, stringRetrived, "String retrieved for testKey should match string saved to testKey")
        } else {
            XCTFail("String for testKey could not be retrieved")
        }
    }
    
    func testMultipleSaveToTheSameKey() {
        if !keychainService.set(testString, forKey: testKey) {
            XCTFail("String for testKey did not save")
        }
        
        if !keychainService.set(testString2, forKey: testKey) {
            XCTFail("String for testKey did not save")
        }
        
        if let stringRetrived = keychainService.string(forKey: testKey) {
            XCTAssertEqual(testString2, stringRetrived, "String retrieved for testKey should match string saved to testKey")
        } else {
            XCTFail("String for testKey could not be retrieved")
        }
    }
    
    func testRemoveObjectFromKeychain() {
        keychainService.set(testString, forKey: testKey)
        keychainService.removeObject(forKey: testKey)
        
        XCTAssertNil(keychainService.string(forKey: testKey), "Data for testKey should be removed form keychain")
    }
    
    func testRemoveAllKeysFromKeychain() {
        keychainService.set(testString, forKey: testKey)
        keychainService.set(testString2, forKey: testKey2)
        
        keychainService.removeAllKeys()
        
        XCTAssertNil(keychainService.string(forKey: testKey), "Data for testKey should be removed form keychain")
        XCTAssertNil(keychainService.string(forKey: testKey2), "Data for testKey2 should be removed form keychain")
    }
    
    func testStringRetrievalWhenValueDoesNotExists() {
         XCTAssertNil(keychainService.string(forKey: testKey), "Data for testKey should not exists")
    }
}

