//
//  LetterLists.swift
//  LovelyCrane
//
//  Created by 235 on 2023/07/26.
//

import Foundation
class LetterLists {
    static let shared = LetterLists()
    private var letterListArray: [LetterModel] = []
    private init() {}
    func getAllLetterLists() async throws  -> [LetterModel]{
        letterListArray = try await UserManager.shared.getAllLetterData()
        return letterListArray
    }
    func getSendLetterLists() async throws -> [LetterModel]{
        letterListArray = try await UserManager.shared.getSendLetterData()
        return letterListArray
    }
    
}
