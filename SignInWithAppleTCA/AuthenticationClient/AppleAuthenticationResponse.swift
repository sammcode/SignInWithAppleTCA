//
//  AppleAuthenticationResponse.swift
//  SignInWithAppleTCA
//

import Foundation

public struct AppleAuthenticationResponse: Equatable {
    public let id = UUID()
    public var userID: String
}
