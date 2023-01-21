//
//  AuthenticationClient.swift
//  SignInWithAppleTCA
//

import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay

public struct AuthenticationClient {
    public var checkAppleAuthenticationStatus: (String) async -> AppleAuthenticationStatus
    
    public init(
        checkAppleAuthenticationStatus: @escaping (String) async -> AppleAuthenticationStatus
    ) {
        self.checkAppleAuthenticationStatus = checkAppleAuthenticationStatus
    }
}

#if DEBUG
extension AuthenticationClient {
    public static let unimplemented = Self(
        checkAppleAuthenticationStatus: XCTUnimplemented("\(Self.self).checkAppleAuthenticationStatus")
    )
}
#endif

private enum AuthenticationClientKey: DependencyKey {
    static let liveValue = AuthenticationClient.live
    static let testValue = AuthenticationClient.unimplemented
}
extension DependencyValues {
    var authenticationClient: AuthenticationClient {
        get { self[AuthenticationClientKey.self] }
        set { self[AuthenticationClientKey.self] = newValue }
    }
}
