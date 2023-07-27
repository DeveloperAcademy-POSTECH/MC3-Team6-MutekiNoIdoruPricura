//
//  InputCodeViewModel.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/25.
//

import SwiftUI
@MainActor
final class InputCodeViewModel: ObservableObject {
    @Published var inputcode: String = ""
    func connectPartner() async throws -> Bool{
        let failconnect = try await UserManager.shared.connectUsertoUser(to: inputcode)
//        if failconnect {
//            return false
//        }
        inputcode = ""
        return true
    }
}
