//
//  Stat.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import Foundation

/// Stat Model
struct Stat {
    let name: String
    var friends: [Friend]
    let total: TimeInterval
    var monthlyData: [Monthly]
    let seriesData: [Series]
    
    init(_ name: String, _ monthlyData: [Monthly], _ friends: [Friend]) {
        let total = monthlyData.reduce(into: 0) { total, element in
            total += element.total
        }
        
        var seriesData: [Series] = [
            .init(name: name, monthlyData: monthlyData)
        ]
        for friend in friends {
            if friend.isFavorite, let monthlyData = friend.monthlyData {
                seriesData.append(.init(name: friend.name, monthlyData: monthlyData))
            }
        }
        
        self.name = name
        self.total = total
        self.monthlyData = monthlyData
        self.friends = friends
        self.seriesData = seriesData
    }
    
    func fetchDailyData(_ date: Date) -> Daily? {
        guard let month = monthlyData.first(where: { DateConverter.monthFormatter.string(from: date) == DateConverter.monthFormatter.string(from: $0.month) }) else { return nil }
        return month.fetchDailyData(date)
    }
}
