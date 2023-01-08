//
//  Daily.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import Foundation

/// 일간 통계 데이터
struct Daily {
    let day: Date
    let total: TimeInterval
    let categories: [Category]
    
    init(_ day: Date, _ categories: [Category]) {
        self.day = day
        self.categories = categories
        
        let total = categories.reduce(into: 0) { total, element in
            total += element.time
        }
        self.total = total
    }
}
