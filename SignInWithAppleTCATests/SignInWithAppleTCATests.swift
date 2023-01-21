//
//  SignInWithAppleTCATests.swift
//  SignInWithAppleTCATests
//

import ComposableArchitecture
import XCTest

@testable import SignInWithAppleTCA

@MainActor
final class SignInWithAppleTCATests: XCTestCase {
    
    func testSignInSuccess() async {
        let appleAuthenticationResponse = AppleAuthenticationResponse(userID: "1234")
        
        let store = TestStore(
            initialState: Root.State(),
            reducer: Root()
        )
        
        store.dependencies.keychainClient.saveUser = { _ in }
        
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
    
    func testSignOut() async {
        let store = TestStore(
            initialState: Root.State(status: .signedIn),
            reducer: Root()
        )
        
        store.dependencies.keychainClient.deleteUser = {}
        
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
        
        store.dependencies.authenticationClient.checkAppleAuthenticationStatus = { _ in
            .signedIn
        }
        
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
        
        store.dependencies.authenticationClient.checkAppleAuthenticationStatus = { _ in
            .signedOut
        }
        
        let _ = await store.send(._onAppear)
        
        await store.receive(
            ._checkAuthenticationStatusResponse(.signedOut)
        )
    }
}
