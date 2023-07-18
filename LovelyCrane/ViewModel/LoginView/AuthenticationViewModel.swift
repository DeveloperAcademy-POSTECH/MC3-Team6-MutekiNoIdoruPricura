//
//  AuthenticationViewModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation

@MainActor
final class AuthenticaitonViewModel: ObservableObject {
    
    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(token: tokens)
    }
}
