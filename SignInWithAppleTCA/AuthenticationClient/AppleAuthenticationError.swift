//
//  AppleAuthenticationError.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
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
