//
//  TabBarController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/12/11.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let statViewController = StatViewController()
        
        let timerViewController = TimerViewController()
        let timerNavigationController = UINavigationController(rootViewController: timerViewController)
        
        let profileViewController = UserMainViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        statViewController.tabBarItem = UITabBarItem(title: TitleConstants.stat, image: UIImage(systemName: ImageName.stat), tag: NumberConstants.first)
        timerNavigationController.tabBarItem = UITabBarItem(title: TitleConstants.timer, image: UIImage(systemName: ImageName.timer), tag: NumberConstants.second)
        profileNavigationController.tabBarItem = UITabBarItem(title: TitleConstants.profile, image: UIImage(systemName: ImageName.profile), tag: NumberConstants.third)
        
        viewControllers = [statViewController, timerNavigationController, profileNavigationController]
        setViewControllers(viewControllers, animated: true)
    }
}

private enum TitleConstants {
    static let stat = "통계"
    static let timer = "타이머"
    static let profile = "프로필"
}

private enum ImageName {
    static let stat = "list.clipboard"
    static let timer = "clock"
    static let profile = "person.crop.circle"
}

private enum NumberConstants {
    static let first = 0
    static let second = 1
    static let third = 2
}
