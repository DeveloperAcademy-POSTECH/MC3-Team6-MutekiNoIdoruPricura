//
//  WriteModel.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import SwiftUI
import UIKit

struct WriteModel {
    
}

// imagPicker Model

enum Picker {
    enum Source: String {
        // Picker의 타입에 따른 (라이브러리 / 카메라) 시나리오 분류
        case library
        case camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            return true
        } else {
            return false
        }
    }
}
