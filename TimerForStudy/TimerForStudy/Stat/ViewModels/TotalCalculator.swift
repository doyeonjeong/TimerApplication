//
//  TotalCalculator.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation

/// TotalCharts View Model
final class TotalCalculator: ObservableObject {
    @Published private var stat: Stat
    
    var monthlyData: [Monthly] {
        stat.monthlyData
    }
    
    var seriesData: [Series] {
        stat.seriesData
    }
    
    init(stat: Stat) {
        self.stat = stat
    }
    
    // 평균값 계산
    func average(_ monthlyData: [Monthly]) -> TimeInterval {
        let total = monthlyData.reduce(into: NumberConstants.zero) { total, element in
            total += element.total
        }
        return total/Double(monthlyData.count)
    }
    
    // 누적값 계산
    func accumulate(_ monthlyData: [Monthly]) -> [Monthly] {
        var accumulatedMonthlyData = monthlyData
        var sum: TimeInterval = NumberConstants.zero
        
        for index in accumulatedMonthlyData.indices {
            sum += accumulatedMonthlyData[index].total
            accumulatedMonthlyData[index].total = sum
        }
        return accumulatedMonthlyData
    }
    
    // 카테고리별 누적 공부 시간 계산
    // stored property 생성해서 사용 가능, 모델 레이어에서 초기화
    func accumulatedCategories(_ monthlyData: [Monthly]) -> [Category] {
        var accumulatedCategories = [Category]()
        
        for monthly in monthlyData {
            for daily in monthly.dailyData {
                for category in daily.categories {
                    if let indexThatAlreadyExists = accumulatedCategories.firstIndex { $0.name == category.name } {
                        accumulatedCategories[indexThatAlreadyExists].time += category.time
                    } else {
                        accumulatedCategories.append(category)
                    }
                }
            }
        }
        return accumulatedCategories.sorted { $0.time > $1.time }
    }
}

private enum NumberConstants {
    static let zero: Double = 0
}
