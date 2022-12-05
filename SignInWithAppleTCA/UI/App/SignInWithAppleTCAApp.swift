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
        initialState: Root.State(),
        reducer: Root()
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RootView(store: self.store)
            }
            .preferredColorScheme(.light)
        }
    }
}
