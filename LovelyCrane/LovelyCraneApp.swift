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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            WriteView()
                .environmentObject(WriteViewModel())
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
