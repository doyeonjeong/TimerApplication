//
//  UIView.swift
//  TimerForStudy
//
//  Created by 유준용 on 2022/12/13.
//

import Foundation
import UIKit

extension UIView{
    
    func displayToast(_ message : String, bottomSpace: CGFloat = 20.0) {
        guard let window = UIApplication.shared.windows.first else {return}
        
        if let toast = window.subviews.first(where: { $0 is UILabel && $0.tag == -1001 }) {
            toast.removeFromSuperview()
        }
        
        let toastView = UILabel()
        toastView.clipsToBounds = true
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.layer.cornerRadius = 8.0
        toastView.textColor = UIColor.white
        toastView.textAlignment = .center
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.tag = -1001
        window.addSubview(toastView)
        let textSize = toastView.getWidthHeightByText()
        let widht = textSize.width
        let height = textSize.height
        let bottomArea = self.getBottomSafeArea(byWindow: true)
        let newBottomSpace = bottomSpace + bottomArea
        toastView.heightAnchor.constraint(equalToConstant: height + 18).isActive = true
        toastView.widthAnchor.constraint(equalToConstant: widht + 32).isActive = true
        toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: CGFloat(-newBottomSpace)).isActive = true
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
    
    func getBottomSafeArea(byWindow: Bool = false) -> CGFloat {
        var bottomPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomPadding = self.safeAreaInsets.bottom
            if byWindow {
                let window = UIApplication.shared.windows.first
                bottomPadding = window?.safeAreaInsets.bottom ?? 0
            }
        }
        return bottomPadding
    }
}
