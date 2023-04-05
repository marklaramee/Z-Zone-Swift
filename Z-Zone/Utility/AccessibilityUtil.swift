//
//  AccessibilityUtil.swift
//  Z-Zone
//
//  Created by Mark Laramee on 4/5/23.
//

import UIKit

class AccessibilityUtil {
    let maxFontSize: CGFloat = 48
    static let shared = AccessibilityUtil()

    var fontMultiplier: CGFloat {
        let contentSize = UIApplication.shared.preferredContentSizeCategory;
        guard contentSize.isAccessibilityCategory else {
            return 1.0
        }
        switch UIApplication.shared.preferredContentSizeCategory {
        case UIContentSizeCategory.accessibilityMedium:
            return 1.25
        case UIContentSizeCategory.accessibilityLarge:
            return 1.5
        case UIContentSizeCategory.accessibilityExtraLarge:
            return 1.75
        case UIContentSizeCategory.extraExtraLarge:
            return 2.0
        case UIContentSizeCategory.accessibilityExtraExtraLarge:
            return 2.5
        case UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return 3.0
        default:
            return 1.0
        }
    }
    
    func maxFontSize(_ size: CGFloat) -> CGFloat {
        guard size <= maxFontSize else {
            return size
        }
        return CGFloat.minimum(size * fontMultiplier, maxFontSize)
    }
}
