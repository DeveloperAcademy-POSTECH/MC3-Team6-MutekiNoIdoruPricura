//
//  AuthenticationViewModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/18.
//

import Foundation
import FirebaseFirestore

@MainActor
final class AuthenticaitonViewModel: ObservableObject {
    
    func signInApple() async throws {
        
        //가입 정보가 있는지 확인하고 있다면 return
        
        //가입 정보가 없다면
        
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
//        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        
        //디비에 데이터 있는 지 확인해줘야함
        let userCollection = Firestore.firestore().collection("Users")
        
        //문서가 존재하나요?
        if try await userCollection.document(authDataResult.uid).getDocument().exists {
            return
        } else {
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
        }
        
        
    }
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(token: tokens)
    }
}
