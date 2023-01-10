//
//  Calculator.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation
import Combine

protocol Calculable: AnyObject {
    // output
    var seriesData: [Series] { get } // 사용자 + 친구의 정보
    var average: TimeInterval { get } // 평균값
    var accumulatedCategories: [Category] { get } // 카테고리별 누적값
    init(_ stat: Stat)
    func accumulate(_ monthlyData: [Monthly]) -> [Monthly] // 누적값
    func data(_ chartStyle: ChartStyles, _ series: Series) -> [Monthly]? // chartStyle에 따라 다른 데이터 제공
}

/// TotalCharts View Model
final class Calculator: ObservableObject, Calculable {
    @Published var stat: Stat
    
    var friends: [Friend] {
        stat.friends
    }
    
    var name: String {
        stat.name
    }
    
    var seriesData: [Series] {
        var seriesData: [Series] = [
            .init(name: stat.name, monthlyData: stat.monthlyData)
        ]
        
        for friend in friends {
            if friend.isPeeping, let monthlyData = friend.monthlyData {
                seriesData.append(.init(name: friend.name, monthlyData: monthlyData))
            }
        }
        return seriesData
    }
    
    var average: TimeInterval {
        let total = stat.monthlyData.reduce(into: NumberConstants.zero) { total, element in
            total += element.total
        }
        return total/Double(stat.monthlyData.count)
    }
    
    var accumulatedCategories: [Category] {
        var accumulatedCategories = [Category]()
        
        for monthly in stat.monthlyData {
            for daily in monthly.dailyData {
                for category in daily.categories {
                    if let indexThatAlreadyExists = accumulatedCategories.firstIndex(where: { $0.name == category.name }) {
                        accumulatedCategories[indexThatAlreadyExists].time += category.time
                    } else {
                        accumulatedCategories.append(category)
                    }
                }
            }
        }
        return accumulatedCategories.sorted { $0.time > $1.time }
    }
    
    init(_ stat: Stat) {
        self.stat = stat
    }
    
    func data(_ chartStyle: ChartStyles, _ series: Series) -> [Monthly]? {
        switch chartStyle {
        case .monthly:
            return series.monthlyData
        case .cumulative:
            return accumulate(series.monthlyData)
        case .category:
            return nil
        }
    }
    
    func accumulate(_ monthlyData: [Monthly]) -> [Monthly] {
        var accumulatedMonthlyData = monthlyData
        var sum: TimeInterval = NumberConstants.zero
        
        for index in accumulatedMonthlyData.indices {
            sum += accumulatedMonthlyData[index].total
            accumulatedMonthlyData[index].total = sum
        }
        return accumulatedMonthlyData
    }
}

private enum NumberConstants {
    static let zero: Double = 0
}
