//
//  LiveKeychainClient.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 1/21/23.
//

import Foundation

extension KeychainClient {
    static let live = KeychainClient(
        saveUser: { userID in
            KeychainItem.saveUserInKeychain(userID)
        },
        deleteUser: {
            KeychainItem.deleteUserIdentifierFromKeychain()
        }
    )
}
