//
//  TotalChartsView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import SwiftUI

/// 사용자의 통계를 다양한 차트로 시각화하는 View
struct TotalChartsView: View {
    @State private var chartStyle = ChartStyles.cumulative
    var body: some View {
        VStack {
            Picker(TextConstants.pickerTitle, selection: $chartStyle.animation(.easeInOut)) {
                Text(TextConstants.cumulative).tag(ChartStyles.cumulative)
                Text(TextConstants.monthly).tag(ChartStyles.monthly)
            }
            .pickerStyle(.segmented)
        }
    }
}

private enum ChartStyles {
    case cumulative
    case monthly
}

private enum TextConstants {
    static let pickerTitle = "Total"
    static let cumulative = "누적"
    static let monthly = "월간"
    static let xLabel = "Name"
    static let yLabel = "Time"
}

struct TotalChartsView_Previews: PreviewProvider {
    static var previews: some View {
        TotalChartsView()
    }
}
