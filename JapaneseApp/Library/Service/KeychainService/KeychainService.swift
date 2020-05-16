//
//  KeychainService.swift
//  JapaneseApp
//
//  Created by Michal Bigos on 10/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//
//  https://github.com/jrendel/SwiftKeychainWrapper/blob/develop/SwiftKeychainWrapper/KeychainWrapper.swift
//

import Foundation

private let secAttrAccessGroup = kSecAttrAccessGroup as String
private let secAttrAccount = kSecAttrAccount as String
private let secAttrGeneric = kSecAttrGeneric as String
private let secAttrService = kSecAttrService as String
private let secClass = kSecClass as String
private let secClassGenericPassword = kSecClassGenericPassword as String
private let secMatchLimit = kSecMatchLimit as String
private let secReturnAttributes = kSecReturnAttributes as String
private let secReturnData = kSecReturnData as String
private let secValueData = kSecValueData as String

protocol KeychainServiceType {
    var serviceName: String { get }
    
    func string(forKey key: String) -> String?
    func data(forKey key: String) -> Data?
    
    @discardableResult
    func set(_ value: String, forKey key: String) -> Bool
    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool
    
    @discardableResult
    func removeObject(forKey key: String) -> Bool
    @discardableResult
    func removeAllKeys() -> Bool
}

final class KeychainService: KeychainServiceType {
    
    private let debug = "[🔑 KeychainService] "
    
    public static let shared = KeychainService()
    
    private (set) public var serviceName: String

    private static let defaultServiceName: String = {
        return Bundle.main.bundleIdentifier ?? "DefaultKeychainService"
    }()
    
    // MARK: - Object Lifecycle

    private convenience init() {
        self.init(serviceName: KeychainService.defaultServiceName)
    }
    
    public init(serviceName: String) {
        self.serviceName = serviceName
    }
    
    // MARK: - Public Methods
    
    public func string(forKey key: String) -> String? {
        guard let keychainData = data(forKey: key) else { return nil }
        
        return String(data: keychainData, encoding: String.Encoding.utf8)
    }
    
    public func data(forKey key: String) -> Data? {
        var keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key)
        
        keychainQueryDictionary[secMatchLimit] = kSecMatchLimitOne
        keychainQueryDictionary[secReturnData] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQueryDictionary as CFDictionary, &result)
        
        guard status == noErr else {
            Log.error(debug + "Get key `\(key)` failed, error: " + errorMessage(from: status))
            return nil
        }
        
        return result as? Data
    }
    
    @discardableResult
    public func set(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else {
            return false
        }
        
        return set(data, forKey: key)
    }
    
    @discardableResult
    public func set(_ value: Data, forKey key: String) -> Bool {
        var keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key)
        keychainQueryDictionary[secValueData] = value
        
        let status = SecItemAdd(keychainQueryDictionary as CFDictionary, nil)
        
        switch status {
        case errSecSuccess: return true
        case errSecDuplicateItem: return update(value, forKey: key)
        default:
            Log.warning(debug + "Set value for key `\(key)` failed, error: " + errorMessage(from: status))
            return false
        }
    }
    
    @discardableResult
    public func removeObject(forKey key: String) -> Bool {
        let keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key)
        let status = SecItemDelete(keychainQueryDictionary as CFDictionary)

        guard status == errSecSuccess else {
            Log.warning(debug + "Remove key `\(key)` failed, error: " + errorMessage(from: status))
            return false
        }
        
        return true
    }
    
    @discardableResult
    public func removeAllKeys() -> Bool {
        let keychainQueryDictionary = setupKeychainQueryDictionary(forKey: nil)
        let status = SecItemDelete(keychainQueryDictionary as CFDictionary)
        
        guard status == errSecSuccess else {
            Log.warning(debug + "Remove all keys failed, error: " + errorMessage(from: status))
            return false
        }
            
        return true

    }
    
    // MARK: - Private Methods
    
    private func update(_ value: Data, forKey key: String) -> Bool {
        let keychainQueryDictionary = setupKeychainQueryDictionary(forKey: key)
        let updateDictionary = [secValueData: value]
        
        let status = SecItemUpdate(keychainQueryDictionary as CFDictionary, updateDictionary as CFDictionary)
        
        guard status == errSecSuccess else {
            Log.warning(debug + "Update value for key `\(key)` failed, error: " + errorMessage(from: status))
            return false
        }
        
        return true
    }

    private func setupKeychainQueryDictionary(forKey key: String? = nil) -> [String: Any] {
        var keychainQueryDictionary: [String: Any] = [
            secClass: secClassGenericPassword,
            secAttrService: serviceName,
        ]

        if let key = key {
            let encodedIdentifier = key.data(using: String.Encoding.utf8)
            keychainQueryDictionary[secAttrGeneric] = encodedIdentifier
            keychainQueryDictionary[secAttrAccount] = encodedIdentifier
        }
        
        return keychainQueryDictionary
    }
    
    private func errorMessage(from status: OSStatus) -> String {
      return SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
    }
}

