//
//  UIColor+ZColors.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/29/23.
//

import Foundation
import UIKit

extension UIColor {
    /// Init with RBG values: 0-255.
    convenience init(zRed: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: zRed/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    // Inspired by answers here - https://stackoverflow.com/a/27203691
    /// Init with a hex string value: "#ffffff" or "ffffff". Handles upper and lower cased values
    convenience init(hex: String?) {
        guard let hex = hex else {
            self.init(red: 1, green: 1, blue: 1, alpha: 0)
            return
        }

        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        // Handle black/white special cases
        if cString == "000" {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }
        if cString == "FFF" {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }

        // Outside of special cases, just return if not equal to 6
        if cString.count != 6 {
            // Logger.shared.error(message: "Color hex value not valid", keyValues: ["hexValue": hex])
            self.init(red: 1, green: 1, blue: 1, alpha: 0)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class ZZone {
        static let black = UIColor(named: "Z-Black") ?? UIColor(zRed: 0, green: 0, blue: 0, alpha: 1)
        static let purple = UIColor(named: "Z-Purple") ?? UIColor(zRed: 95, green: 19, blue: 105, alpha: 1)
    }
}
