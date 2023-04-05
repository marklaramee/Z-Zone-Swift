//
//  ContactsModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/10/23.
//

import Foundation
import Contacts

struct ContactModel: Equatable {
    var fullName: String
    var contact: CNContact
    var isZZone: Bool
}

enum ContactNameSort {
    case givenName
    case familyName
}
