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
    private var cuurentUserUid: String {
        return Auth.auth().currentUser?.uid ?? "none"
    }
    func createNewUser(user: Info) async throws{
        let userData: [String:Any] = [
            "uuid" : cuurentUserUid,
            "nickname" : user.nickname ?? "",
            "partner_id" : user.partnerId ?? "",
        ]
        try await userCollection.document(cuurentUserUid)
            .setData(userData,merge: false)
    }

    func updateletterData(letter: WriteModel) {
        let idString = letter.id.uuidString
        let letterdata: [String:Any] = [
            "image": letter.image,
            "text": letter.text,
            "date": letter.date,
            "is_byme": letter.is_byme,
            "is_read":letter.is_read,
            "is_sent": letter.is_sent,
            "id": idString
        ]
        userCollection.document(cuurentUserUid).collection("letter_lists").addDocument(data: letterdata)
    }

    func getletterData(letterid: String) async throws {
        userCollection.document(cuurentUserUid).collection("letter_lists").document(letterid).getDocument{(document,error) in
            guard error == nil else{return}
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print(data)
                }
            }
        }
    }
    func connectUsertoUser(to partnertoken: String) async throws {
        do{
            let document = try await userCollection.document(partnertoken).getDocument()
            guard document.exists else {return}
            let currentUserData = self.userCollection.document(cuurentUserUid)
            let partnerUserData = self.userCollection.document(partnertoken)
            try await currentUserData.updateData(["partner_id": partnertoken])
            try await partnerUserData.updateData(["partner_id": cuurentUserUid])
        } catch {
            print(error)
        }
    }
}
