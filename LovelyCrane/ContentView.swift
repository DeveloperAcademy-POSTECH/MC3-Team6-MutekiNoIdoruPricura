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
                        .onAppear {
                            checkAuthenticationStatus()
                        }
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

extension ContentView {

    func checkAuthenticationStatus() {
        if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
            Task {
                try await UserManager.shared.getmyUserData()
                await checkDocumentNickName()
            }
        } else {
            viewRouter.currentPage = .authenticationView
        }
    }

    func checkDocumentNickName() async {
        viewRouter.currentPage = UserInfo.shared.nickName.isEmpty ? .nicknameView : .mainView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ViewRouter()
        ContentView().environmentObject(view)
    }
}
