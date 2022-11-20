//
//  AppView.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/18/22.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    public init(store: Store<AppState, AppAction>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            SwitchStore(self.store) {
                CaseLet(state: /AppState.signIn, action: AppAction.signIn) { store in
                    SignInView(store: store)
                }
                CaseLet(state: /AppState.main, action: AppAction.main) { store in
                    MainView(store: store)
                }
            }
            .onAppear {
                viewStore.send(._onAppear)
            }
        }
    }
}
