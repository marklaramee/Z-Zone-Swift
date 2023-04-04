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
    convenience init(zStyle: zStyle, size: CGFloat) {
        self.init(name: zStyle.rawValue, size: size)!
    }

    /// The available font weights
    enum zStyle: String {
        case almaraiLight = "Almarai-Light"
        case almaraiRegular = "Almarai-Regular"
        case almaraiBold = "Almarai-Bold"
        case almaraiExtraBold = "Almarai-ExtraBold"
        case titan = "TitanOne"
    }
}
