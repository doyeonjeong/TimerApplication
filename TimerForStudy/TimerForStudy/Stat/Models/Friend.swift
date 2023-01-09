//
//  Friend.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation
import SwiftUI

/// Friend Model
/// isPeeping이 true일때, 모델에서 monthlyData fetch
struct Friend: Identifiable {
//    var loader: Loader
    let name: String
    let image: Image
    var monthlyData: [Monthly]?
    var isAccessEnabled: Bool
    var isPeeping: Bool {
        didSet {
            if isPeeping && isAccessEnabled {
                if name == "정도연" {
                    monthlyData = monthlyData_friend_1
                } else if name == "유준용" {
                    monthlyData = monthlyData_friend_3
                }
            } else {
                monthlyData = nil
            }
        }
    }
    
    var id = UUID()
//    var isPeeping: Bool {
//        didSet {
//            if isPeeping == true {
//                monthlyData = loader.downloadMonthlyDataOfFriend()
//            } else {
//                monthlyData = nil
//            }
//        }
//    }
    
//    init(loader: Loader, name: String, image: Image, isPeeping: Bool) {
//        self.loader = loader
//        self.name = name
//        self.image = image
//        self.isPeeping = isPeeping
//        // monthlyData fetch
//        if isPeeping {
//            self.monthlyData = loader.downloadMonthlyDataOfFriend()
//        }
//    }
    
    init(name: String, image: Image, _ monthlyData: [Monthly]? = nil, isAccessEnabled: Bool, isPeeping: Bool) {
        self.name = name
        self.image = image
        self.monthlyData = monthlyData
        self.isAccessEnabled = isAccessEnabled
        self.isPeeping = isPeeping
        // monthlyData fetch
//        if isPeeping {
//            self.monthlyData = loader.downloadMonthlyDataOfFriend()
//        }
    }
}
