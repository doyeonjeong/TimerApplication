//
//  DailyStatView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import SwiftUI

/// StatViewController에 Embed되는 통계 탭 View
struct DailyStatView: View {
    let dailyData: Daily
    
    var body: some View {
        VStack {
            DescriptionView(total: dailyData.total)
            DailyChartsView(subjects: dailyData.subjects)
        }
        .padding(LayoutConstants.padding)
    }
}

private enum LayoutConstants {
    static let padding: CGFloat = 8
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        DailyStatView(dailyData: statRowData.monthlyData[0].dailyData[0])
    }
}
