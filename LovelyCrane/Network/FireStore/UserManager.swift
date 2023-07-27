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
    private init() { }

    private let batch = Firestore.firestore().batch()
    private let userCollection = Firestore.firestore().collection("Users")
    /// 테스트 위해서 uid가 없으면 일단은 "none"
    private var currentUserUID: String {
        return Auth.auth().currentUser?.uid ?? "none"
    }

    /// 내 UID를 통해 document 찾기.
    private func getUserDocument() -> DocumentReference {
        userCollection.document(currentUserUID)
    }
    /// 최초로그인인 경우 UID로 Document를 만들어주고 필드생성
    func createNewUser(user: DBUser) async throws {
        try getUserDocument().setData(from: user, merge: false)
    }
    ///  편지data를 현재해당하는 uid다큐멘트에 letter_lists라는 콜렉션을 만들어주고 그안의 documnet생성.  letterdata는 필드들.
    func postletterData(letter: LetterModel) async throws {
        let letterdata: [String:Any] = [
            "image": letter.image,
            "text": letter.text,
            "date": letter.date,
            "is_byme": letter.isByme,
            "is_read":letter.isRead,
            "is_sent": letter.isSent,
        ]
        let userDocument =  try await getUserDocument().getDocument()
        guard let userdata = userDocument.data(), let sendCount = userdata["send_count"] as? Int else {return}
        let postdata =  getUserDocument().collection("letter_lists").document()
        batch.updateData(["send_count": sendCount+1], forDocument: getUserDocument())
        batch.setData(letterdata, forDocument: postdata)
    }
    ///  모든편지데이터들을 가져와서 letterLists에 저장해놓기
    func getAllLetterData() async throws{
        var letterLists : [LetterModel] = []
        let snapshot = try await userCollection.document(currentUserUID).collection("letter_lists").getDocuments()
        for document in snapshot.documents {
            guard let stamp = document["date"] as? Timestamp,
                  let image = document["image"] as? String,
                  let text = document["text"] as? String,
                  let is_byme = document["is_byme"] as? Bool,
                  let is_sent = document["is_sent"] as? Bool,
                  let is_read = document["is_read"] as? Bool else{continue }
            let date = stamp.dateValue()
            let letterData = LetterModel(id: document.documentID, image: image, date: date, text: text, isByme: is_byme, isSent: is_sent, isRead: is_read)
            letterLists.append(letterData)
        }
        LetterLists.shared.letterListArray = letterLists
    }
    // 읽었으면 해당 도큐멘트 is_read변경
    func updateisRead(letterid: String) async throws {
        try await getUserDocument().collection("letter_lists").document(letterid).updateData(["is_read": true])
    }
    // 새로온것이면 true, past면 false
    func updateisSent(letterid: String) async throws {
        try await getUserDocument().collection("letter_lists").document(letterid).updateData(["is_sent": true])
    }
    /// letterid통해삭제
    func deleteletter(letterid: String) async throws {
        try await getUserDocument().collection("letter_lists").document(letterid).delete()
    }
    /// user끼리 커플링
    func connectUsertoUser(to partnertoken: String) async throws {
        guard (try? await userCollection.document(partnertoken).getDocument()) != nil else { return }
        let currentUserDocument = self.userCollection.document(currentUserUID)
        let partnerUserDocument = self.userCollection.document(partnertoken)
        batch.updateData(["partner_id": partnertoken], forDocument: currentUserDocument)
        batch.updateData(["partner_id": currentUserUID], forDocument: partnerUserDocument)

    }
    //상대에게 편지보내기
    func sendletterLists() async throws{
        do{
            let currentUserDocument = userCollection.document(currentUserUID)
            let partnerField = FieldNames.partner_id.rawValue
            guard let currentUserData = try await currentUserDocument.getDocument().data(), let partnerId = currentUserData[partnerField] as? String else {return}
            let partnerUserDocument = userCollection.document(partnerId)
            guard let partnerUserData = try await partnerUserDocument.getDocument().data(), partnerUserData[partnerField] as? String == currentUserUID else{ return}
            let snapshot = try await currentUserDocument.collection(FieldNames.letter_lists.rawValue)
                .whereField("is_sent", isEqualTo: false).getDocuments()
            for document in snapshot.documents {
                let letterData = document.data()
                guard let receiveCount = letterData["receive_count"] as? Int else{return}
                try await partnerUserDocument.collection(FieldNames.letter_lists.rawValue).addDocument(data: letterData)
                try await document.reference.updateData(["is_sent":true])
                batch.updateData(["receiv_count":receiveCount + 1], forDocument: partnerUserDocument)
            }
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
