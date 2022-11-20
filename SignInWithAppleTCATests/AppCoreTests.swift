//
//  AppCoreTests.swift
//  SignInWithAppleTCATests
//
//  Created by Samuel McGarry on 11/20/22.
//

import ComposableArchitecture
import XCTest

@testable import SignInWithAppleTCA

@MainActor
final class AppCoreTests: XCTestCase {
    
    func testSignInDelegate() async {
        let appleAuthenticationResponse = AppleAuthenticationResponse(userID: "1234")
        
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                authenticationClient: AuthenticationClient.unimplemented
            )
        )
        
        let _ = await store.send(.signIn(.signInWithAppleButtonTapped(.success(appleAuthenticationResponse))))
        
        await store.receive(
            .signIn(
                .delegate(
                    .signInSuccess
                )
            )
        ) {
            $0 = .main(MainState())
        }
    }
    
    func testMainDelegate() async {
        let store = TestStore(
            initialState: AppState(status: .signedIn),
            reducer: appReducer,
            environment: AppEnvironment(
                authenticationClient: AuthenticationClient.unimplemented
            )
        )
        
        let _ = await store.send(.main(.signOutButtonTapped))
        
        await store.receive(
            .main(
                .delegate(
                    .didSignOut
                )
            )
        ) {
            $0 = .signIn(SignInState())
        }
    }
    
    func testAuthenticationStatusCheckSignedIn() async {
        var authenticationClient = AuthenticationClient.unimplemented
        
        authenticationClient.checkAppleAuthenticationStatus = { _ in
            .signedIn
        }
        
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                authenticationClient: authenticationClient
            )
        )
        
        let _ = await store.send(._onAppear)
        
        await store.receive(
            ._checkAuthenticationStatusResponse(.signedIn)
        ) {
            $0 = .main(MainState())
        }
    }
    
    func testAuthenticationStatusCheckSignedOut() async {
        var authenticationClient = AuthenticationClient.unimplemented
        
        authenticationClient.checkAppleAuthenticationStatus = { _ in
            .signedOut
        }
        
        let store = TestStore(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                authenticationClient: authenticationClient
            )
        )
        
        let _ = await store.send(._onAppear)
        
        await store.receive(
            ._checkAuthenticationStatusResponse(.signedOut)
        )
    }
}
