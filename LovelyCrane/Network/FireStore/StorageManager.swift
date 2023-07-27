//
//  StoargeManager.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/21.
//

import SwiftUI
import FirebaseStorage
import Firebase
final class StorageManager {
    static let shared = StorageManager()
    let stoarge = Storage.storage().reference()
    private var imageReference: StorageReference {
        stoarge.child("users").child(Auth.auth().currentUser?.uid ?? "id1")
    }
    func uploadImage(img: UIImage) async throws -> (String){
        var data = Data()
        guard let data = img.jpegData(compressionQuality: 0.3) else { return "" }
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        let path = "\(Date()).png"
        let returnedMetaData = try await imageReference.child(path).putDataAsync(data,metadata: metaData)
        guard let returnedPath = returnedMetaData.path else {
            throw URLError(.badServerResponse)
        }
        return (returnedPath)
    }
    func getImage(url: String) async throws -> Data{
        try await imageReference.child(url).data(maxSize: 1*1024*1024)
    }
    func deleteImage(path: String) async throws {
        try await imageReference.child(path).delete()
    }
}
