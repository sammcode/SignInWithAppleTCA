//
//  SignInCore.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
//

import Foundation
import ComposableArchitecture

public struct SignInState: Equatable {}

public enum SignInAction: Equatable {
    public enum Delegate: Equatable {
        case signInSuccess
    }
    case signInWithAppleButtonTapped(TaskResult<AppleAuthenticationResponse>)
    case delegate(Delegate)
}

public struct SignInEnvironment {}

public let signInReducer = AnyReducer<SignInState, SignInAction, SignInEnvironment>.combine(
    .init {
        state, action, environment in
        switch action {
        case let .signInWithAppleButtonTapped(.success(response)):
            KeychainItem.saveUserInKeychain(response.userID)
            return .init(value: .delegate(.signInSuccess))
        case let .signInWithAppleButtonTapped(.failure(error)):
            return .none
        case .delegate:
            return .none
        }
    }
)
