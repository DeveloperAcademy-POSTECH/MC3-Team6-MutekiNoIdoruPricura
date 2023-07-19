//
//  LovelyCraneApp.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI
import FirebaseCore

@main
struct LovelyCraneApp: App {
    @StateObject var viewRouter = ViewRouter()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            NavigationStack {
                ContentView()
                    .environmentObject(viewRouter)
//            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
