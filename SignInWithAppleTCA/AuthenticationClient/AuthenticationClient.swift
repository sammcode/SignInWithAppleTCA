//
//  AuthenticationClient.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
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
