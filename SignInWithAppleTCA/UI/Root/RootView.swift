//
//  RootView.swift
//  SignInWithAppleTCA
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: StoreOf<Root>
    
    var body: some View {
        SwitchStore(self.store) {
            CaseLet(state: /Root.State.signIn, action: Root.Action.signIn) { store in
                SignInView(store: store)
            }
            CaseLet(state: /Root.State.main, action: Root.Action.main) { store in
                MainView(store: store)
            }
        }
        .onAppear {
            ViewStore(self.store).send(._onAppear)
        }
    }
}
