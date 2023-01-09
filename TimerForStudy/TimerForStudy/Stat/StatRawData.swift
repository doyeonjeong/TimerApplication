//
//  StatRawData.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/04.
//

import Foundation
import SwiftUI

// For test
// mock object 생성해서 주입
private func createMockObject() -> Stat {
    // 2022년 9월 데이터
    let programmingData_9_1 = Category(name: "프로그래밍", time: 10000)
    let algorithmData_9_1 = Category(name: "알고리즘", time: 5000)
    let operatingSystemData_9_1 = Category(name: "운영체제", time: 5000)
    let interviewData_9_1 = Category(name: "면접", time: 3600)
    let dailyData_9_1 = Daily(DateConverter.dayFormatter.date(from: "2022.09.01")!, [programmingData_9_1, algorithmData_9_1, operatingSystemData_9_1, interviewData_9_1])
    
    let toeicData_9_2 = Category(name: "토익", time: 2000)
    let mathData_9_2 = Category(name: "수학", time: 3000)
    let programmingDate_9_2 = Category(name: "프로그래밍", time: 5000)
    let dailyData_9_2 = Daily(DateConverter.dayFormatter.date(from: "2022.09.02")!, [toeicData_9_2, mathData_9_2, programmingDate_9_2])
    
    let monthlyData_9 = Monthly(DateConverter.monthFormatter.date(from: "2022.09")!, [dailyData_9_1, dailyData_9_2])
    // 2022년 10월 데이터
    let toeicData_10_1 = Category(name: "토익", time: 2000)
    let mathData_10_1 = Category(name: "수학", time: 3000)
    let programmingDate_10_1 = Category(name: "프로그래밍", time: 15000)
    let dailyData_10_1 = Daily(DateConverter.dayFormatter.date(from: "2022.10.01")!, [toeicData_10_1, mathData_10_1, programmingDate_10_1])
    
    let toeicData_10_2 = Category(name: "토익", time: 2000)
    let mathData_10_2 = Category(name: "수학", time: 1000)
    let programmingDate_10_2 = Category(name: "프로그래밍", time: 7800)
    let dailyData_10_2 = Daily(DateConverter.dayFormatter.date(from: "2022.10.02")!, [toeicData_10_2, mathData_10_2, programmingDate_10_2])
    
    let monthlyData_10 = Monthly(DateConverter.monthFormatter.date(from: "2022.10")!, [dailyData_10_1, dailyData_10_2])
    // 2022년 11월 데이터
    let toeicData_11_1 = Category(name: "토익", time: 5000)
    let mathData_11_1 = Category(name: "수학", time: 6000)
    let programmingDate_11_1 = Category(name: "프로그래밍", time: 2000)
    let dailyData_11_1 = Daily(DateConverter.dayFormatter.date(from: "2022.11.01")!, [toeicData_11_1, mathData_11_1, programmingDate_11_1])
    
    let toeicData_11_2 = Category(name: "토익", time: 10000)
    let mathData_11_2 = Category(name: "수학", time: 4000)
    let programmingDate_11_2 = Category(name: "프로그래밍", time: 5000)
    let dailyData_11_2 = Daily(DateConverter.dayFormatter.date(from: "2022.11.02")!, [toeicData_11_2, mathData_11_2, programmingDate_11_2])
    
    let monthlyData_11 = Monthly(DateConverter.monthFormatter.date(from: "2022.11")!, [dailyData_11_1, dailyData_11_2])
    
    // 2022년 12월 데이터
    let toeicData_12_1 = Category(name: "토익", time: 20000)
    let mathData_12_1 = Category(name: "수학", time: 12000)
    let programmingDate_12_1 = Category(name: "프로그래밍", time: 5000)
    let dailyData_12_1 = Daily(DateConverter.dayFormatter.date(from: "2022.12.01")!, [toeicData_12_1, mathData_12_1, programmingDate_12_1])
    
    let toeicData_12_2 = Category(name: "토익", time: 20000)
    let mathData_12_2 = Category(name: "수학", time: 3000)
    let programmingDate_12_2 = Category(name: "프로그래밍", time: 1000)
    let dailyData_12_2 = Daily(DateConverter.dayFormatter.date(from: "2022.12.02")!, [toeicData_12_2, mathData_12_2, programmingDate_12_2])
    
    let monthlyData_12 = Monthly(DateConverter.monthFormatter.date(from: "2022.12")!, [dailyData_12_1, dailyData_12_2])
    
    // 2023년 1월 데이터
    let programmingData_1_1 = Category(name: "프로그래밍", time: 10000)
    let algorithmData_1_1 = Category(name: "알고리즘", time: 5500)
    let operatingSystemData_1_1 = Category(name: "운영체제", time: 4500)
    let interviewData_1_1 = Category(name: "면접", time: 2000)
    let dailyData_1_1 = Daily(DateConverter.dayFormatter.date(from: "2023.01.01")!, [programmingData_1_1, algorithmData_1_1, operatingSystemData_1_1, interviewData_1_1])
    
    let programmingData_1_2 = Category(name: "프로그래밍", time: 10000)
    let algorithmData_1_2 = Category(name: "알고리즘", time: 5500)
    let operatingSystemData_1_2 = Category(name: "운영체제", time: 4500)
    let interviewData_1_2 = Category(name: "면접", time: 2000)
    let dailyData_1_2 = Daily(DateConverter.dayFormatter.date(from: "2023.01.02")!, [programmingData_1_2, algorithmData_1_2, operatingSystemData_1_2, interviewData_1_2])
    
    let programmingData_1_5 = Category(name: "프로그래밍", time: 3600)
    let algorithmData_1_5 = Category(name: "알고리즘", time: 1800)
    let operatingSystemData_1_5 = Category(name: "운영체제", time: 5000)
    let interviewData_1_5 = Category(name: "면접", time: 3600)
    let dailyData_1_5 = Daily(DateConverter.dayFormatter.date(from: "2023.01.05")!, [programmingData_1_5, algorithmData_1_5, operatingSystemData_1_5, interviewData_1_5])
    
    let monthlyData_1 = Monthly(DateConverter.monthFormatter.date(from: "2023.01")!, [dailyData_1_1, dailyData_1_2, dailyData_1_5])
    
    let monthlyData = [monthlyData_9, monthlyData_10, monthlyData_11, monthlyData_12, monthlyData_1]
    let friends = [createMonthlyData_friend()]
    let stat = Stat("Yeolmok", monthlyData, [friendData])
    return stat
}

