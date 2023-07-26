//
//  WriteViewModel.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/14.
//

import SwiftUI
// imagPicker Model
enum Picker {
    enum Source: String {
        // Picker의 타입에 따른 (라이브러리 / 카메라) 시나리오 분류
        case library
        case camera
    }

    static func checkPermissions() -> Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
}

class WriteViewModel : ObservableObject {

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
            let data = LetterModel(id: "", image: path ?? "", date: Date(), text: letterText, isByme: true, isSent: false, isRead: false)
            UserManager.shared.postletterData(letter: data)
            return true
        }
        catch{
            return false
        }
    }
}
