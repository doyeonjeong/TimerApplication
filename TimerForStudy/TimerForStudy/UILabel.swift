//
//  UILabel.swift
//  TimerForStudy
//
//  Created by 유준용 on 2022/12/13.
//

import UIKit

extension UILabel {
    
    // Method - 라벨의 width, height을 리턴함
    func getWidthHeightByText() -> CGSize {
        var rect: CGRect = self.frame //get frame of label
        rect.size = (self.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont(name: self.font.fontName , size: self.font.pointSize)!]))! //Calculate as per label font
        return CGSize(width: rect.width, height: rect.height)
    }
}
