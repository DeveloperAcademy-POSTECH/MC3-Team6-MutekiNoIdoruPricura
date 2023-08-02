//
//  Assest.swift
//  LoveCrane
//
//  Created by 최진용 on 2023/07/17.
//

import SwiftUI

enum Cran: String, CaseIterable {
    case blue, yellow, green, pink, purple
    
    var colors: (Color, String) {
        switch self {
        case .yellow:
            return (Color.yellow, "yellow")
        case .blue:
            return (Color.blue, "blue")
        case .green:
            return (Color.green, "green")
        case .pink:
            return (Color.pink, "pink")
        case .purple:
            return (Color.purple, "purple")
            
        }
    }
}

enum FoldedCrane: String, CaseIterable {
    case touchCrane1, touchCrane2, touchCrane3, touchCrane4
}


struct Assets {
    static let inbox = "inbox"
    static let inboxMessage = "inboxMessage"
    static let send = "send"
    static let setting = "setting"
    static let bottle = "bottle"
    static let redBottle = "redBottle"
    static let dummyImage = "rectangle"
    static let sendBottle = "sendBottle"
    static let conceptCrane = "conceptCrane"
    static let bottleIn = "bottleIn"
    static let inputCodeImage = "inputCodeImage"
    static let crans: [Cran] = Cran.allCases
    static let bigStrokeCrane = "bigStrokeCrane"
    static let shakingBottle = "shakingBottle2"
    static let heartBottle = "heartBottle3"
    static let touchCranes : [FoldedCrane] = FoldedCrane.allCases
    static let writeViewCranes = "writeViewCranes"
    static let receivedHistoryBottle = "receivedHistoryBottle"
    static let historyCrane = "historyCrane"
    static let receivedHistoryViewImage = "receivedHistoryViewImage"
    static let noReceivedViewImage = "noReceivedViewImage"
    static let noWriteCrane = "noWriteCrane"
    static let nicknameViewImage = "nicknameViewImage"
    static let exclamationMark = "exclamationMark"
    static let couplingpaper = "couplingpaper"
    static let receiveConnect = "receiveConnect"
    static let connectbottle = "connectbottle"
    static let galleryIcon = "galleryIcon"
    static let inputpartner = "inputpartner"
    static let doubleChevronRight = "doubleChevron.right"
    static let doubleChevronLeft = "doubleChevron.left"
}
