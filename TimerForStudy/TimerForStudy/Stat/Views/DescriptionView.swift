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
    
    var body: some View {
        HStack {
            Text(TextConstants.title)
                .font(.system(.headline, weight: .bold))
            Text(DateConverter.timeFormatter.string(from: total)!)
                .font(.system(.subheadline, weight: .semibold))
        }
    }
}

private enum TextConstants {
    static let title = "Total"
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(total: statRawData.total)
    }
}
