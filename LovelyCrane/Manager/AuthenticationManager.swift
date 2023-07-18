//
//  AuthenticationManager.swift
//  LoveCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation
import FirebaseAuth

//MARK: 로그인 프로바이더 정보 관리를 위한 열거형
enum AuthProviderOption: String {
    case google = "google.com"
    case apple = "apple.com"
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    // MARK: 현재 로그인 된 유저의 정보를 가져옵니다.(locally)
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    // MARK: 로그아웃
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // MARK: 회원탈퇴(⚠️ 서버에서 유저 삭제)
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
    
    // MARK: SSO 로그인 프로바이더 배열을 가져옵니다.(ex. apple, google)
    func getProviders() throws -> [AuthProviderOption] {
        guard let providerData = Auth.auth().currentUser?.providerData else {
            throw URLError(.badURL)
        }
        var providers: [AuthProviderOption] = []
        for provider in providerData {
            if let option = AuthProviderOption(rawValue: provider.providerID) {
                providers.append(option)
            } else  {
                assertionFailure("provider option not found: \(provider.providerID)")
            }
        }
        return providers
    }
}

extension AuthenticationManager {
    
    //MARK: ⭐️ 애플로그인 -> 파이어베이스 인증
    @discardableResult
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResultModel {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
