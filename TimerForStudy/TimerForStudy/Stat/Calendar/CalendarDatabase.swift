//
//  CalendarDatabase.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/10.
//

import Foundation
import UIKit
import Combine

/// CalendarView delegate class
class CalendarDatabase: NSObject {
    let stat: Stat
    let publisher = PassthroughSubject<Date, Never>()
    
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
            return .image(UIImage(systemName: "book")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal))
        } else {
            return nil
        }
    }
    
    func calendarView(_ calendarView: UICalendarView, didChangeVisibleDateComponentsFrom previousDateComponents: DateComponents) {
        //
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return dateComponents != nil
    }
    
    // 날짜 선택
    // StatView update
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        publisher.send(date)
    }
}
