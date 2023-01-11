//
//  UIColor.swift
//  TimerForStudy
//
//  Created by Doyeon on 2023/01/11.
//

import UIKit

extension UIColor {
    /// [사용 예시 1]
    /// view.backgroundColor = .primaryVariant
    /// [사용 예시 2]
    /// .foregroundColor(Color(UIColor.secondary!))
    
    /// Primary ColorSet = UIColor(red: 0.118, green: 0.153, blue: 0.173, alpha: 1).cgColor
    class var primary: UIColor? { return UIColor(named: "Primary") }
    
    /// PrimaryVariant ColorSet = UIColor(red: 0.145, green: 0.275, blue: 0.612, alpha: 1).cgColor
    class var primaryVariant: UIColor? { return UIColor(named: "PrimaryVariant") }
    
    /// Secondary ColorSet = UIColor(red: 0.933, green: 0.486, blue: 0.227, alpha: 1).cgColor
    class var secondary: UIColor? { return UIColor(named: "Secondary") }
    
    /// SecondaryVariant ColorSet = UIColor(red: 0.933, green: 0.486, blue: 0.227, alpha: 0.6).cgColor
    class var secondaryVariant: UIColor? { return UIColor(named: "SecondaryVariant") }
    
    /// Background1 ColorSet = UIColor(red: 0.938, green: 0.938, blue: 0.938, alpha: 1).cgColor
    class var background1: UIColor? { return UIColor(named: "Background1") }
    
    /// Background2 ColorSet = UIColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 1).cgColor
    class var background2: UIColor? { return UIColor(named: "Background2") }
    
    /// WarningError ColorSet = UIColor(red: 0.958, green: 0.778, blue: 0.315, alpha: 1).cgColor
    class var warningError: UIColor? { return UIColor(named: "WarningError") }
    
    /// Error ColorSet = UIColor(red: 0.783, green: 0.251, blue: 0.315, alpha: 1).cgColor
    class var errorRed: UIColor? { return UIColor(named: "Error") }
    
    /// TypoWhite ColorSet = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
    class var typoWhite: UIColor? { return UIColor(named: "TypoWhite") }
    
    /// TypoBlack ColorSet = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1).cgColor
    class var typoBlack: UIColor? { return UIColor(named: "TypoBlack") }
}
