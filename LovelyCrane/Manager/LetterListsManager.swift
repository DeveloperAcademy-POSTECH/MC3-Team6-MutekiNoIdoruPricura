//
//  LetterListsManager.swift
//  LovelyCrane
//
//  Created by Toughie on 2023/07/27.
//

import Foundation

final class LetterListsManager {
    static let shared = LetterListsManager()
    private init() {}
    
    var letterListArray: [LetterModel] = []
    
    // MARK: my Letters
    var isByMeLetters: [LetterModel] {
        letterListArray.filter { $0.isByme == true}
    }
    
    var sentLetters: [LetterModel] {
        letterListArray.filter { $0.isSent == true }
    }
    
    var notSentLetters: [LetterModel] {
        letterListArray.filter { $0.isSent == false }
    }
    
    var sentLettersGroupedByDate: [Date: [LetterModel]] {
        let groupByDate = Dictionary(grouping: sentLetters, by: { Calendar.current.startOfDay(for: $0.date) })
        return sortGroupedLettersByDateDescending(groupByDate)
    }
    
    var notSentLettersGroupedByDate: [Date: [LetterModel]] {
        let groupByDate = Dictionary(grouping: notSentLetters, by: { Calendar.current.startOfDay(for: $0.date) })
        return sortGroupedLettersByDateDescending(groupByDate)
    }
    
    // MARK: received Letters
    var receivedLetters: [LetterModel] {
        letterListArray.filter { $0.isByme == false}
    }
    
    var receivedLettersGroupedByDate: [Date: [LetterModel]] {
        let groupByDate = Dictionary(grouping: receivedLetters, by: { Calendar.current.startOfDay(for: $0.date) })
        return sortGroupedLettersByDateDescending(groupByDate)
    }
    
    private func sortGroupedLettersByDateDescending(_ groupedLetters: [Date: [LetterModel]]) -> [Date: [LetterModel]] {
        var sortedGroupedLetters: [Date: [LetterModel]] = [:]
        for (date, letters) in groupedLetters {
            let sortedLetters = letters.sorted(by: { $0.date > $1.date })
            sortedGroupedLetters[date] = sortedLetters
        }
        return sortedGroupedLetters
    }
}
