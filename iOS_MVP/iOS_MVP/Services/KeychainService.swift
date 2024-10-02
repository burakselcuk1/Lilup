//
//  KeychainService.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 26.06.2024.
//  Copyright © 2024 Lillup. All rights reserved.
//

import Foundation
import Security

protocol IKeychainService {
    func save(service: String, account: String, data: Data) -> Bool
    func retrieve(service: String, account: String) -> String?
    func delete(service: String, account: String) -> Bool
}

class KeychainService: IKeychainService {
   
    func save(service: String, account: String, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func retrieve(service: String, account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess {
            if let obj = dataTypeRef as? Data{
               return  String(data: obj, encoding: .utf8)
            }
            return nil
        }
        return nil
    }

    func delete(service: String, account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
