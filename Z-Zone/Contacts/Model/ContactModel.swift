//
//  ContactsModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/10/23.
//

import Foundation
import Contacts

// TODO: remove nillable?
struct ContactModel {
    var givenName: String
    var familyName: String
    var fullName: String
    var contact: CNContact
}

// TODO: remove?
enum ContactDisplayType {
    case rawStyle
    case zStyle
}

// TODO: use store
enum ContactNameSort {
    case firstNameFirst
    case lastNameFirst
}
