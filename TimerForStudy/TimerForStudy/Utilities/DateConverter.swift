//
//  DateConverter.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/03.
//

import Foundation

/// Date format 통일
enum DateConverter {
    static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter
    }()
    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    static let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter
    }()
}
