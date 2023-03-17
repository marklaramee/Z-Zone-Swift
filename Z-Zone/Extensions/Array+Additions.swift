//
//  Array+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/11/23.
//

import Foundation

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
    
    func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        var result: [ElementOfResult] = []
        for element in self {
            if let transformed = try transform(element) {
                result.append(transformed)
            }
        }
        return result
    }
}
