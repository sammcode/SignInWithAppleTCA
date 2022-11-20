//
//  SignInView.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/18/22.
//

import AuthenticationServices
import ComposableArchitecture
import SwiftUI

struct SignInView: View {
    let store: Store<SignInState, SignInAction>
    
    public init(store: Store<SignInState, SignInAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                SignInWithAppleButton { _ in } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                            viewStore.send(.signInWithAppleButtonTapped(.failure(AppleAuthenticationError.missingAppleIDCredential)))
                            return
                        }
                        let userID = credential.user
                        let response = AppleAuthenticationResponse(userID: userID)
                        viewStore.send(.signInWithAppleButtonTapped(.success(response)))
                    case .failure(let error):
                        viewStore.send(.signInWithAppleButtonTapped(.failure(error)))
                    }
                }
                .frame(width: 200, height: 44)
            }
            .navigationTitle("Sign in 👀")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView(
                store: Store(
                    initialState: SignInState(),
                    reducer: signInReducer,
                    environment: SignInEnvironment()
                )
            )
        }
    }
}
