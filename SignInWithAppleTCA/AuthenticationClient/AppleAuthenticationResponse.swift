//
//  AppleAuthenticationResponse.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
//

import Foundation

public struct AppleAuthenticationResponse: Equatable {
    public let id = UUID()
    public var userID: String
}
