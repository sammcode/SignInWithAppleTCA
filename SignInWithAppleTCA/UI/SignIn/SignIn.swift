//
//  SignIn.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
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
            case let .signInWithAppleButtonTapped(.success(response)):
                KeychainItem.saveUserInKeychain(response.userID)
                return .init(value: .delegate(.signInSuccess))
            case let .signInWithAppleButtonTapped(.failure(error)):
                return .none
            case .delegate:
                return .none
            }
        }
    }
}
