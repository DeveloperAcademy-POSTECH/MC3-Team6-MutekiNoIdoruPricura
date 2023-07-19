//
//  DateManager.swift
//  LovelyCrane
//
//  Created by 황지우2 on 2023/07/19.
//

import Foundation

func getNowDate(dayInterval: Double = 0) -> String{
    let now = Date(timeIntervalSinceNow: dayInterval * 86400)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    dateFormatter.timeZone = NSTimeZone(name: "Asia/Seoul") as TimeZone?
    return dateFormatter.string(from: now)
}

