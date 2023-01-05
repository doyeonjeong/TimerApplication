//
//  TotalChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import SwiftUI
import Charts

// 비교하는 차트 구성을 위한 struct
struct Series: Identifiable {
    let name: String
    let monthlyData: [Monthly]
    
    var id: String { name }
}

/// 사용자의 통계를 다양한 차트로 시각화하는 View
/// 로직은 추후 모델 레이어로 뺄 예정입니다.
struct TotalChartsView: View {
    let stat: Stat
    @State private var chartStyle = ChartStyles.monthly
    let seriesData: [Series]
    
    var body: some View {
        VStack {
            Picker(TextConstants.pickerTitle, selection: $chartStyle.animation(.easeInOut)) {
                Text(TextConstants.monthly).tag(ChartStyles.monthly)
                Text(TextConstants.cumulative).tag(ChartStyles.cumulative)
            }
            .pickerStyle(.segmented)
            
            Chart(seriesData) { series in
                ForEach(data(series.monthlyData)) { datum in
                    LineMark(
                        x: .value(TextConstants.xLabel, datum.month, unit: .month),
                        y: .value(TextConstants.yLabel, datum.total/NumberConstants.hour)
                    )
                    .symbol(by: .value("Name", series.name))
                    .foregroundStyle(by: .value("Name", series.name))
                    .interpolationMethod(.catmullRom)
                    
                    if chartStyle == .monthly {
                        RuleMark(
                            y: .value(TextConstants.average, average(series.monthlyData)/NumberConstants.hour)
                        )
                        .foregroundStyle(by: .value("Name", series.name))
                        .lineStyle(StrokeStyle(lineWidth: 2))
                        .annotation(position: .top, alignment: .leading) {
                            Text("\(DateConverter.timeFormatter.string(from: average(series.monthlyData))!)")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding(LayoutConstants.padding)
    }
    
    // chartStyle에 따라 다른 데이터 제공
    func data(_ monthlyData: [Monthly]) -> [Monthly] {
        switch chartStyle {
        case .monthly:
            return monthlyData
        case .cumulative:
            return accumulate(monthlyData)
        }
    }
    
    // 평균값 계산
    func average(_ monthlyData: [Monthly]) -> TimeInterval {
        let total = monthlyData.reduce(into: 0) { total, element in
            total += element.total
        }
        return total/Double(monthlyData.count)
    }
    
    // 누적값 계산
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
    static let minLabel = "Min"
    static let maxLabel = "Max"
    static let average = "Average"
}

private enum NumberConstants {
    static let hour: Double = 3600
}

private enum LayoutConstants {
    static let padding: CGFloat = 20
}
struct TotalChartsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalChartsView(stat: statRowData, seriesData: seriesData)
    }
}
