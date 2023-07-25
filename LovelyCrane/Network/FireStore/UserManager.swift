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

struct DBUser: Codable {
    let uuid: String
    let nickname: String?
    let partnerId: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case nickname = "nickname"
        case partnerId = "partner_id"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.uuid, forKey: .uuid)
        try container.encodeIfPresent(self.nickname, forKey: .nickname)
        try container.encodeIfPresent(self.partnerId, forKey: .partnerId)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
        self.partnerId = try container.decodeIfPresent(String.self, forKey: .partnerId)
    }
    
    init(auth: AuthDataResult) {
        self.uuid = auth.uid
        self.nickname = ""
        self.partnerId = ""
    }
}

final class UserManager {
    static let shared = UserManager()
    private init() { }
    
    private let userCollection = Firestore.firestore().collection("Users")
    private var cuurentUserUid: String {
        return Auth.auth().currentUser?.uid ?? "none"
    }
    
    func getUserDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try getUserDocument(userId: user.uuid).setData(from: user, merge: false)
        try await getUserDocument(userId: user.uuid).collection("letter_lists").addDocument(data: ["isSent": "none"])
    }
    
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
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            guard (try? await userCollection.document(partnertoken).getDocument()) != nil else { return }
            
            let currentUserDocument = self.userCollection.document(currentUserUid)
            let partnerUserDocument = self.userCollection.document(partnertoken)
            
            try await currentUserDocument.updateData(["partner_id": partnertoken])
            try await partnerUserDocument.updateData(["partner_id": currentUserUid])
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

enum FieldNames: String {
    case Users
    case letter_lists
    case partner_id
    case nickname
}
