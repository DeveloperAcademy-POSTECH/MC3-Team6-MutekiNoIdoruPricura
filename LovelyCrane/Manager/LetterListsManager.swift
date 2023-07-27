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
    
    var isByMeLetters: [LetterModel] {
        return letterListArray.filter { $0.isByme == true}
    }
    var sentLetters: [LetterModel] {
        return letterListArray.filter { $0.isSent == true }
    }
    
    var notSentLetters: [LetterModel] {
        return letterListArray.filter { $0.isSent == false }
    }
    
    var sentLettersGroupedByDate: [Date: [LetterModel]] {
        return Dictionary(grouping: sentLetters, by: { Calendar.current.startOfDay(for: $0.date) })
    }
    
    var notSentLettersGroupedByDate: [Date: [LetterModel]] {
        return Dictionary(grouping: notSentLetters, by: { Calendar.current.startOfDay(for: $0.date) })
    }
}
