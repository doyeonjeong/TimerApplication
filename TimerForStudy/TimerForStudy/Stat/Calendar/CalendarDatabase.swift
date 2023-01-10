//
//  CalendarDatabase.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/10.
//

import Foundation
import UIKit

class CalendarDatabase: NSObject {
    let stat: Stat
    
    init(stat: Stat) {
        self.stat = stat
    }
}

extension CalendarDatabase: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    // 달력을 위한 데코레이션 적용
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let date = dateComponents.date else { return nil }
        guard let monthlyData = stat.monthlyData.first(where: { DateConverter.monthFormatter.string(from: $0.month) == DateConverter.monthFormatter.string(from: date) }) else { return nil }
        let days = monthlyData.dailyData.map { DateConverter.dayFormatter.string(from: $0.day) }
        // 공부한 날이라면 표시
        if days.contains(DateConverter.dayFormatter.string(from: date)) {
            return .image(UIImage(systemName: "book"))
        } else {
            return nil
        }
    }
    
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        //
    }
    
    // 날짜 선택
    // StatView update
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        // update rootView
    }
}
