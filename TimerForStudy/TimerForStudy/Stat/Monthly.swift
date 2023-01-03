//
//  Monthly.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import Foundation

/// 월간 통계 데이터
struct Monthly {
    let month: Date
    let total: TimeInterval
    let dailyData: [Daily]
    
    init(_ month: Date, _ dailyData: [Daily]) {
        self.month = month

        var total: TimeInterval = 0
        for daily in dailyData {
            total += daily.total
        }
        self.total = total
        self.dailyData = dailyData
    }
    
    func fetchDailyData(_ date: Date) -> Daily? {
        dailyData.first { DateConverter.dayFormatter.string(from: $0.day) == DateConverter.dayFormatter.string(from: date)}
    }
}
