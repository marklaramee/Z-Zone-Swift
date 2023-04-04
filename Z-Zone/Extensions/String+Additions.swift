//
//  String+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/17/23.
//

import Foundation

extension String {
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
    
    func removeIfPresent(_ remove: String) -> String {
        guard self.hasPrefix(remove) else {
            return self
        }
        var result = self
        let index = result.index(result.startIndex, offsetBy: remove.count)
        result.removeSubrange(result.startIndex..<index)
        return result
    }
    
    func prependIfNotPresent(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else {
            return self
        }
        return "\(prefix)\(self)"
    }
    
}
