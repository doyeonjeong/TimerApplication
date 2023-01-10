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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let statView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
            statView.addSubview($0)
        }
        scrollView.addSubview(statView)
        view.addSubview(scrollView)
    }
    
    private func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        totalStatHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        dailyStatHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.spacing),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: LayoutConstants.spacing),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: LayoutConstants.bottomSpacing),
            
            statView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            statView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            statView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            statView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            statView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            statView.heightAnchor.constraint(equalToConstant: LayoutConstants.statViewHeight),
            
            calendarView.topAnchor.constraint(equalTo: statView.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: statView.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: statView.trailingAnchor),
            
            totalStatHostingController.view.topAnchor.constraint(equalTo: calendarView.bottomAnchor),
            totalStatHostingController.view.leadingAnchor.constraint(equalTo: statView.leadingAnchor),
            totalStatHostingController.view.trailingAnchor.constraint(equalTo: statView.trailingAnchor),
            totalStatHostingController.view.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight),
            
            dailyStatHostingController.view.topAnchor.constraint(equalTo: totalStatHostingController.view.bottomAnchor),
            dailyStatHostingController.view.leadingAnchor.constraint(equalTo: statView.leadingAnchor),
            dailyStatHostingController.view.trailingAnchor.constraint(equalTo: statView.trailingAnchor),
            dailyStatHostingController.view.heightAnchor.constraint(equalToConstant: LayoutConstants.dailyStatViewHeight)
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
    static let statViewHeight: CGFloat = 1000
    static let dailyStatViewHeight: CGFloat = 400
}
