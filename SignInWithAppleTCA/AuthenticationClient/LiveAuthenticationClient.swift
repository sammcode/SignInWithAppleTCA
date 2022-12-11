//
//  LiveAuthenticationClient.swift
//  SignInWithAppleTCA
//

import AuthenticationServices
import Foundation

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
