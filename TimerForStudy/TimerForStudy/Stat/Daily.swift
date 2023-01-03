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
    let subjects: [Subject]
    
    init(_ day: Date, _ subjects: [Subject]) {
        self.day = day
        self.subjects = subjects
        
        var total: TimeInterval = 0
        for subject in subjects {
            total += subject.time
        }
        self.total = total
    }
}
