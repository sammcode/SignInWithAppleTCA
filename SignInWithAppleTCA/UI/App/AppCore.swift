//
//  AppCore.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/18/22.
//

import ComposableArchitecture
import Foundation

public enum AppState: Equatable {
    case signIn(SignInState)
    case main(MainState)
    
    public init() { self = .signIn(SignInState()) }
    init(status: AppleAuthenticationStatus) {
        switch status {
        case .signedIn:
            self = .main(MainState())
        case .signedOut:
            self = .signIn(SignInState())
        }
    }
}

public enum AppAction: Equatable {
    case signIn(SignInAction)
    case main(MainAction)
    
    case _onAppear
    case _checkAuthenticationStatusResponse(AppleAuthenticationStatus)
}

public struct AppEnvironment {
    public var authenticationClient: AuthenticationClient
    
    public init(
        authenticationClient: AuthenticationClient
    ) {
        self.authenticationClient = authenticationClient
    }
}

public let appReducer = AnyReducer<AppState, AppAction, AppEnvironment>.combine(
    signInReducer.pullback(
        state: /AppState.signIn,
        action: /AppAction.signIn,
        environment: { _ in
            SignInEnvironment()
        }
    ),
    mainReducer.pullback(
        state: /AppState.main,
        action: /AppAction.main,
        environment: { _ in
            MainEnvironment()
        }
    ),
    AnyReducer { state, action, environment in
        switch action {
        case ._onAppear:
            return .task {
                ._checkAuthenticationStatusResponse(
                    await environment.authenticationClient.checkAppleAuthenticationStatus(KeychainItem.currentUserIdentifier)
                )
            }
        case let ._checkAuthenticationStatusResponse(status):
            switch status {
            case .signedIn:
                state = .main(MainState())
            case .signedOut:
                state = .signIn(SignInState())
            }
            return .none
        case .signIn(.delegate(.signInSuccess)):
            state = .main(MainState())
            return .none
        case .main(.delegate(.didSignOut)):
            state = .signIn(SignInState())
            return .none
        case .signIn:
            return .none
        case .main:
            return .none
        }
    }
)
