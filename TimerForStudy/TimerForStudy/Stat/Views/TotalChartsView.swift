//
//  TotalChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import SwiftUI
import Charts

/// Picker로 값을 변경하는데 사용할 차트 스타일
///  cumulative: 누적
///  monthly: 월간
///  category: 카테고리별 누적 시간
private enum ChartStyles {
    case cumulative
    case monthly
    case category
}

/// 사용자의 통계를 다양한 차트로 시각화하는 View
struct TotalChartsView: View {
    @ObservedObject var calculator: TotalCalculator
    @State private var chartStyle = ChartStyles.monthly
    
    var body: some View {
        VStack {
            Picker(TextConstants.pickerTitle, selection: $chartStyle.animation(.easeInOut)) {
                Text(TextConstants.monthly).tag(ChartStyles.monthly)
                Text(TextConstants.cumulative).tag(ChartStyles.cumulative)
                Text(TextConstants.category).tag(ChartStyles.category)
            }
            .pickerStyle(.segmented)
            
            switch chartStyle {
            case .category:
                Chart(calculator.accumulatedCategories(calculator.monthlyData)) { category in
                    BarMark(
                        x: .value(TextConstants.timeLabel, category.time/NumberConstants.hour),
                        y: .value(TextConstants.categoryLabel, category.name)
                    )
                    .foregroundStyle(by: .value(TextConstants.categoryLabel, category.name))
                    .annotation(
                        position: .trailing,
                        alignment: .leading,
                        spacing: LayoutConstants.spacing) {
                            Text(DateConverter.timeFormatter.string(from: category.time)!)
                        }
                }
            default:
                Chart(calculator.seriesData) { series in
                    ForEach(data(series.monthlyData)!) { datum in
                        LineMark(
                            x: .value(TextConstants.nameLabel, datum.month, unit: .month),
                            y: .value(TextConstants.timeLabel, datum.total/NumberConstants.hour)
                        )
                        .symbol(by: .value(TextConstants.nameLabel, series.name))
                        .foregroundStyle(by: .value(TextConstants.nameLabel, series.name))
                        .interpolationMethod(.catmullRom)
                        
                        if chartStyle == .monthly {
                            RuleMark(
                                y: .value(TextConstants.average, calculator.average(series.monthlyData)/NumberConstants.hour)
                            )
                            .foregroundStyle(by: .value(TextConstants.nameLabel, series.name))
                            .lineStyle(StrokeStyle(lineWidth: LayoutConstants.ruleMarkWidth))
                            .annotation(position: .top, alignment: .leading) {
                                Text("\(DateConverter.timeFormatter.string(from: calculator.average(series.monthlyData))!)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
        }
        .padding(LayoutConstants.padding)
    }
    
    // chartStyle에 따라 다른 데이터 제공
    private func data(_ monthlyData: [Monthly]) -> [Monthly]? {
        switch chartStyle {
        case .monthly:
            return monthlyData
        case .cumulative:
            return calculator.accumulate(monthlyData)
        default:
            return nil
        }
    }
}

private enum TextConstants {
    static let pickerTitle = "Total"
    static let monthly = "월간"
    static let cumulative = "누적"
    static let category = "카테고리"
    static let nameLabel = "Name"
    static let timeLabel = "Time"
    static let categoryLabel = "Category"
    static let minLabel = "Min"
    static let maxLabel = "Max"
    static let average = "Average"
}

private enum NumberConstants {
    static let hour: Double = 3600
}

private enum LayoutConstants {
    static let padding: CGFloat = 20
    static let spacing: CGFloat = 8
    static let ruleMarkWidth: CGFloat = 2
}
struct TotalChartsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalChartsView(calculator: TotalCalculator(stat: statRawData))
    }
}
