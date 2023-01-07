//
//  PercentageChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/07.
//

import SwiftUI
import Charts

/// 카테고리(과목)별 공부 시간의 %를 시각화하는 차트 뷰
struct PercentageChartsView: View {
    let dailyData: Daily
    
    var body: some View {
        GeometryReader { proxy in
            Chart(dailyData.subjects) { subject in
                BarMark(
                    x: .value(
                        TextConstants.percentageLabel,
                        subject.time/dailyData.total * NumberConstants.hundred
                    ),
                    yStart: proxy.size.height * LayoutConstants.half - LayoutConstants.barWidth,
                    yEnd: proxy.size.height * LayoutConstants.half,
                    stacking: .normalized // For full height
                )
                .foregroundStyle(by: .value(TextConstants.categoryLabel, subject.name))
                .annotation(position: .overlay, alignment: .center) {
                    Text("\(Int(subject.time/dailyData.total * NumberConstants.hundred))" + TextConstants.percentageString)
                        .font(.system(.caption, weight: .semibold))
                }
            }
        }
        .padding(LayoutConstants.padding)
    }
}

private enum TextConstants {
    static let percentageLabel = "Percentage"
    static let categoryLabel = "Subject Category"
    static let percentageString = "\u{0025}"
}

private enum NumberConstants {
    static let hundred: Double = 100
}

private enum LayoutConstants {
    static let padding: CGFloat = 8
    static let half: CGFloat = 0.5
    static let barWidth: CGFloat = 50
}

struct PercentageChartsView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageChartsView(dailyData: statRawData.monthlyData[0].dailyData[0])
    }
}
