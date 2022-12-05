//
//  RootView.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/18/22.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    let store: StoreOf<Root>
    
    var body: some View {
        SwitchStore(self.store) {
            CaseLet(state: /Root.State.main, action: Root.Action.main) { store in
                MainView(store: store)
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
