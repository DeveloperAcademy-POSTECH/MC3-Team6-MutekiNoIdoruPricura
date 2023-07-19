//
//  FirebaseNetwork.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/14.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
final class UserManager {
    static let shared = UserManager()
    private let userCollection = Firestore.firestore().collection("Users")
    func createNewUser(user: Info) async throws{
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        let userData: [String:Any] = [
            "uuid" : currentUserUid,
            "nickname" : user.nickname ?? "",
            "partner_id" : user.partnerId ?? "",
        ]
        try await userCollection.document(currentUserUid)
            .setData(userData,merge: false)

        try await userCollection.document(currentUserUid).collection("letter_lists").addDocument(data: ["isSent" : "none"])
    }

    func connectUsertoUser(to partnertoken: String) async throws {
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        do{
            let document = try await userCollection.document(partnertoken).getDocument()
            guard document.exists else {return}
            let currentUserData = self.userCollection.document(currentUserUid)
            let partnerUserData = self.userCollection.document(partnertoken)
            try await currentUserData.updateData(["partner_id": partnertoken])
            try await partnerUserData.updateData(["partner_id": currentUserUid])
        }
        catch {
            print(error)
        }
    }
}
