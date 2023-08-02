//
//  LovelyCraneApp.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct LovelyCraneApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewRouter)
                .onAppear {
                    checkAuthenticationStatus()
                }
        }

    }

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

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
