//
//  Main.swift
//  SignInWithAppleTCA
//

import SwiftUI
import ComposableArchitecture

public struct Main: ReducerProtocol {
    public struct State: Equatable {}
    
    public enum Action: Equatable {
        public enum Delegate: Equatable {
            case didSignOut
        }
        case signOutButtonTapped
        case delegate(Delegate)
    }
    
    @Dependency(\.keychainClient) var keychainClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .signOutButtonTapped:
                return .run { send in
                    await keychainClient.deleteUser()
                    await send(.delegate(.didSignOut))
                }
            case .delegate:
                return .none
            }
        }
    }
}
