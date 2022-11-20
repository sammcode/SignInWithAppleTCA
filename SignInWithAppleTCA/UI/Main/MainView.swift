//
//  MainView.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/23/22.
//

import ComposableArchitecture
import SwiftUI

public struct MainView: View {

    let store: Store<MainState, MainAction>

    public init(store: Store<MainState, MainAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Button {
                    viewStore.send(.signOutButtonTapped)
                } label: {
                    Text("Sign out")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.blue)
                        )
                }
            }
            .navigationTitle("Welcome! 😄")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store<MainState, MainAction>(
                initialState: MainState(),
                reducer: mainReducer,
                environment: MainEnvironment()
            )
        )
    }
}
