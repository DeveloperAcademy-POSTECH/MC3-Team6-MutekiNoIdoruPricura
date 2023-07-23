//
//  NicknameViewModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class NicknameViewModel: ObservableObject {
    
    @Published var nickname: String = ""

//    func addmemeber() async throws {
//        guard let user = Auth.auth().currentUser else { return }
//        let authDataResult =  AuthDataResult(user: user)
//        let dbUser = DBUser(auth: authDataResult)
//        try await UserManager.shared.createNewUser(user: dbUser)
//    }
    
    func updateNickName(nickName: String) async throws {
        guard let user = Auth.auth().currentUser else { return }
        let userCollection = Firestore.firestore().collection("Users")
        let document = userCollection.document(user.uid)
        
        let data: [String: Any] = [DBUser.CodingKeys.nickname.rawValue : nickname]
        try await document.updateData(data)
    }

    //TODO: TextField 
}
//refactored
