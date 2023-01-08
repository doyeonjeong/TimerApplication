//
//  TimeChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/07.
//

import SwiftUI
import Charts

/// 카테고리(과목)별 공부 시간을 시각화하는 차트 뷰
struct TimeChartsView: View {
    let categories: [Category]
    
    var body: some View {
        Chart(categories) { category in
            BarMark(
                x: .value(
                    TextConstants.categoryLabel,
                    category.name
                ),
                y: .value(
                    TextConstants.timeLabel,
                    category.time/NumberConstants.hour
                )
            )
            .foregroundStyle(by: .value(TextConstants.categoryLabel, category.name))
        }
        .padding(LayoutConstants.padding)
    }
}

private enum TextConstants {
    static let categoryLabel = "Category"
    static let timeLabel = "Time"
}

private enum NumberConstants {
    static let hour: Double = 3600
}

private enum LayoutConstants {
    static let padding: CGFloat = 8
}

struct TimeChartsView_Previews: PreviewProvider {
    static var previews: some View {
        TimeChartsView(categories: statRawData.monthlyData[0].dailyData[0].categories)
    }
}
