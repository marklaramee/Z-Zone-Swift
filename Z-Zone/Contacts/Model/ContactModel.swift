//
//  ContactsModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/10/23.
//

import Foundation
import Contacts

struct ContactModel {
    var givenName: String?
    var familyName: String?
    var contact: CNContact
}

enum ContactDisplayType {
    case rawStyle
    case zStyle
}

enum ContactNameSort {
    case firstNameFirst
    case lastNameFirst
}
