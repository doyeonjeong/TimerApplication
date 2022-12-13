//
//  ShareConstant.swift
//  TimerForStudy
//
//  Created by 유준용 on 2022/12/13.
//

import Foundation

struct ShareConstant {
    //MARK: - 앱 전역적으로 사용될 필요가 있는 UtilMethod 혹은 Properties
    static var shared = ShareConstant()
    
    private init(){}
    
    var reachability = Reachability()!
    
    // Method - Date를 String 형태로 변환 (format: 연도 + 월 + 날 + 시간 + 분 + 초)
    func dateToString(date: NSDate, format: NSString, localIdentifier: NSString) -> NSString {
        var dateFormat : NSString = format
        if dateFormat == "" {
            dateFormat = "yyyyMMddHHmmss"
        }
        let dateFormatter : DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat as String
        
        if localIdentifier != "" {
            dateFormatter.locale = Locale.init(identifier: localIdentifier as String)
        }
        return dateFormatter.string(from: date as Date) as NSString
    }
    
    // Method - App Version을 리턴
    func getVersion() -> String {
        guard let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
            return ""
        }
        return appVersion
    }
}
