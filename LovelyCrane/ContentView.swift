//
//  ContentView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @State var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            switch viewRouter.currentPage {
            case "AuthenticationView":
                AuthenticationView(showSignInView: $showSignInView)
            case "MainView":
                MainView(showSignInView: $showSignInView)
            default:
                Text("Error")
            }
        }
        .environmentObject(viewRouter)
        //로그인 여부, 닉네임 여부 확인
        .onAppear {
            if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
                let document = UserManager.shared.getUserDocument(userId: authUser.uid)
                
                

                viewRouter.currentPage = "MainView"
            } else {
                viewRouter.currentPage = "AuthenticationView"
            }
            //이미있는 경우
//            self.showSignInView = authUser == nil ? true : false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
