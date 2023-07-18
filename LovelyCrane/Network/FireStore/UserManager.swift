//
//  FirebaseNetwork.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/14.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
final class UserManager {
    static let shared = UserManager()
    private let userCollection = Firestore.firestore().collection("Users")
    func createNewUser(user: Info) async throws{

        let userData: [String:Any] = [
            "uuid" : user.uuid,
            "nickname" : user.nickname ?? "",
            "partner_id" : user.partnerId ?? "",
            "my_code" : user.mycode
        ]
        try await userCollection.document(user.uuid)
            .setData(userData,merge: false)

        try await userCollection.document(user.uuid).collection("letter_lists").addDocument(data: ["isSent" : "none"])
    }



}
