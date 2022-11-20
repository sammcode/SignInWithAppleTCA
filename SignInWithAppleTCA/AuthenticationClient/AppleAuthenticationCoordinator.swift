//
//  AppleAuthenticationCoordinator.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
//

import AuthenticationServices
import Foundation

class AppleAuthenticationCoordinator: NSObject {

    static let shared = AppleAuthenticationCoordinator()

    func checkAuthenticationStatus(userID: String) async -> AppleAuthenticationStatus {
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
}
