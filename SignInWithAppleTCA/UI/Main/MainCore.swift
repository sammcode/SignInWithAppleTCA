//
//  MainCore.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/23/22.
//

import SwiftUI
import ComposableArchitecture

// MARK: State
public struct MainState: Equatable {}

// MARK: Actions
public enum MainAction: Equatable {
    public enum Delegate: Equatable {
        case didSignOut
    }
    case signOutButtonTapped
    case delegate(Delegate)
}

// MARK: Environment
public struct MainEnvironment {}

// MARK: Reducer
public let mainReducer = AnyReducer<MainState, MainAction, MainEnvironment>.combine(
    .init {
        state, action, environment in
        switch action {
        case .signOutButtonTapped:
            KeychainItem.deleteUserIdentifierFromKeychain()
            return .init(value: .delegate(.didSignOut))
        case .delegate:
            return .none
        }
    }
)
