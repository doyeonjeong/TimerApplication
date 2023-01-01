//
//  Subject.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import Foundation

/// 과목(카테고리) Entity
struct Subject: Identifiable {
    let name: String
    let total: TimeInterval
    
    var id: String { name }
}
