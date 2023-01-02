//
//  StatisticsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import SwiftUI

/// StatisticsViewController에 Embed되는 통계 탭 View
struct StatisticsView: View {
    @ObservedObject var stat: Statistics
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            TotalStatView(stat: stat)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(stat: StatisticsViewController.createMockObject())
    }
}
