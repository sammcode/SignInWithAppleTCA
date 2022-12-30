//
//  SignInWithAppleTCATests.swift
//  SignInWithAppleTCATests
//

import ComposableArchitecture
import XCTest

@testable import SignInWithAppleTCA

@MainActor
final class SignInWithAppleTCATests: XCTestCase {
    
    func testSignInDelegate() async {
        let appleAuthenticationResponse = AppleAuthenticationResponse(userID: "1234")
        
        let store = TestStore(
            initialState: Root.State(),
            reducer: Root()
        )
        
        let _ = await store.send(.signIn(.signInWithAppleButtonTapped(.success(appleAuthenticationResponse))))
        
        await store.receive(
            .signIn(
                .delegate(
                    .didSignIn
                )
            )
        ) {
            $0 = .main(Main.State())
        }
    }
    
    func testMainDelegate() async {
        let store = TestStore(
            initialState: Root.State(status: .signedIn),
            reducer: Root()
        )
        
        let _ = await store.send(.main(.signOutButtonTapped))
        
        await store.receive(
            .main(
                .delegate(
                    .didSignOut
                )
            )
        ) {
            $0 = .signIn(SignIn.State())
        }
    }
    
    func testAuthenticationStatusCheckSignedIn() async {
        let store = TestStore(
            initialState: Root.State(),
            reducer: Root()
        )
        
        var authenticationClient = AuthenticationClient.unimplemented
        
        authenticationClient.checkAppleAuthenticationStatus = { _ in
            .signedIn
        }
        
        store.dependencies.authenticationClient = authenticationClient
        
        let _ = await store.send(._onAppear)
        
        await store.receive(
            ._checkAuthenticationStatusResponse(.signedIn)
        ) {
            $0 = .main(Main.State())
        }
    }
    
    func testAuthenticationStatusCheckSignedOut() async {
        let store = TestStore(
            initialState: Root.State(),
            reducer: Root()
        )
        
        var authenticationClient = AuthenticationClient.unimplemented
        
        authenticationClient.checkAppleAuthenticationStatus = { _ in
            .signedOut
        }
        
        store.dependencies.authenticationClient = authenticationClient
        
        let _ = await store.send(._onAppear)
        
        await store.receive(
            ._checkAuthenticationStatusResponse(.signedOut)
        )
    }
}
