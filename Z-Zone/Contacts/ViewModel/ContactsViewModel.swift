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
            
            let model: [ContactModel] = cnContacts.compactMap { cnContact in
                guard let fullName = self.convertToFullName(cnContact) else {
                    return nil
                }
                
                var isZone = false;
                switch(ContactsClient.shared.sortOrder) {
                case .familyName:
                    isZone = cnContact.familyName.hasPrefix(self.zZone)
                case .givenName:
                    isZone = cnContact.givenName.hasPrefix(self.zZone)
                }
                
                return ContactModel(givenName: cnContact.givenName, familyName: cnContact.familyName, fullName: fullName, contact: cnContact, isZZone: isZone)
            }
            self.contactsRelay.accept(model)
        }
    }
    
    func enterZZone(_ contactModel: inout ContactModel) {
        guard !contactModel.isZZone, let mutableContact = contactModel.contact.mutableCopy() as? CNMutableContact else {
            // ZLogger.shared.logError("Could not get mutable contact.", category: .contactsViewModel)
            return
        }
        switch ContactsClient.shared.sortOrder {
        case .familyName:
            mutableContact.familyName = mutableContact.familyName .prependIfNotPresent(zZone)
        case .givenName:
            mutableContact.givenName = mutableContact.givenName.prependIfNotPresent(zZone)
        }
        ContactsClient.shared.updateContact(mutableContact)
        
        contactModel.isZZone = true
        contactModel.contact = mutableContact
        
        // update the behavior relay
        var contacts = contactsRelay.value
        if let index = contacts.firstIndex(where: { $0.contact ==== contactModel.contact }) {
            contacts[index] = contactModel
        }
        contactsRelay.accept(contacts)
        
    }
    
    func leaveZZone(_ contact: ContactModel) {
        
    }
    
    private func convertToFullName(_ contact: CNContact) -> String? {
        switch (ContactsClient.shared.sortOrder) {
        case .familyName:
            return "\(contact.familyName) \(contact.givenName)".trimmingCharacters(in: .whitespacesAndNewlines)
        case .givenName:
            return "\(contact.givenName) \(contact.familyName)".trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
