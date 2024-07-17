//
//  secure_storage_util.swift
//  booklove
//
//  Created by Moritz on 17.07.24.
//

import Foundation
import Security

class SecureStorage {
    
    static func set(_ token: String) -> Bool { // (to set the token in keychain)
        let tokenData = token.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken",
            kSecValueData as String: tokenData
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func get() -> String? { // (to get the token from keychan)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken",
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess {
            if let tokenData = result as? Data,
               let token = String(data: tokenData, encoding: .utf8) {
                return token
            }
        }
        
        return nil
    }
    
    static func logout() -> Bool { // deletes jwt token --> logs user out
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "userToken"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
