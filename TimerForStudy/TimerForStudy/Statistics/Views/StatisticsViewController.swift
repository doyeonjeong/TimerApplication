//
//  StatisticsViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit
import SwiftUI
import FSCalendar

class StatisticsViewController: UIViewController {

    private let calendarView: FSCalendar = {
        let calendar = FSCalendar()
        return calendar
    }()
    
    private var hostingController: UIHostingController<StatisticsView>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAndEmbedView()
        configureUI()
    }
    
    // SwiftUI View Model에 주입할 통계 데이터 가져오는 함수
    private func fetchStatData() { }
    
    // For test
    // mock object 생성해서 주입
    static func createMockObject() -> Statistics {
        let programmingData = Subject(name: "프로그래밍", total: 2000)
        let algorithmData = Subject(name: "알고리즘", total: 1100)
        let operatingSystemData = Subject(name: "운영체제", total: 900)
        let model = Statistics(name: "Yeolmok", total: 4000, subjects: [programmingData, algorithmData, operatingSystemData])
        
        return model
    }
}

// MARK: - Configure View
extension StatisticsViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureHierachy()
        configureLayout()
    }
    
    // Embed SwiftUI View
    private func configureAndEmbedView() {
        let data = Self.createMockObject()
        let statisticsView = StatisticsView(stat: data)
        hostingController = UIHostingController(rootView: statisticsView)
        
        addChild(hostingController)
        hostingController.didMove(toParent: self)
    }
    
    private func configureHierachy() {
        [calendarView, hostingController.view].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureLayout() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.offset),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.offset),
            calendarView.heightAnchor.constraint(equalToConstant: LayoutConstants.calendarViewHeight),
            
            hostingController.view.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: LayoutConstants.largeOffset),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutConstants.offset),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutConstants.offset),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -LayoutConstants.bottomOffset)
        ])
    }
}

private enum LayoutConstants {
    static let offset: CGFloat = 8
    static let largeOffset: CGFloat = 20
    static let bottomOffset: CGFloat = 30
    static let calendarViewHeight: CGFloat = 300
}
