//
//  LiveAuthenticationClient.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
//

import Foundation
import AuthenticationServices

extension AuthenticationClient {
    public static let live = AuthenticationClient(
        checkAppleAuthenticationStatus: { userID in
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            do {
                let credentialState = try await appleIDProvider.credentialState(forUserID: userID)
                switch credentialState {
                case .authorized:
                    return .signedIn
                default:
                    return .signedOut
                }
            } catch {
                return .signedOut
            }
        }
    )
}
