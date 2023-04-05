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
    
    var isLargeFont: Bool {
        switch UIApplication.shared.preferredContentSizeCategory {
        case UIContentSizeCategory.accessibilityLarge,
            UIContentSizeCategory.extraLarge,
            UIContentSizeCategory.accessibilityExtraLarge,
            UIContentSizeCategory.extraExtraLarge,
            UIContentSizeCategory.accessibilityExtraExtraLarge,
            UIContentSizeCategory.extraExtraExtraLarge,
            UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return true
        default:
            return false
        }
    }

    var fontMultiplier: CGFloat {
        debugPrint("ML: \(UIApplication.shared.preferredContentSizeCategory)")
        let contentSize = UIApplication.shared.preferredContentSizeCategory;
        guard contentSize.isAccessibilityCategory else {
            return 1.0
        }
        switch UIApplication.shared.preferredContentSizeCategory {
        case UIContentSizeCategory.accessibilityMedium:
            return 1.25
        case UIContentSizeCategory.accessibilityLarge:
            return 1.5
        case UIContentSizeCategory.extraLarge, UIContentSizeCategory.accessibilityExtraLarge:
            return 1.75
        case UIContentSizeCategory.extraExtraLarge, UIContentSizeCategory.extraExtraLarge:
            return 2.0
        case UIContentSizeCategory.extraExtraLarge, UIContentSizeCategory.accessibilityExtraExtraLarge:
            return 2.5
        case UIContentSizeCategory.extraExtraExtraLarge, UIContentSizeCategory.accessibilityExtraExtraExtraLarge:
            return 3.0
        default:
            return 1
        }
    }
    
    func changeFontSize(font: UIFont?, size: CGFloat) -> UIFont? {
        let a11ySize = maxFontSize(size)
        guard let originalFont = font,
          let newFontDescriptor = originalFont.fontDescriptor
            .withFamily(originalFont.familyName)
            .withSymbolicTraits(originalFont.fontDescriptor.symbolicTraits)  else {
            // return supplied font if anything isn't right
            return font
            
        }

        let newFont = UIFont(
            descriptor: newFontDescriptor,
            size: a11ySize
        )
        return newFont
    }
    
    func maxFontSize(_ size: CGFloat) -> CGFloat {
        guard size <= maxFontSize else {
            return size
        }
        return CGFloat.minimum(size * fontMultiplier, maxFontSize)
    }
}
