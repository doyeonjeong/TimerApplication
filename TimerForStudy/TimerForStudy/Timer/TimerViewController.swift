//
//  TimerViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit

class TimerViewController: UIViewController {

    let timeManager = TimeManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeManager.startTimer() // testcode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.backgroundColor = .systemBackground
        
    }
    
    
}
