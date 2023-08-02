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
    
    var nowLoggedProvider: AuthProviderOption?
    
    // MARK: 현재 로그인 된 유저의 정보를 가져옵니다.(locally)
    func getAuthenticatedUser() throws -> AuthDataResult {
        print("⭐️로그인 되어 있는 유저 로드 시도")
        guard let user = Auth.auth().currentUser else {
            print("⭐️현재 유저를 불러오지 못했습니다.")
            throw URLError(.badServerResponse)
        }
        let currentResult = AuthDataResult(user: user)
        print("\(currentResult.email), \(currentResult.uid)")
        return AuthDataResult(user: user)
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
    func signInWithApple(tokens: SignInWithAppleResult) async throws -> AuthDataResult {
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        nowLoggedProvider = .apple
        return try await signIn(credential: credential)
        
    }
    
    //MARK: ⭐️ 구글로그인 -> 파이어베이스 인증
    @discardableResult
    func signInWithGoogle(token: SignWithGoogleResult) async throws -> AuthDataResult {
        let credential = GoogleAuthProvider.credential(withIDToken: token.idToken, accessToken: token.accessToken)
        nowLoggedProvider = .google
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResult{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResult(user: authDataResult.user)
    }
}

extension AuthenticationManager {
    
    func reauthenticationUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        switch nowLoggedProvider {
        case .apple:
            let appleCredential = try await reAuthApple()
            try await user.reauthenticate(with: appleCredential)
        case .google:
            let googleCredential = try await reAuthGoogle()
            try await user.reauthenticate(with: googleCredential)
        default:
            break
        }
    }
    
    func reAuthApple() async throws -> OAuthCredential {
        let helper = await SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let credential = OAuthProvider.credential(withProviderID: AuthProviderOption.apple.rawValue, idToken: tokens.token, rawNonce: tokens.nonce)
        return credential
    }
    
    func reAuthGoogle() async throws -> AuthCredential {
        let helper = SignInGoogleHelper()
        let token = try await helper.signIn()
        let credential = GoogleAuthProvider.credential(withIDToken: token.idToken, accessToken: token.accessToken)
        return credential
    }
}
