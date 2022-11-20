//
//  LiveAuthenticationClient.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
//

import Foundation

extension AuthenticationClient {
    public static let live = AuthenticationClient(
        checkAppleAuthenticationStatus: { userID in
            return await AppleAuthenticationCoordinator.shared.checkAuthenticationStatus(userID: userID)
        }
    )
}
