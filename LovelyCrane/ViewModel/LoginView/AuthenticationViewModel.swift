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
    
    func signInApple() async throws -> AuthDataResult {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        let authDataResult = try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
        
        try await checkUserDocumentExistence(auth: authDataResult)
        return authDataResult
    }
    
    @discardableResult
    func signInGoogle() async throws -> AuthDataResult {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(token: tokens)
        
        try await checkUserDocumentExistence(auth: authDataResult)
        return authDataResult
    }
    
    func checkUserDocumentExistence(auth: AuthDataResult) async throws {
        let userCollection = Firestore.firestore().collection(FieldNames.Users.rawValue)
        if try await userCollection.document(auth.uid).getDocument().exists { return
        } else {
            print(auth)
            let user = DBUser(auth: auth)
            try await UserManager.shared.createNewUser(user: user)
        }
    }
}
