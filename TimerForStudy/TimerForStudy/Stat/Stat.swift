//
//  Stat.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import Foundation

/// Stat Model
final class Stat: ObservableObject {
    @Published var monthlyData: [Monthly]
    let total: TimeInterval
    let name: String
    
    init(_ name: String, _ monthlyData: [Monthly]) {
        let total = monthlyData.reduce(into: 0) { total, element in
            total += element.total
        }
        self.name = name
        self.total = total
        self.monthlyData = monthlyData
    }
    
    func fetchDailyData(_ date: Date) -> Daily? {
        guard let month = monthlyData.first(where: { DateConverter.monthFormatter.string(from: date) == DateConverter.monthFormatter.string(from: $0.month) }) else { return nil }
        return month.fetchDailyData(date)
    }
}
