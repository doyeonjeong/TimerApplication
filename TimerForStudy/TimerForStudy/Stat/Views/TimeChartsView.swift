//
//  TimeChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/07.
//

import SwiftUI
import Charts

struct TimeChartsView: View {
    let subjects: [Subject]
    
    var body: some View {
        Chart(subjects) { subject in
            BarMark(x: .value(TextConstants.nameLabel, subject.name),
                    y: .value(TextConstants.timeLabel, subject.time/NumberConstants.hour)
            )
            .foregroundStyle(by: .value(TextConstants.nameLabel, subject.name))
        }
        .padding(LayoutConstants.padding)
    }
}

private enum TextConstants {
    static let nameLabel = "Name"
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
        TimeChartsView(subjects: statRawData.monthlyData[0].dailyData[0].subjects)
    }
}
