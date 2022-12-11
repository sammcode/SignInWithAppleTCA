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
            case signInSuccess
        }
        case signInWithAppleButtonTapped(TaskResult<AppleAuthenticationResponse>)
        case delegate(Delegate)
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .signInWithAppleButtonTapped(result):
                switch result {
                case let .success(response):
                    KeychainItem.saveUserInKeychain(response.userID)
                    return .init(value: .delegate(.signInSuccess))
                case .failure:
                    return .none
                }
            case .delegate:
                return .none
            }
        }
    }
}
