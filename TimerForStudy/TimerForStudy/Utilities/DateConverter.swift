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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM"
        return dateFormatter
    }()
    static let dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
}
