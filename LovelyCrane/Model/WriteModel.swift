//
//  WriteModel.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import SwiftUI
import UIKit

struct WriteModel {
    let id = UUID()
    let image: String 
    let date: Date
    let text: String
    let is_byme: Bool // true=작성히스토리 false= 수신히스토리
    let is_sent: Bool // true=보내짐. false아직안보내짐.
    let is_read: Bool
}

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
