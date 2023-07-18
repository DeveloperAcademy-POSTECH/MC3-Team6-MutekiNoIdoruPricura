//
//  String.swift
//  LoveCrane
//
//  Created by 235 on 2023/07/17.
//

import SwiftUI
extension String {
    static func createRandomStr(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String(
            (0..<length)
                .map { _ in letters.randomElement()!}
        )
    }
}
