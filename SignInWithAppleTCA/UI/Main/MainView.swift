//
//  MainView.swift
//  SignInWithAppleTCA
//
//  Created by Samuel McGarry on 8/23/22.
//

import ComposableArchitecture
import SwiftUI

public struct MainView: View {

    let store: StoreOf<Main>

    public var body: some View {
        VStack {
            Button {
                ViewStore(self.store).send(.signOutButtonTapped)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            store: Store(
                initialState: Main.State(),
                reducer: Main()
            )
        )
    }
}
