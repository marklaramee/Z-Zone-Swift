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
}
