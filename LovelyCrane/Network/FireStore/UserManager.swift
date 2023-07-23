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
    
    func getUserDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try getUserDocument(userId: user.uuid).setData(from: user, merge: false)
        try await getUserDocument(userId: user.uuid).collection("letter_lists").addDocument(data: ["isSent": "none"])
    }
    
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
        //현재 로그인 상태 확인
        guard let currentUserUid = Auth.auth().currentUser?.uid else { return }
        
        do {
            guard (try? await userCollection.document(partnertoken).getDocument()) != nil else { return }
//            guard partnerDocument.exists else { return }
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
