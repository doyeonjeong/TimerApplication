//
//  DescriptionView.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/02.
//

import SwiftUI

/// 총 공부 시간을 나타내는 View
struct DescriptionView: View {
    let total: TimeInterval
    private let formatter = DateComponentsFormatter()
    
    var body: some View {
        VStack {
            Text(TextConstants.title)
                .font(.system(.headline, weight: .bold))
                .padding(LayoutConstants.offset)
            Text(formatter.string(from: total)!)
                .font(.system(.subheadline, weight: .semibold))
        }
    }
}

private enum TextConstants {
    static let title = "총 공부 시간"
}

private enum LayoutConstants {
    static let offset: CGFloat = 5
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(total: StatisticsViewController.createMockObject().total)
    }
}
