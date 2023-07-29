//
//  Assest.swift
//  LoveCrane
//
//  Created by 최진용 on 2023/07/17.
//

import SwiftUI

enum Cran: String, CaseIterable {
    case blue, yellow, green, white, pink, purple
}


struct Assets {
    static let inbox = "inbox"
    static let inboxMessage = "inboxMessage"
    static let send = "send"
    static let setting = "setting"
    static let bottle = "bottle"
    static let dummyImage = "Rectangle"
    static let sendBottle = "sendBottle"
    static let conceptCrane = "conceptCrane"
    static let bottleIn = "bottleIn"
    static let crans: [Cran] = Cran.allCases
    static let writeViewCranes = "WriteViewCranes"
    static let receivedHistoryBottle = "receivedHistoryBottle"
    static let historyCrane = "historyCrane"
    static let receivedHistoryViewImage = "receivedHistoryViewImage"
    static let noReceivedViewImage = "noReceivedViewImage"
    static let noWriteCrane = "noWriteCrane"
    static let nicknameViewImage = "nicknameViewImage"
    static let exclamationMark = "exclamationMark"
}
