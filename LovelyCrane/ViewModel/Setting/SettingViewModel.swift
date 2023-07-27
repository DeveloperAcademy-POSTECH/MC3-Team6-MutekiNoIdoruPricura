//
//  SettingsViewModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import SwiftUI

@MainActor
final class SettingViewModel: ObservableObject {
    @Published var authProviders: [AuthProviderOption] = []
    @Published var authUser: AuthDataResult?
    
    func loadAuthProvider() {
        if let provider = try? AuthenticationManager.shared.getProviders() {
            authProviders = provider
        }
    }
    
    func loadAuthUser() {
        self.authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func logout() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func deleteUser() async throws {
        UserManager.shared.deleteUserDocument()
        try await AuthenticationManager.shared.deleteUser()
    }
}
