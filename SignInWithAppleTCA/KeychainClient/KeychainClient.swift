//
//  KeychainClient.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 1/21/23.
//

import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

public struct KeychainClient {
    public var saveUser: (String) async -> Void
    public var deleteUser: () async -> Void
    
    public init(
        saveUser: @escaping (String) async -> Void,
        deleteUser: @escaping () async -> Void
    ) {
        self.saveUser = saveUser
        self.deleteUser = deleteUser
    }
}

#if DEBUG
extension KeychainClient {
    public static let unimplemented = Self(
        saveUser: XCTUnimplemented("\(Self.self).saveUser"),
        deleteUser: XCTUnimplemented("\(Self.self).deleteUser")
    )
}
#endif

private enum KeychainClientKey: DependencyKey {
    static let liveValue = KeychainClient.live
    static let testValue = KeychainClient.unimplemented
}
extension DependencyValues {
    var keychainClient: KeychainClient {
        get { self[KeychainClientKey.self] }
        set { self[KeychainClientKey.self] = newValue }
    }
}
