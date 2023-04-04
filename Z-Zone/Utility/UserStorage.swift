//
//  UserStorage.swift
//  Z-Zone
//
//  Created by Mark Laramee on 4/3/23.
//

import Foundation

class UserStorage {

    let globalUser = "global"
    let userDefaults: UserDefaults

    static let shared: UserStorage = {
        return UserStorage()
    }()

    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveUserValue(forKey key: Key, value: Any, userID: String) {
        userDefaults.set(value, forKey: key.make(for: userID))
    }

    func saveGlobalValue(forKey key: Key, value: Any) {
        saveUserValue(forKey: key, value: value, userID: globalUser)
    }

    func readUserValue<T>(forKey key: Key, userID: String) -> T? {
        return userDefaults.value(forKey: key.make(for: userID)) as? T
    }

    func readGlobalValue<T>(forKey key: Key) -> T? {
        return readUserValue(forKey: key, userID: globalUser)
    }

    func deleteUserValue(forKey key: Key, userID: String) {
        userDefaults.removeObject(forKey: key.make(for: userID))
    }

    func deleteGlobalValue(forKey key: Key) {
        deleteUserValue(forKey: key, userID: globalUser)
    }

    func deleteAllUserValues(userID: String) {
        Key
            .allCases
            .map { $0.make(for: userID) }
            .forEach { key in
                userDefaults.removeObject(forKey: key)
        }
    }

    func deleteAllGlobalValues() {
        deleteAllUserValues(userID: globalUser)
    }

    enum Key: String, CaseIterable {
        case deviceIdentifier
        case accessToken
        case refreshToken
        case tokenExpiration
        case username

        func make(for userID: String) -> String {
            return self.rawValue + "_" + userID
        }
    }
}