private func createMonthlyData_friend() -> [Monthly] {
    // 2022년 9월 데이터
    let programmingData_9_1 = Category(name: "프로그래밍", time: 1000)
    let algorithmData_9_1 = Category(name: "알고리즘", time: 5000)
    let operatingSystemData_9_1 = Category(name: "운영체제", time: 5000)
    let interviewData_9_1 = Category(name: "면접", time: 3600)
    let dailyData_9_1 = Daily(DateConverter.dayFormatter.date(from: "2022.09.01")!, [programmingData_9_1, algorithmData_9_1, operatingSystemData_9_1, interviewData_9_1])
    
    let toeicData_9_2 = Category(name: "토익", time: 2000)
    let mathData_9_2 = Category(name: "수학", time: 2500)
    let programmingDate_9_2 = Category(name: "프로그래밍", time: 5000)
    let dailyData_9_2 = Daily(DateConverter.dayFormatter.date(from: "2022.09.02")!, [toeicData_9_2, mathData_9_2, programmingDate_9_2])
    
    let monthlyData_9 = Monthly(DateConverter.monthFormatter.date(from: "2022.09")!, [dailyData_9_1, dailyData_9_2])
    // 2022년 10월 데이터
    let toeicData_10_1 = Category(name: "토익", time: 2000)
    let mathData_10_1 = Category(name: "수학", time: 3000)
    let programmingDate_10_1 = Category(name: "프로그래밍", time: 15000)
    let dailyData_10_1 = Daily(DateConverter.dayFormatter.date(from: "2022.10.01")!, [toeicData_10_1, mathData_10_1, programmingDate_10_1])
    
    let toeicData_10_2 = Category(name: "토익", time: 2000)
    let mathData_10_2 = Category(name: "수학", time: 1000)
    let programmingDate_10_2 = Category(name: "프로그래밍", time: 7800)
    let dailyData_10_2 = Daily(DateConverter.dayFormatter.date(from: "2022.10.02")!, [toeicData_10_2, mathData_10_2, programmingDate_10_2])
    
    let monthlyData_10 = Monthly(DateConverter.monthFormatter.date(from: "2022.10")!, [dailyData_10_1, dailyData_10_2])
    // 2022년 11월 데이터
    let toeicData_11_1 = Category(name: "토익", time: 4000)
    let mathData_11_1 = Category(name: "수학", time: 3600)
    let programmingDate_11_1 = Category(name: "프로그래밍", time: 2000)
    let dailyData_11_1 = Daily(DateConverter.dayFormatter.date(from: "2022.11.01")!, [toeicData_11_1, mathData_11_1, programmingDate_11_1])
    
    let toeicData_11_2 = Category(name: "토익", time: 10000)
    let mathData_11_2 = Category(name: "수학", time: 4000)
    let programmingDate_11_2 = Category(name: "프로그래밍", time: 5000)
    let dailyData_11_2 = Daily(DateConverter.dayFormatter.date(from: "2022.11.02")!, [toeicData_11_2, mathData_11_2, programmingDate_11_2])
    
    let monthlyData_11 = Monthly(DateConverter.monthFormatter.date(from: "2022.11")!, [dailyData_11_1, dailyData_11_2])
    
    // 2022년 12월 데이터
    let toeicData_12_1 = Category(name: "토익", time: 5000)
    let mathData_12_1 = Category(name: "수학", time: 1200)
    let programmingDate_12_1 = Category(name: "프로그래밍", time: 5000)
    let dailyData_12_1 = Daily(DateConverter.dayFormatter.date(from: "2022.12.01")!, [toeicData_12_1, mathData_12_1, programmingDate_12_1])
    
    let toeicData_12_2 = Category(name: "토익", time: 20000)
    let mathData_12_2 = Category(name: "수학", time: 3000)
    let programmingDate_12_2 = Category(name: "프로그래밍", time: 1000)
    let dailyData_12_2 = Daily(DateConverter.dayFormatter.date(from: "2022.12.02")!, [toeicData_12_2, mathData_12_2, programmingDate_12_2])
    
    let monthlyData_12 = Monthly(DateConverter.monthFormatter.date(from: "2022.12")!, [dailyData_12_1, dailyData_12_2])
    
    // 2023년 1월 데이터
    let programmingData_1_1 = Category(name: "프로그래밍", time: 10000)
    let algorithmData_1_1 = Category(name: "알고리즘", time: 5500)
    let operatingSystemData_1_1 = Category(name: "운영체제", time: 4500)
    let interviewData_1_1 = Category(name: "면접", time: 2000)
    let dailyData_1_1 = Daily(DateConverter.dayFormatter.date(from: "2023.01.01")!, [programmingData_1_1, algorithmData_1_1, operatingSystemData_1_1, interviewData_1_1])
    
    let programmingData_1_2 = Category(name: "프로그래밍", time: 10000)
    let algorithmData_1_2 = Category(name: "알고리즘", time: 5500)
    let operatingSystemData_1_2 = Category(name: "운영체제", time: 4500)
    let interviewData_1_2 = Category(name: "면접", time: 20000)
    let dailyData_1_2 = Daily(DateConverter.dayFormatter.date(from: "2023.01.02")!, [programmingData_1_2, algorithmData_1_2, operatingSystemData_1_2, interviewData_1_2])
    
    let programmingData_1_5 = Category(name: "프로그래밍", time: 3600)
    let algorithmData_1_5 = Category(name: "알고리즘", time: 1000)
    let operatingSystemData_1_5 = Category(name: "운영체제", time: 3000)
    let interviewData_1_5 = Category(name: "면접", time: 3600)
    let dailyData_1_5 = Daily(DateConverter.dayFormatter.date(from: "2023.01.05")!, [programmingData_1_5, algorithmData_1_5, operatingSystemData_1_5, interviewData_1_5])
    
    let monthlyData_1 = Monthly(DateConverter.monthFormatter.date(from: "2023.01")!, [dailyData_1_1, dailyData_1_2, dailyData_1_5])
    
    let monthlyData = [monthlyData_9, monthlyData_10, monthlyData_11, monthlyData_12, monthlyData_1]
    return monthlyData
}

let monthlyData_friend = createMonthlyData_friend()
let friendData = Friend(name: "Friend 1", image: Image("User1"), monthlyData_friend, isPeeping: true)
let statRawData = createMockObject()
