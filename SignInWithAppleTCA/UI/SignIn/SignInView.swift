//
//  SignInView.swift
//  SignInWithAppleTCA
//

import AuthenticationServices
import ComposableArchitecture
import SwiftUI

struct SignInView: View {
    let store: StoreOf<SignIn>
    
    var body: some View {
        VStack {
            SignInWithAppleButton { _ in } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                        ViewStore(self.store).send(.signInWithAppleButtonTapped(.failure(AppleAuthenticationError.missingAppleIDCredential)))
                        return
                    }
                    let userID = credential.user
                    let response = AppleAuthenticationResponse(userID: userID)
                    ViewStore(self.store).send(.signInWithAppleButtonTapped(.success(response)))
                case .failure(let error):
                    ViewStore(self.store).send(.signInWithAppleButtonTapped(.failure(error)))
                }
            }
            .frame(width: 200, height: 44)
        }
        .navigationTitle("Sign in 👀")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView(
                store: Store(
                    initialState: SignIn.State(),
                    reducer: SignIn()
                )
            )
        }
    }
}
