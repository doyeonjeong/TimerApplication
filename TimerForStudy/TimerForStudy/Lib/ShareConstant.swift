//
//  ShareConstant.swift
//  TimerForStudy
//
//  Created by 유준용 on 2022/12/13.
//

import Foundation

struct ShareConstant {
    
    static var shared = ShareConstant()
    
    private init(){}
    
    var reachability = Reachability()!
    
    
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
    
    func getVersion() -> String {
        guard let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
            return ""
        }
        return appVersion
    }
}
