//
//  Stat.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import Foundation

/// Stat Model
final class Stat: ObservableObject {
    @Published var monthlyData: Monthly
    let total: TimeInterval
    
    init(_ name: String, _ monthlyData: Monthly) {
        self.total = monthlyData.total
        self.monthlyData = monthlyData
    }
    
    func fetchDailyData(_ date: Date) -> Daily? {
        monthlyData.fetchDailyData(date)
    }
}
