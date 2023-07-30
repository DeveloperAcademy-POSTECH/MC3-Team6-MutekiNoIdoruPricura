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


struct Assets {
    static let inbox = "inbox"
    static let inboxMessage = "inboxMessage"
    static let send = "send"
    static let setting = "setting"
    static let bottle = "bottle"
    static let redBottle = "redBottle"
    static let dummyImage = "Rectangle"
    static let sendBottle = "sendBottle"
    static let conceptCrane = "conceptCrane"
    static let bottleIn = "bottleIn"
    static let crans: [Cran] = Cran.allCases
    
    static let doubleChevronRight = "doubleChevron.right"
    static let doubleChevronLeft = "doubleChevron.left"
}
