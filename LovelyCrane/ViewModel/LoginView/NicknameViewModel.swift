//
//  NicknameViewModel.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class NicknameViewModel: ObservableObject {
    
    @Published var nickname: String = ""
    
    init() {
        if let savedNickname = UserDefaults.standard.string(forKey: "nickname") {
            self.nickname = savedNickname
        }
    }
    
    func isValidNickName() -> Bool {
        if nickname.isEmpty || nickname.count > 8 {
            return false
        }
        return true
    }
    
    func updateNickName(nickName: String) async throws {
        guard let user = Auth.auth().currentUser else { return }
        let userCollection = Firestore.firestore().collection("Users")
        let document = userCollection.document(user.uid)
        
        let data: [String: Any] = [DBUser.CodingKeys.nickname.rawValue : nickname]
        try await document.updateData(data)
        self.nickname = nickName
        UserDefaults.standard.set(nickName, forKey: "nickname")
    }
}
