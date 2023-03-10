//
//  ContactsModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/10/23.
//

import Foundation
import Contacts

struct ContactModel {
    var firstName: String?
    var lastName: String?
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
