//
//  Extensions.swift
//  DigimonProject
//
//  Created by Kevin Mattocks on 4/23/23.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainOrange() -> UIColor {
        return UIColor.rgb(red: 232, green: 97, blue: 0)
    }
    
}
