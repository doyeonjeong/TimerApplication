//
//  PercentageChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/07.
//

import SwiftUI
import Charts

struct PercentageChartsView: View {
    let dailyData: Daily
    
    var body: some View {
        Chart(dailyData.subjects) { subject in
            BarMark(
                x: .value(TextConstants.percentageLabel, subject.time/dailyData.total * 100),
                y: .value(TextConstants.singleLabel, TextConstants.singleLabelText),
                width: .fixed(50),
                stacking: .standard
            )
            .foregroundStyle(by: .value(TextConstants.percentageLabel, subject.name))
            .annotation(position: .overlay, alignment: .center) {
                Text("\(Int(subject.time/dailyData.total * 100))%")
            }
        }
        .padding(LayoutConstants.padding)
    }
}

private enum TextConstants {
    static let percentageLabel = "Percentage"
    static let singleLabel = "Single"
    static let singleLabelText = "카테고리별 비율, 소수점 이하는 버림"
}

private enum LayoutConstants {
    static let padding: CGFloat = 8
}

struct PercentageChartsView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageChartsView(dailyData: statRawData.monthlyData[0].dailyData[0])
    }
}
