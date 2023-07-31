//
//  Date.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/25.
//

import SwiftUI

extension Date {
    func getNowDate(dayInterval: Double = 0.0) -> String {
        let now = Date(timeIntervalSinceNow: dayInterval * 86400)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = NSTimeZone(name: "Asia/Seoul") as TimeZone?
        return dateFormatter.string(from: now)
    }
    
    static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.M.d"
        return dateFormatter.string(from: date)
    }
    
    static func formatDateForDetailView(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return dateFormatter.string(from: date)
    }
}
