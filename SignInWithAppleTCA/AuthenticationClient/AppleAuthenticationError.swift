//
//  AppleAuthenticationError.swift
//  SignInWithAppleTCA
//

import Foundation

public enum AppleAuthenticationError: Equatable, LocalizedError {
    case missingAppleIDCredential
    
    public var errorDescription: String? {
        switch self {
        case .missingAppleIDCredential:
            return "Unable to find an Apple ID credential."
        }
    }
}
