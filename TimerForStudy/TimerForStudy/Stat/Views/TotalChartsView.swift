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
enum ChartStyles {
    case monthly
    case cumulative
    case category
}

/// 사용자의 통계를 다양한 차트로 시각화하는 View
struct TotalChartsView: View {
    @ObservedObject var calculator: Calculator
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
                Chart(calculator.accumulatedCategories) { category in
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
                    ForEach(calculator.data(chartStyle, series)!) { datum in
                        LineMark(
                            x: .value(TextConstants.monthLabel, datum.month, unit: .month),
                            y: .value(TextConstants.timeLabel, datum.total/NumberConstants.hour)
                        )
                        .symbol(by: .value(TextConstants.nameLabel, series.name))
                        .foregroundStyle(by: .value(TextConstants.nameLabel, series.name))
                        .interpolationMethod(.catmullRom)
                    }
                    if chartStyle == .monthly {
                        RuleMark(
                            y: .value(TextConstants.average, calculator.average/NumberConstants.hour)
                        )
                        .foregroundStyle(by: .value(TextConstants.nameLabel, calculator.name))
                        .lineStyle(StrokeStyle(lineWidth: LayoutConstants.ruleMarkWidth))
                        .annotation(position: .top, alignment: .leading) {
                            Text("\(DateConverter.timeFormatter.string(from: calculator.average)!)")
                                .font(.subheadline)
                        }
                    }
                }
                .animation(.spring(), value: calculator.seriesData)
                
                FriendList(friends: $calculator.stat.friends)
                    .frame(height: 200)
            }
        }
        .padding(LayoutConstants.padding)
    }
}

private enum TextConstants {
    static let pickerTitle = "Total"
    static let monthly = "월간"
    static let cumulative = "누적"
    static let category = "카테고리"
    static let nameLabel = "Name"
    static let timeLabel = "Time"
    static let monthLabel = "Month"
    static let categoryLabel = "Category"
    static let minLabel = "Min"
    static let maxLabel = "Max"
    static let average = "Average"
}

private enum NumberConstants {
    static let hour: Double = 3600
}

private enum LayoutConstants {
    static let padding: CGFloat = 10
    static let spacing: CGFloat = 8
    static let ruleMarkWidth: CGFloat = 2
}
struct TotalChartsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalChartsView(calculator: Calculator(statRawData))
    }
}
