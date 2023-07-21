//
//  WriteViewModel.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/14.
//

import SwiftUI

class WriteViewModel : ObservableObject {
    
    // photo picker 관련.
    // launch screen의 Image - 선택 / 촬영된 이미지가 있을경우 표시해주는 UIImage => 없을 수도 있기 때문에 optional type
    @Published var image: UIImage?
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
    func saveImageStoarge() {
        Task{
            guard let image = image else {return}
            let (path, name) = try await StoargeManager.shared.uploadImage(img: image)
            print(path,name)
            try await 
        }
    }
}
