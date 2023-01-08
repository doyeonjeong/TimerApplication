//
//  Subject.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import Foundation

/// 카테고리
struct Subject: Identifiable {
    let name: String
    var time: TimeInterval
    
    var id: String { name }
}
