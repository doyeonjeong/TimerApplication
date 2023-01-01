//
//  StatisticsViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit
import SwiftUI

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAndEmbedView()
    }
    
    // Embed SwiftUI View
    private func configureAndEmbedView() {
        let statisticsView = StatisticsView()
            .environmentObject(Self.createMockObject())
        let hostingController = UIHostingController(rootView: statisticsView)
        
        self.addChild(hostingController)
        self.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
