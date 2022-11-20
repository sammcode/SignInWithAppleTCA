//
//  SignInWithAppleTCAApp.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 11/6/22.
//

import ComposableArchitecture
import SwiftUI

@main
struct SignInWithAppleTCAApp: App {
    let store = Store(
        initialState: AppState(),
        reducer: appReducer,
        environment: AppEnvironment(
            authenticationClient: .live
        )
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                AppView(store: self.store)
            }
            .preferredColorScheme(.light)
        }
    }
}
