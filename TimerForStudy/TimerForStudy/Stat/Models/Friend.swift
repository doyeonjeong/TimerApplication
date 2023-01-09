//
//  Friend.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/09.
//

import Foundation
import SwiftUI

/// Friend Model
/// isFavorite이 true일때, 모델에서 monthlyData fetch
final class Friend: ObservableObject {
//    var loader: Loader
    let name: String
    let image: Image
    @Published var monthlyData: [Monthly]?
    @Published var isFavorite: Bool
//    @Published var isFavorite: Bool {
//        didSet {
//            if isFavorite == true {
//                monthlyData = loader.downloadMonthlyDataOfFriend()
//            } else {
//                monthlyData = nil
//            }
//        }
//    }
    
//    init(loader: Loader, name: String, image: Image, isFavorite: Bool) {
//        self.loader = loader
//        self.name = name
//        self.image = image
//        self.isFavorite = isFavorite
//        // monthlyData fetch
//        if isFavorite {
//            self.monthlyData = loader.downloadMonthlyDataOfFriend()
//        }
//    }
    
    init(name: String, image: Image, _ monthlyData: [Monthly]? = nil, isFavorite: Bool) {
        self.name = name
        self.image = image
        self.monthlyData = monthlyData
        self.isFavorite = isFavorite
        // monthlyData fetch
//        if isFavorite {
//            self.monthlyData = loader.downloadMonthlyDataOfFriend()
//        }
    }
}
