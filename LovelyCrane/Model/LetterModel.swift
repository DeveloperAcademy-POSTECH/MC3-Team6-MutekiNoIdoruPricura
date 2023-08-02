//
//  WriteModel.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import SwiftUI
import UIKit

struct LetterModel : Codable, Hashable {
    let id: String
    let image: String?
    let date: Date
    let text: String
    let isByme: Bool
    let isSent: Bool
    let isRead: Bool
    let sentDate: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case image
        case date
        case text
        case isByme = "is_byme"
        case isSent = "is_sent"
        case isRead = "is_read"
        case sentDate = "sent_date"
    }
}
