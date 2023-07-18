//
//  AuthenticationViewModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation

@MainActor
final class AuthenticaitonViewModel: ObservableObject {
    
    func signInApple() async throws -> String{
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let data = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        return data.uid
    }
}
