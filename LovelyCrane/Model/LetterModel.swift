//
//  WriteModel.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import SwiftUI
import UIKit

struct LetterModel : Codable{
    let id: String?
    let image: String 
    let date: Date
    let text: String
    let isByme: Bool // true=작성히스토리 false= 수신히스토리
    let isSent: Bool // true=보내짐. false아직안보내짐.
    let isRead: Bool
    enum CodingKeys: String, CodingKey{
        case id
        case image
        case date
        case text
        case isByme = "is_byme"
        case isSent = "is_sent"
        case isRead = "is_read"
        
    }
}


