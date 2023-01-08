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
/// 데이터 처리 로직은 추후 모델 레이어로 뺄 예정입니다.
struct TotalChartsView: View {
    let stat: Stat
    @State private var chartStyle = ChartStyles.monthly
    let seriesData: [Series]
    
    var body: some View {
        VStack {
            Picker(TextConstants.pickerTitle, selection: $chartStyle.animation(.easeInOut)) {
                Text(TextConstants.monthly).tag(ChartStyles.monthly)
                Text(TextConstants.cumulative).tag(ChartStyles.cumulative)
                Text(TextConstants.category).tag(ChartStyles.category)
            }
            .pickerStyle(.segmented)
            
            if chartStyle == .category {
                Chart(accumulateOfCategories(stat.monthlyData)) { category in
                    BarMark(
                        x: .value("Time", category.time/NumberConstants.hour),
                        y: .value("Category", category.name)
                    )
                    .foregroundStyle(by: .value("Category", category.name))
                }
            } else {
                Chart(seriesData) { series in
                    ForEach(data(series.monthlyData)!) { datum in
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
        }
        .padding(LayoutConstants.padding)
    }
    
    // chartStyle에 따라 다른 데이터 제공
    func data(_ monthlyData: [Monthly]) -> [Monthly]? {
        switch chartStyle {
        case .monthly:
            return monthlyData
        case .cumulative:
            return accumulate(monthlyData)
        default:
            return nil
        }
    }
    
    // 평균값 계산
    private func average(_ monthlyData: [Monthly]) -> TimeInterval {
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
    
    // 카테고리별 누적값 계산
    // stored property 생성해서 사용 가능, 모델 레이어에서 초기화
    private func accumulateOfCategories(_ monthlyData: [Monthly]) -> [Subject] {
        var subjects = [Subject]()
        
        for monthly in monthlyData {
            for daily in monthly.dailyData {
                for subject in daily.subjects {
                    if let indexThatAlreadyExists = subjects.firstIndex { $0.name == subject.name } {
                        subjects[indexThatAlreadyExists].time += subject.time
                    } else {
                        subjects.append(subject)
                    }
                }
            }
        }
        return subjects
    }
}

private enum TextConstants {
    static let pickerTitle = "Total"
    static let monthly = "월간"
    static let cumulative = "누적"
    static let category = "카테고리"
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
        TotalChartsView(stat: statRawData, seriesData: seriesData)
    }
}
