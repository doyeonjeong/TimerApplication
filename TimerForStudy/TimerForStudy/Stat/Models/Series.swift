//
//  Series.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation

// 친구와 비교할 수 있는 차트를 구성하기 위한 struct
struct Series: Identifiable {
    let name: String
    let monthlyData: [Monthly]
    
    var id: String { name }
}
