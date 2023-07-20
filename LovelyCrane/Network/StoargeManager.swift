//
//  StoargeManager.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/21.
//

import SwiftUI
import FirebaseStorage
import Firebase
class FirebaseStoargeManager {
    static let shared = FirebaseStoargeManager()
    let stoarge = Storage.storage()
    func uploadImage(img: UIImage){
        var data = Data()
        data = img.jpegData(compressionQuality: 0.4)!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        let filepath = (Auth.auth().currentUser?.uid) ?? "id1"
        stoarge.reference().child(filepath).putData(data, metadata: metaData){(metaData,err) in
            if let err = err{
                return
            }else{
                print("성공")
            }
        }
    }
}
