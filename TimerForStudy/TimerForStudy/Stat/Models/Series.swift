//
//  Series.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation

// 친구의 데이터를 시각화하여, 다양한 차트를 구성하기 위한 struct
struct Series: Identifiable, Equatable {
    let name: String
    let monthlyData: [Monthly]
    var id = UUID()
    
    static func == (lhs: Series, rhs: Series) -> Bool {
        lhs.id == rhs.id
    }
}
