//
//  ContentView.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        
        ZStack {
            switch viewRouter.currentPage {
            case .AuthenticationView:
                AuthenticationView()
                    .transition(AnyTransition.opacity)
            case .MainView:
                MainView()
                    .transition(AnyTransition.opacity)
            case .NicknameView:
                NicknameView()
                    .transition(AnyTransition.opacity)
            }
        }
        .environmentObject(viewRouter)
        
        .onAppear {
            checkAuthenticationStatus()
        }
    }
}

extension ContentView {
    
    func checkAuthenticationStatus() {
        if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
            checkDocumentNickname(auth: authUser)
        } else {
            viewRouter.currentPage = .AuthenticationView
        }
    }
    
    func checkDocumentNickname(auth: AuthDataResult) {
        Task {
            let userCollection = Firestore.firestore().collection(FieldNames.Users.rawValue)
            guard
                let myDocument = try? await userCollection.document(auth.uid).getDocument(),
                let myNickname = myDocument[FieldNames.nickname.rawValue] as? String else { return }
            if myNickname.isEmpty {
                viewRouter.currentPage = .NicknameView
            } else {
                viewRouter.currentPage = .MainView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//refactored
