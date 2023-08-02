//
//  ContentView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import FirebaseFirestore
import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        NavigationView {
            ZStack {
                switch viewRouter.currentPage {
                case .launchsScreenView:
                    LaunchScreenView()
                        .transition(AnyTransition.opacity)
                case .authenticationView:
                    AuthenticationView()
                        .transition(AnyTransition.opacity)
                case .mainView:
                    MainView()
                        .transition(AnyTransition.opacity)
                case .nicknameView:
                    NicknameView()
                        .transition(AnyTransition.opacity)
                }
            }
            .environmentObject(viewRouter)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ViewRouter()
        ContentView().environmentObject(view)
    }
}
