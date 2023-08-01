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
    private init() {}

    private let userCollection = Firestore.firestore().collection("Users")
    /// 테스트 위해서 uid가 없으면 일단은 "none"
    var currentUserUID: String {
        return Auth.auth().currentUser?.uid ?? "none"
    }
    /// 내 UID를 통해 document 찾기.
    private func getUserDocument() -> DocumentReference {
        userCollection.document(currentUserUID)
    }
    /// 최초로그인인 경우 UID로 Document를 만들어주고 필드생성
    func createNewUser(user: DBUser) async throws {
        try getUserDocument()
            .setData(from: user, merge: false)
    }
    ///  편지data를 현재해당하는 uid다큐멘트에 letter_lists라는 콜렉션을 만들어주고 그안의 documnet생성.  letterdata는 필드들.
    func postletterData(letter: LetterModel) async throws {
        let batch = Firestore.firestore().batch()
        let letterdata: [String:Any] = [
            "image": letter.image,
            "text": letter.text,
            "date": letter.date,
            "is_byme": letter.isByme,
            "is_read":letter.isRead,
            "is_sent": letter.isSent,
        ]
        let userDocument =  try await getUserDocument().getDocument()
        guard let userdata = userDocument.data(), let sendCount = userdata["send_count"] as? Int, let notsendCount = userdata["notsend_count"] as? Int else { return }
        let postdata =  getUserDocument().collection("letter_lists").document()
        batch
            .updateData(["notsend_count" : notsendCount + 1], forDocument: getUserDocument())
        batch
            .updateData(["send_count": sendCount+1], forDocument: getUserDocument())
        batch
            .setData(letterdata, forDocument: postdata)
        try await batch.commit()
    }
    ///  모든편지데이터들을 가져와서 letterLists에 저장해놓기
    func getAllLetterData() async throws{
        var letterLists : [LetterModel] = []
        let snapshot = try await getUserDocument().collection("letter_lists")
            .getDocuments()
        for document in snapshot.documents {
            guard let stamp = document["date"] as? Timestamp,
                  let image = document["image"] as? String,
                  let text = document["text"] as? String,
                  let is_byme = document["is_byme"] as? Bool,
                  let is_sent = document["is_sent"] as? Bool,
                  let is_read = document["is_read"] as? Bool else { continue }
            let date = stamp.dateValue()
            let letterData = LetterModel(id: document.documentID, image: image, date: date, text: text, isByme: is_byme, isSent: is_sent, isRead: is_read)
            letterLists.append(letterData)
        }
        LetterListsManager.shared.letterListArray = letterLists
    }
    // Todo
    func getmyUserData() async throws {
        let snapshot = try await getUserDocument().getDocument()
        let partnerField = FieldNames.partner_id.rawValue
        guard let data = snapshot.data() else {return}
        guard let partnertoken = data[partnerField] as? String else {return}
        let partnerDocument = try await userCollection.document(partnertoken).getDocument()
        DispatchQueue.main.async {
            UserInfo.shared.nickName = data["nickname"] as! String
            UserInfo.shared.sendLetterCount = data["send_count"] as! Int
            //여기는 notsend카운트 추가
            //        UserInfo.shared.notSendCount =
            UserInfo.shared.receiveLetterCount = data["receive_count"] as! Int
            //파트너 닉네임으로 변경해서 받아오도록하자
            UserInfo.shared.partnerNickName = partnerDocument[FieldNames.nickname.rawValue] as! String
        }
    }

    // 읽었으면 해당 도큐멘트 is_read변경
    func updateisRead(letterid: String) async throws {
        try await getUserDocument().collection("letter_lists").document(letterid)
            .updateData(["is_read": true])
    }
    // 새로온것이면 true, past면 false
    func updateisSent(letterid: String) async throws {
        try await getUserDocument().collection("letter_lists").document(letterid)
            .updateData(["is_sent": true])
    }
    /// letterid통해삭제
    func deleteletter(letterid: String) async throws {
        let letter = try await getUserDocument().collection("letter_lists").document(letterid).getDocument()
        guard let imagepath = letter["image"] as? String else { return }
        try await getUserDocument().collection("letter_lists").document(letterid)
            .delete()
        try await StorageManager.shared.deleteImage(path: imagepath)
    }
    /// user끼리 커플링
    func connectUsertoUser(to partnertoken: String) async throws -> Bool {
        do {
            let batch = Firestore.firestore().batch()
            let partnerDocument = try await userCollection.document(partnertoken).getDocument()
            if partnerDocument.exists {
                let partnerUserDocument = self.userCollection.document(partnertoken)
                batch
                    .updateData(["partner_id": partnertoken], forDocument: getUserDocument())
                batch
                    .updateData(["partner_id": currentUserUID], forDocument: partnerUserDocument)
                try await batch
                    .commit()
                return true
            } else {
                return false }
        } catch {
            return false
        }
    }
    //상대에게 편지보내기
    func sendletterLists() async throws {
        do{
            let batch = Firestore.firestore().batch()
            let partnerField = FieldNames.partner_id.rawValue
            guard let currentUserData = try await getUserDocument().getDocument().data(),
                  let partnerId = currentUserData[partnerField] as? String else { return }
            let partnerUserDocument = userCollection.document(partnerId)
            guard let partnerUserData = try await partnerUserDocument.getDocument().data(),
                    partnerUserData[partnerField] as? String == currentUserUID else { return }
            let snapshot = try await getUserDocument().collection(FieldNames.letter_lists.rawValue)
                .whereField("is_sent", isEqualTo: false)
                .getDocuments()
            for document in snapshot.documents {
                try await document.reference
                    .updateData(["send_date": Date.getNowDate()])
                var letterData = document.data()
                letterData["send_date"] = Date.getNowDate()
                try await partnerUserDocument.collection(FieldNames.letter_lists.rawValue)
                    .addDocument(data: letterData)
                try await document.reference
                    .updateData(["is_sent":true])
                guard let partnerreceiveCount = partnerUserData["receive_count"] as? Int else { return }
                batch
                    .updateData(["receive_count": partnerreceiveCount + 1], forDocument: partnerUserDocument)
            }
            batch
                .updateData(["notsend_count": 0], forDocument: getUserDocument())
            try await batch
                .commit()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUserDocument() {
        let document = getUserDocument()
        document.delete()
    }
// 이거를 어디서 계속 감지하고 있을지 뷰가 온어피어될때마다 키는건 비효율
    func listenConnectPartner() {
            getUserDocument().addSnapshotListener { snapshot, error in
            guard let documents = snapshot else {return}
            guard let data = documents.data() else {return}
            print(data)
            guard let partnerId = data["partner_id"] as? String else {return}
            guard let receivecount = data["receive_count"] as? Int else {return}
            /* 기존에 내가 갖고 있던거랑 receivecount가 달라지면 그것은 상대로부터 받은거기에 receive Modal
            if(receivecount != 내가갖고있는것)
             elif(partnerId != 내가가지고 있는것)
             마찬가지로 파트너도 달라지면 최초 파트너 모달띄워주기
             */

        }
    }
}

enum FieldNames: String {
    case Users
    case letter_lists
    case partner_id
    case nickname
}
