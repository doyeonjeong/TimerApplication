//
//  TotalStatView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import SwiftUI


/// 통계를 문자열 및 다양한 차트로 보여주는 View
struct TotalStatView: View {
    
    var body: some View {
        VStack {
            TotalChartsView()
        }
    }
}

private enum LayoutConstants {
    static let offset: CGFloat = 20
}

struct TotalStatView_Previews: PreviewProvider {
    static var previews: some View {
        TotalStatView()
    }
}
