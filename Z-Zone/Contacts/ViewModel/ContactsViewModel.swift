//
//  ContactsViewModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import Foundation
import UIKit
import Contacts
import RxSwift
import RxRelay

class ContactsViewModel {
    let zZone = "zzz"
    var client: ContactsClient?
    var contactsRelay: BehaviorRelay<[ContactModel]> = BehaviorRelay(value: [])
    var displayType = ContactDisplayType.rawStyle
    
    init(client: ContactsClient) {
        self.client = client
    }
    
    func getContacts() {
        client?.getContacts { results in
            guard let contacts = results else {
                // TODO: error?
                return
            }
            let cnContacts: [CNContact] = contacts
            
            // TODO: do I need to adjust this for other naming styles? maybe use the CnContact prop names
            let model: [ContactModel] = cnContacts.map { cnContact in
                return ContactModel(givenName: cnContact.givenName, familyName: cnContact.familyName, contact: cnContact)
            }
            self.contactsRelay.accept(model)
        }
    }
    
    func convertToFullName(_ contact: ContactModel, as asType: ContactNameSort) -> String {
        let firstName = contact.givenName ?? ""
        let lastName = contact.familyName ?? ""
        switch (asType) {
        case .firstNameFirst:
            return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        case .lastNameFirst:
            return "\(lastName) \(firstName)".trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    func enterZZone(_ contact: ContactModel) {
        var mutableContact = contact
        switch ContactsClient.shared.sortOrder {
        case .familyName:
            guard let name = mutableContact.familyName else {
                return
            }
            mutableContact.familyName = name.prependIfNotPresent(zZone)
        case .givenName:
            guard let name = mutableContact.givenName else {
                return
            }
            mutableContact.givenName = name.prependIfNotPresent(zZone)
        default:
            ZLogger.shared.logError("Invalid name sort order.", category: .contactsViewModel)
            return
        }
        ContactsClient.shared.updateContact(contact)
    }
    
    func leaveZZone(_ contact: ContactModel) {
        
    }
}
