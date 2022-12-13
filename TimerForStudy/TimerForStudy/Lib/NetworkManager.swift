//
//  NetworkManager.swift
//  TimerForStudy
//
//  Created by 유준용 on 2022/12/13.
//

import Foundation

class NetworkManager {
    func checkNetworking() {
        let reachability = ShareConstant.shared.reachability
        reachability.whenUnreachable = { _ in
            NotificationCenter.default.post(name: NSNotification.Name.init("NetworkError"), object: nil)
        }
        
        reachability.whenReachable = { _ in
            print("Connect to network")
        }
        
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    deinit {
        print("Good Bye")
    }
}
