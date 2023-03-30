//
//  UIFont+ZFonts.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/29/23.
//

import Foundation
import UIKit

extension UIFont {

    /// creates an Almarai font of the given style
    convenience init(zStyle: ZFontStyle, size: CGFloat) {
        self.init(name: zStyle.fontName, size: size)!
    }

    /// The available font weights
    enum ZFontStyle: String {
        case light
        case regular
        case bold
        case extraBold
        
        var fontName: String {
            return "Almarai-\(self.rawValue.capitalized)"
        }
    }
}
