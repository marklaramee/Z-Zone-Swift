//
//  CNContact+Additions.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/17/23.
//

import Foundation
import Contacts

infix operator ====: ComparisonPrecedence

extension CNContact: Equatable {
    public static func ====(lhs: CNContact, rhs: CNContact) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
