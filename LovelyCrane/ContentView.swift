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
    @State var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            switch viewRouter.currentPage {
            case .AuthenticationView:
                AuthenticationView(showSignInView: $showSignInView)
                    .transition(AnyTransition.opacity)
            case .MainView:
                MainView(showSignInView: $showSignInView)
                    .transition(AnyTransition.opacity.animation(.easeInOut))
                    
            case .NicknameView:
                NickNameView(showSignInView: $showSignInView)
                    .transition(AnyTransition.opacity)
            default:
                Text("Error")
            }
        }
        .environmentObject(viewRouter)
        //로그인 여부, 닉네임 여부 확인
        .onAppear {
            if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
                Task {
//                    let document = UserManager.shared.getUserDocument(userId: authUser.uid)
                    let userCollection = Firestore.firestore().collection("Users")
                    // Thread 1: "Subscript key must be an NSString or FIRFieldPath."
                    
                    //닉네임이 메일로 들어가네
                    guard let myDocument = try? await userCollection.document(authUser.uid).getDocument() else { return }
                    guard let myNickname = myDocument["nickname"] as? String else { return }
                    
                    if myNickname.isEmpty {
                        viewRouter.currentPage = .NicknameView
                    } else {
                        viewRouter.currentPage = .MainView
                    }
                }
            } else {
                
                viewRouter.currentPage = .AuthenticationView
                
//                if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
//                    Task {
//                        let userCollection = Firestore.firestore().collection("Users")
//                        guard let partnerDocument = try? await userCollection.document(authUser.uid).getDocument() else { return }
//                        guard let myNickname = partnerDocument["nickname"] as? String else { return }
//
//                        if myNickname.isEmpty {
//                            viewRouter.currentPage = "NicknameView"
//                        } else {
//                            viewRouter.currentPage = "MainView"
//                        }
//                    }
//                }
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
