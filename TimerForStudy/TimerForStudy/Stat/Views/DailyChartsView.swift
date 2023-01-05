//
//  DailyChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import SwiftUI
import Charts

/// 일간 Charts View
/// CalendarView에서 날짜 탭시 그날의 통계를 보여줌.
struct DailyChartsView: View {
    let subjects: [Subject]
    
    var body: some View {
        Chart(subjects) { subject in
            BarMark(x: .value(TextConstants.xLabel, subject.name),
                    y: .value(TextConstants.yLabel, subject.time/NumberConstants.hour)
            )
        }
        .padding(LayoutConstants.padding)
        .foregroundColor(.red)
    }
}

private enum TextConstants {
    static let xLabel = "Name"
    static let yLabel = "Time"
}

private enum NumberConstants {
    static let hour: Double = 3600
}

private enum LayoutConstants {
    static let padding: CGFloat = 20
}

struct TotalCharts_Previews: PreviewProvider {
    static var previews: some View {
        DailyChartsView(subjects: statRowData.monthlyData[0].dailyData[0].subjects)
    }
}
