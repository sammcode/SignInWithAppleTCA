//
//  MainView.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/23/22.
//

import ComposableArchitecture
import SwiftUI

// MARK:- View
public struct MainView: View {

    let store: Store<MainState, MainAction>

    public init(store: Store<MainState, MainAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text("Welcome! 😄")
                Spacer()
                Button {
                    viewStore.send(.signOutButtonTapped)
                } label: {
                    Text("Sign out")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.blue)
                        )
                }
            }
            .padding()
        }
    }
}

// MARK: Preview
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
