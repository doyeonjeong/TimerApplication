//
//  StatRowData.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2023/01/04.
//

import Foundation

// For test
// mock object 생성해서 주입
func createMockObject() -> Stat {
    // 2022년 9월 데이터
    let programmingData_9 = Subject(name: "프로그래밍", time: 10000)
    let algorithmData_9 = Subject(name: "알고리즘", time: 5000)
    let operatingSystemData_9 = Subject(name: "운영체제", time: 5000)
    let interviewData_9 = Subject(name: "면접", time: 3600)
    let dailyData_9_1 = Daily(DateConverter.dayFormatter.date(from: "2022.09.01")!, [programmingData_9, algorithmData_9, operatingSystemData_9, interviewData_9])
    let monthlyData_9 = Monthly(DateConverter.monthFormatter.date(from: "2022.09")!, [dailyData_9_1])
    // 2022년 10월 데이터
    let toeicData_10 = Subject(name: "토익", time: 2000)
    let mathData_10 = Subject(name: "수학", time: 3000)
    let programmingDate_10 = Subject(name: "프로그래밍", time: 15000)
    let dailyData_10_1 = Daily(DateConverter.dayFormatter.date(from: "2022.10.01")!, [toeicData_10, mathData_10, programmingDate_10])
    let monthlyData_10 = Monthly(DateConverter.monthFormatter.date(from: "2022.10")!, [dailyData_10_1])
    // 2022년 11월 데이터
    let toeicData_11 = Subject(name: "토익", time: 5000)
    let mathData_11 = Subject(name: "수학", time: 6000)
    let programmingDate_11 = Subject(name: "프로그래밍", time: 2000)
    let dailyData_11_1 = Daily(DateConverter.dayFormatter.date(from: "2022.11.01")!, [toeicData_11, mathData_11, programmingDate_11])
    let monthlyData_11 = Monthly(DateConverter.monthFormatter.date(from: "2022.11")!, [dailyData_11_1])
    // 2022년 12월 데이터
    let toeicData_12 = Subject(name: "토익", time: 20000)
    let mathData_12 = Subject(name: "수학", time: 12000)
    let programmingDate_12 = Subject(name: "프로그래밍", time: 5000)
    let dailyData_12_1 = Daily(DateConverter.dayFormatter.date(from: "2022.12.01")!, [toeicData_12, mathData_12, programmingDate_12])
    let monthlyData_12 = Monthly(DateConverter.monthFormatter.date(from: "2022.12")!, [dailyData_12_1])
    // 2023년 1월 데이터
    let programmingData_1 = Subject(name: "프로그래밍", time: 10000)
    let algorithmData_1 = Subject(name: "알고리즘", time: 5500)
    let operatingSystemData_1 = Subject(name: "운영체제", time: 4500)
    let interviewData_1 = Subject(name: "면접", time: 2000)
    let dailyData_1 = Daily(DateConverter.dayFormatter.date(from: "2023.01.01")!, [programmingData_1, algorithmData_1, operatingSystemData_1, interviewData_1])
    let monthlyData_1 = Monthly(DateConverter.monthFormatter.date(from: "2023.01")!, [dailyData_1])
    
    let stat = Stat("yeolmok", [monthlyData_9, monthlyData_10, monthlyData_11, monthlyData_12, monthlyData_1])
    return stat
}

let statRowData = createMockObject()
