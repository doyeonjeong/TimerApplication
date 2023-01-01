//
//  ChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import SwiftUI
import Charts

/// 통계 데이터를 여러가지 차트로 시각화하는 View
struct ChartsView: View {
    let subjects: [Subject]
    @State private var style = ChartStyles.subjects
    
    var body: some View {
        VStack {
            Picker(TextConstants.pickerTitle, selection: $style.animation(.easeInOut)) {
                Text(TextConstants.category).tag(ChartStyles.subjects)
                Text(TextConstants.monthly).tag(ChartStyles.monthly)
                Text(TextConstants.cumulative).tag(ChartStyles.cumulative)
            }
            .pickerStyle(.segmented)
            
            Chart(subjects) { subject in
                BarMark(x: .value(TextConstants.xLabel, subject.name),
                        y: .value(TextConstants.yLabel, subject.total)
                )
            }
        }
    }
}

private enum ChartStyles {
    case subjects
    case cumulative
    case monthly
}
private enum TextConstants {
    static let pickerTitle = "Style"
    static let category = "카테고리"
    static let monthly = "월간"
    static let cumulative = "누적"
    static let xLabel = "Name"
    static let yLabel = "Time"
}

struct TotalCharts_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView(subjects: StatisticsViewController.createMockObject().subjects)
    }
}
