//
//  Monthly.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import Foundation

/// 월간 통계 데이터
struct Monthly: Identifiable {
    let month: Date
    var total: TimeInterval
    let dailyData: [Daily]
    
    var id: Date { month }
    
    init(_ month: Date, _ dailyData: [Daily]) {
        let total = dailyData.reduce(into: 0) { total, element in
            total += element.total
        }
        self.month = month
        self.total = total
        self.dailyData = dailyData
    }
    
    func fetchDailyData(_ date: Date) -> Daily? {
        dailyData.first { DateConverter.dayFormatter.string(from: $0.day) == DateConverter.dayFormatter.string(from: date)}
    }
}
