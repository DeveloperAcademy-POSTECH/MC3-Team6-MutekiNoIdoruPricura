//
//  Color+Ext.swift
//  LoveCrane
//
//  Created by 최진용 on 2023/07/17.
//

import SwiftUI


extension Color {
    static let backGround = Color(UIColor(hexCode: "#252526"))
    
    static let gray1 = Color(UIColor(hexCode: "2F2E2E"))
    static let gray2 = Color(UIColor(hexCode: "303030"))
    static let gray3 = Color(UIColor(hexCode: "3A3A3A"))
    static let gray4 = Color(UIColor(hexCode: "454545"))
    static let gray5 = Color(UIColor(hexCode: "535353"))
    static let gray6 = Color(UIColor(hexCode: "ACABAB"))
    
    
    static let primary = Color.white
    static let secondary = Color.white.opacity(0.6)
    static let tertiary = Color(UIColor(hexCode: "C9C9C9")).opacity(0.6)
    static let quarternary = tertiary.opacity(0.3)
    
    static let fill = Color(UIColor(hexCode: "#EAEAEA"))
    static let overLay = Color.black.opacity(0.6)
    
    static let deepPink = Color(UIColor(hexCode: "DA6A98"))
    static let lightPink = Color(UIColor(hexCode: "FF76B4"))

    static let defaultRed = Color(UIColor(hexCode: "#EA384E"))
    static let defaultYellow = Color(UIColor(hexCode: "#FFD60A"))
}
