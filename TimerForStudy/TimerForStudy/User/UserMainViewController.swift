//
//  UserMainViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit
import SwiftUI

class UserMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAndEmbedView()
    }
    
    // Embed SwiftUI View
    private func configureAndEmbedView() {
        let userMainView = UserMainView()
        let hostingController = UIHostingController(rootView: userMainView)
        
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
}
