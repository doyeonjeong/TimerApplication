//
//  Account.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/11/29.
//

import Foundation

struct Account {
    var id: String
    var nickname: String
    
    init(_ id: String, _ nickname: String) {
        self.id = id
        self.nickname = nickname
    }
}
