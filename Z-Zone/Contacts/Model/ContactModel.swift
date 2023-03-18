//
//  ContactsModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/10/23.
//

import Foundation
import Contacts

// TODO: remove nillable?
struct ContactModel: Equatable {
    var fullName: String
    var contact: CNContact
    var isZZone: Bool
}

// TODO: remove?
enum ContactDisplayType {
    case rawStyle
    case zStyle
}

enum ContactNameSort {
    case givenName
    case familyName
}
