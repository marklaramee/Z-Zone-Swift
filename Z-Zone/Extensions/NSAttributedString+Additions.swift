//
//  NSAttributedString+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/11/23.
//

import Foundation

extension NSAttributedString {
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
