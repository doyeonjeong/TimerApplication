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

    private let stat: Stat = statRawData
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
        let totalStatView = PopoverButtonView(stat: statRawData)
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
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.spacing),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.spacing),
            calendarView.heightAnchor.constraint(equalToConstant: LayoutConstants.calendarViewHeight),
            
            totalStatHostingController.view.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            totalStatHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.spacing),
            totalStatHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.spacing),
            totalStatHostingController.view.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            
            dailyStatHostingController.view.topAnchor.constraint(equalTo: totalStatHostingController.view.bottomAnchor),
            dailyStatHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.spacing),
            dailyStatHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.spacing),
            dailyStatHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutConstants.bottomSpacing)
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
    
    // 공부한 날은 UIColor 적용
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 공부한 적이 없는 달이라면 systemBackground 적용
        guard let monthlyData = stat.monthlyData.first(where: { DateConverter.monthFormatter.string(from: $0.month) == DateConverter.monthFormatter.string(from: date) }) else {
            cell.backgroundColor = .systemBackground
            return
        }
        let days = monthlyData.dailyData.map { DateConverter.dayFormatter.string(from: $0.day) }
        // 공부한 날이라면 systemOrange 적용
        if days.contains(DateConverter.dayFormatter.string(from: date)) {
            cell.backgroundColor = .systemOrange
        } else {
            cell.backgroundColor = .systemBackground
        }
    }
}

private enum LayoutConstants {
    static let spacing: CGFloat = 8
    static let bottomSpacing: CGFloat = 30
    static let buttonHeight: CGFloat = 30
    static let calendarViewHeight: CGFloat = 300
}
