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
    func getLetterLists() async throws{
        letterListArray = try await UserManager.shared.getAllLetterData()
    }
    
}
