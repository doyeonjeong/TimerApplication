//
//  Statistics.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import Foundation

/// Statistics Model
final class Statistics: ObservableObject {
    let name: String
    let total: TimeInterval
    let subjects: [Subject]
    
    
    init(name: String, total: TimeInterval, subjects: [Subject]) {
        self.name = name
        self.total = total
        self.subjects = subjects
    }
}
