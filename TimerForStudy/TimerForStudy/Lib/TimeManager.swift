//
//  InTimer.swift
//  TimerForStudy
//
//  Created by 유준용 on 2022/12/13.
//

import Foundation
import UIKit

final class TimeManager {
    static let shared = TimeManager()
    
    var timer = Timer()
    var passTime: TimeInterval?
    var startTime: Date?
    
    private init(){
        NotificationCenter.default.addObserver(self, selector: #selector(toast), name: NSNotification.Name("TestNotification"), object: nil)
        self.startTime = Date.now
    }
    
    
    @objc func toast(){
        guard let time = self.passTime else{return}
        
        let timeStr = String(time)
        UIView().displayToast(timeStr + "초 경과")
    }
    
    public func resetTimer(){
        if self.timer.isValid {
            self.timer.invalidate()
        }
        self.passTime = nil
    }
    
    public func startTimer(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
            self.passTime = round(self.startTime?.timeIntervalSinceNow ?? 0.0) * -1
            NotificationCenter.default.post(name: NSNotification.Name("TestNotification"), object: nil)
        }
        
 
    }
    
}
