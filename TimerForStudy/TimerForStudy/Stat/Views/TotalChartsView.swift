//
//  TotalChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import SwiftUI
import Charts

/// 사용자의 통계를 다양한 차트로 시각화하는 View
struct TotalChartsView: View {
    let monthlyData: [Monthly]
    @State private var chartStyle = ChartStyles.monthly
    
    var data: [Monthly] {
        switch chartStyle {
        case .monthly:
            return monthlyData
        case .cumulative:
            return accumulate(monthlyData)
        }
    }
    
    var body: some View {
        VStack {
            Picker(TextConstants.pickerTitle, selection: $chartStyle.animation(.easeInOut)) {
                Text(TextConstants.monthly).tag(ChartStyles.monthly)
                Text(TextConstants.cumulative).tag(ChartStyles.cumulative)
            }
            .pickerStyle(.segmented)
            
            Chart(data) { datum in
                LineMark(
                    x: .value(TextConstants.xLabel, DateConverter.monthFormatter.string(from: datum.month)),
                    y: .value(TextConstants.yLabel, datum.total/NumberConstants.hour)
                )
                .symbol(.circle)
            }
        }
    }
    
    private func accumulate(_ monthlyData: [Monthly]) -> [Monthly] {
        var cumulativeData = monthlyData
        var sum: TimeInterval = 0
        for index in cumulativeData.indices {
            sum += cumulativeData[index].total
            cumulativeData[index].total = sum
        }
        return cumulativeData
    }
}

private enum ChartStyles {
    case cumulative
    case monthly
}

private enum TextConstants {
    static let pickerTitle = "Total"
    static let monthly = "월간"
    static let cumulative = "누적"
    static let xLabel = "Name"
    static let yLabel = "Time"
}

private enum NumberConstants {
    static let hour: Double = 3600
}
struct TotalChartsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalChartsView(monthlyData: statRowData.monthlyData)
    }
}
