//
//  SignIn.swift
//  SignInWithAppleTCA
//

import Foundation
import ComposableArchitecture

public struct SignIn: ReducerProtocol {
    public struct State: Equatable {}
    
    public enum Action: Equatable {
        public enum Delegate: Equatable {
            case didSignIn
        }
        case signInWithAppleButtonTapped(TaskResult<AppleAuthenticationResponse>)
        case delegate(Delegate)
    }
    
    @Dependency(\.keychainClient) var keychainClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .signInWithAppleButtonTapped(result):
                switch result {
                case let .success(response):
                    return .run { send in
                        await keychainClient.saveUser(response.userID)
                        await send(.delegate(.didSignIn))
                    }
                case .failure:
                    return .none
                }
            case .delegate:
                return .none
            }
        }
    }
}
