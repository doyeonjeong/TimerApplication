//
//  StatViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit
import SwiftUI
import Combine

final class StatViewController: UIViewController {

    private let stat: Stat = statRawData
    private var dailyStatHostingController: UIHostingController<DailyStatView>!
    private var totalStatHostingController: UIHostingController<PopoverButtonView>!
    
    private var calendarView: UICalendarView!
    private var calendarDatabase = CalendarDatabase(stat: statRawData)
    private var subscriptions = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
        setBindings()
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
//            calendarView.heightAnchor.constraint(equalToConstant: LayoutConstants.calendarViewHeight),
            
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
        // configure
        let calendarView = UICalendarView()
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        let dateSelection = UICalendarSelectionSingleDate(delegate: calendarDatabase)
        calendarView.selectionBehavior = dateSelection
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        
        // range
        let fromDataComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2022, month: 1, day: 1)
        let endDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 12, day: 1)
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 1, day: 1)
        
        guard let fromDate = fromDataComponents.date, let endDate = endDateComponents.date else { return }
        let calendarViewDateRange = DateInterval(start: fromDate, end: endDate)
        calendarView.availableDateRange = calendarViewDateRange
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        self.calendarView = calendarView
        view.addSubview(calendarView)
        calendarView.delegate = calendarDatabase
    }
    
    // StatView update
    private func updateDailyCharts(_ date: Date) {
        if let dailyData = stat.fetchDailyData(date) {
            dailyStatHostingController.rootView = DailyStatView(dailyData: dailyData)
        } else {
//            hostingController.rootView = EmptyView()
        }
    }
    
    private func setBindings() {
        calendarDatabase.publisher.sink { receivedDate in
            self.updateDailyCharts(receivedDate)
        }
        .store(in: &subscriptions)
    }
}

private enum LayoutConstants {
    static let spacing: CGFloat = 8
    static let bottomSpacing: CGFloat = 30
    static let buttonHeight: CGFloat = 30
    static let calendarViewHeight: CGFloat = 400
}
