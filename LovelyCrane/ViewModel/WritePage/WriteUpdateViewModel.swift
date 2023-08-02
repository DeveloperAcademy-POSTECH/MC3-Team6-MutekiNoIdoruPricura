//
//  WriteUpdateViewModel.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/08/02.
//

import SwiftUI


class WriteUpdateViewModel : ObservableObject {

    @Published var image: UIImage?
    @Published var letterText = ""
    @Published var showPicker = false
    @Published var source : Picker.Source = .library

    func showPhotoPicker() {
        if source == .camera { // source 가 카메라일 경우.
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }

    func saveImageStoarge() async -> Bool {
        do{
            var path: String?
            if let image = image {
                path = try await StorageManager.shared.uploadImage(img: image)
            }
            let data = LetterModel(id: "", image: path ?? "", date: Date(), text: letterText, isByme: true, isSent: false, isRead: false, sentDate: nil)
            try await UserManager.shared.postletterData(letter: data)
            return true
        }
        catch{
            return false
        }
    }
}
