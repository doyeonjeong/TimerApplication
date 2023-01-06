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
    let dailyData: Daily
    
    var body: some View {
        VStack {
            // Time Charts
            Chart(dailyData.subjects) { subject in
                BarMark(x: .value(TextConstants.nameLabel, subject.name),
                        y: .value(TextConstants.timeLabel, subject.time/NumberConstants.hour)
                )
                .foregroundStyle(by: .value(TextConstants.nameLabel, subject.name))
            }
            
            // Percentage Charts
            Chart(dailyData.subjects) { subject in
                BarMark(
                    x: .value(TextConstants.percentageLabel, subject.time/dailyData.total * 100),
                    y: .value(TextConstants.singleLabel, TextConstants.singleLabelText),
                    width: .fixed(50),
                    stacking: .standard
                )
                .foregroundStyle(by: .value(TextConstants.nameLabel, subject.name))
                .annotation(position: .overlay, alignment: .center) {
                    Text("\(Int(subject.time/dailyData.total * 100))%")
                }
            }
        }
        .padding(LayoutConstants.padding)
    }
}

private enum TextConstants {
    static let nameLabel = "Name"
    static let timeLabel = "Time"
    static let percentageLabel = "Percentage"
    static let singleLabel = "Single"
    static let singleLabelText = "카테고리별 비율, 소수점 이하는 버림"
}

private enum NumberConstants {
    static let hour: Double = 3600
}

private enum LayoutConstants {
    static let padding: CGFloat = 20
}

struct TotalCharts_Previews: PreviewProvider {
    static var previews: some View {
        DailyChartsView(dailyData: statRowData.monthlyData[0].dailyData[0])
    }
}
