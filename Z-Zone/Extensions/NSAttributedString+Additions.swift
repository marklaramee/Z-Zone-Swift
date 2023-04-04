//
//  NSAttributedString+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/11/23.
//

import Foundation
import UIKit

extension NSAttributedString {
    convenience init(
        zString: String,
        size: CGFloat,
        style: UIFont.zStyle,
        color: UIColor = UIColor.ZZone.black,
        align: NSTextAlignment? = nil,
        isAllCaps: Bool = false,
        lineSpacing: CGFloat? = nil
    ) {
        // TODO: replace initializer below with a11yFontSize
        // let a11yFontSize = AccessibilityUtil.shared.maxFontSize(size)
        
        let font = UIFont(zStyle: style, size: size)
        let fontColor = color // TODO: remove?
        let titleString = isAllCaps ? zString.uppercased() : zString
        var attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: fontColor
        ]
        
        let style = NSMutableParagraphStyle()
        var addParagraphStyle = false
        if let alignment = align {
            style.alignment = alignment
            addParagraphStyle = true // TODO: refactor
        }
        if addParagraphStyle {
            attributes[.paragraphStyle] = style
        }
        
        self.init(string: titleString, attributes: attributes)
    }
    
    
    /// Trims beginning and ending whitespace
    func trim() -> NSAttributedString {
        let invertedSet = CharacterSet.whitespacesAndNewlines.inverted
        let startRange = string.rangeOfCharacter(from: invertedSet)
        let endRange = string.rangeOfCharacter(from: invertedSet, options: .backwards)
        guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
            return NSAttributedString(string: string)
        }

        let trimmedRange = startLocation...endLocation
        return attributedSubstring(from: NSRange(trimmedRange, in: string))
    }
}
