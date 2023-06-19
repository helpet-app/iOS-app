//
//  KeychainManager.swift
//  Helpet
//
//  Created by Efim Nikitin on 22.02.2023.
//

import Foundation

final class KeychainManager {
    static let shared = KeychainManager()

    private init() {}

    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString: Any]

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ] as [CFString: Any]

            let attributesToUpdate = [kSecValueData: data] as CFDictionary

            SecItemUpdate(query as CFDictionary, attributesToUpdate)
        }
    }

    func save<T: Codable>(_ item: T, service: String, account: String) {
        do {
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }

    func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as [CFString: Any]

        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)

        return (result as? Data)
    }

    func read<T: Codable>(service: String, account: String, type: T.Type) -> T? {
        guard let data = read(service: service, account: account) else {
            return nil
        }

        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }

    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as [CFString: Any]

        SecItemDelete(query as CFDictionary)
    }
}
