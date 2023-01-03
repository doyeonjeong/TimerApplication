//
//  StatViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit
import SwiftUI
import FSCalendar

final class StatViewController: UIViewController {

    private let stat: Stat = statRowData
    private var dailyStatHostingController: UIHostingController<DailyStatView>!
    private var totalStatHostingController: UIHostingController<PopoverButtonView>!
    
    private let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        configureAndEmbedView()
        configureUI()
    }
    
    // SwiftUI View Model에 주입할 통계 데이터 가져오는 함수
    private func fetchStatData() { }
}

// MARK: - Configure View
extension StatViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureHierachy()
        configureLayout()
    }
    
    // Embed SwiftUI View
    private func configureAndEmbedView() {
        let totalStatView = PopoverButtonView(stat: statRowData)
        let dailyStatView = DailyStatView(dailyData: stat.monthlyData[0].dailyData[0])
        
        totalStatHostingController = UIHostingController(rootView: totalStatView)
        dailyStatHostingController = UIHostingController(rootView: dailyStatView)
        
        addChild(totalStatHostingController)
        addChild(dailyStatHostingController)
        
        totalStatHostingController.didMove(toParent: self)
        dailyStatHostingController.didMove(toParent: self)
    }
    
    private func configureHierachy() {
        [calendarView, totalStatHostingController.view, dailyStatHostingController.view].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureLayout() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        totalStatHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        dailyStatHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.offset),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.offset),
            calendarView.heightAnchor.constraint(equalToConstant: LayoutConstants.calendarViewHeight),
            
            totalStatHostingController.view.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            totalStatHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.offset),
            totalStatHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.offset),
            totalStatHostingController.view.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            
            dailyStatHostingController.view.topAnchor.constraint(equalTo: totalStatHostingController.view.bottomAnchor),
            dailyStatHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.offset),
            dailyStatHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.offset),
            dailyStatHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutConstants.bottomOffset)
        ])
    }
    
    private func configureCalendar() {
        calendarView.dataSource = self
        calendarView.delegate = self
    }
    
    private func updateDailyCharts(_ date: Date) {
        if let dailyData = stat.fetchDailyData(date) {
            dailyStatHostingController.rootView = DailyStatView(dailyData: dailyData)
        } else {
//            hostingController.rootView = EmptyView()
        }
    }
}

// MARK: - CanlendarView 관련
extension StatViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 날짜 선택
    // 일간 차트 present
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        updateDailyCharts(date)
    }
    
    // 날짜 선택 해제
    // 다시 월간 차트 present
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //
    }
}

private enum LayoutConstants {
    static let offset: CGFloat = 8
    static let bottomOffset: CGFloat = 30
    static let buttonHeight: CGFloat = 30
    static let calendarViewHeight: CGFloat = 300
}
