//
//  Root.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/18/22.
//

import ComposableArchitecture
import Foundation

public struct Root: ReducerProtocol {
    public enum State: Equatable {
        case signIn(SignIn.State)
        case main(Main.State)
        
        public init() {
            self = .signIn(SignIn.State())
        }
        
        init(status: AppleAuthenticationStatus) {
            switch status {
            case .signedIn:
                self = .main(Main.State())
            case .signedOut:
                self = .signIn(SignIn.State())
            }
        }
    }
    
    public enum Action: Equatable {
        case signIn(SignIn.Action)
        case main(Main.Action)
        
        case _onAppear
        case _checkAuthenticationStatusResponse(AppleAuthenticationStatus)
    }
    
    @Dependency(\.authenticationClient) var authenticationClient
    
    public var body: some ReducerProtocol<State, Action> {
        Scope(
            state: /State.signIn,
            action: /Action.signIn
        ) {
            SignIn()
        }
        Scope(
            state: /State.main,
            action: /Action.main
        ) {
            Main()
        }
        Reduce { state, action in
            switch action {
            case ._onAppear:
                return .task {
                    ._checkAuthenticationStatusResponse(
                        await authenticationClient.checkAppleAuthenticationStatus(KeychainItem.currentUserIdentifier)
                    )
                }
            case let ._checkAuthenticationStatusResponse(status):
                switch status {
                case .signedIn:
                    state = .main(Main.State())
                case .signedOut:
                    state = .signIn(SignIn.State())
                }
                return .none
            case let .signIn(action):
                switch action {
                case .delegate(.signInSuccess):
                    state = .main(Main.State())
                default:
                    break
                }
                return .none
            case let .main(action):
                switch action {
                case .delegate(.didSignOut):
                    state = .signIn(SignIn.State())
                default:
                    break
                }
                return .none
            }
        }
    }
}
