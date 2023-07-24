//
//  SignInGoogleHelper.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

final class SignInGoogleHelper {
    
    @MainActor
    func signIn() async throws -> SignWithGoogleResult {
        guard let topVC = TopViewControllerManager.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badURL)
        }
        
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let userName = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokens = SignWithGoogleResult(idToken: idToken, accessToken: accessToken, userName: userName, email: email)
        return tokens
    }
}
