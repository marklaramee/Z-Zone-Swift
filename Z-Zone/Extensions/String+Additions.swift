//
//  String+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/17/23.
//

import Foundation

extension String {
    /// Trims beginning and ending whitespace
    //    func trim() -> NSAttributedString {
    //        let invertedSet = CharacterSet.whitespacesAndNewlines.inverted
    //        let startRange = string.rangeOfCharacter(from: invertedSet)
    //        let endRange = string.rangeOfCharacter(from: invertedSet, options: .backwards)
    //        guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
    //            return NSAttributedString(string: string)
    //        }
    //
    //        let trimmedRange = startLocation...endLocation
    //        return attributedSubstring(from: NSRange(trimmedRange, in: string))
    //    }
    
    func trim(_ name: String) -> String {
        var result = name
        while result.first == " " {
            result.removeFirst()
        }
        while result.last == " " {
            result.removeFirst()
        }
        return result
    }
    
    func removeZZoneIfPresent(_ name: String) -> String {
        let zZone = "zzz"
        var result = name
        if result.hasPrefix(zZone) {
            let index = result.index(result.startIndex, offsetBy: zZone.count)
            result.removeSubrange(result.startIndex..<index)
        }
        return result
    }
    
}
