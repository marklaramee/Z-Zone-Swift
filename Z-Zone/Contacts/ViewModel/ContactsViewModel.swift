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
                return ContactModel(firstName: cnContact.givenName, lastName: cnContact.familyName, contact: cnContact)
            }
            self.contactsRelay.accept(model)
        }
        
        
    }
    
    func convertToFullName(_ contact: ContactModel, as asType: ContactNameSort) -> String {
        let firstName = contact.firstName ?? ""
        let lastName = contact.lastName ?? ""
        switch (asType) {
        case .firstNameFirst:
            return "\(firstName) \(lastName)".trimmingCharacters(in: .whitespacesAndNewlines)
        case .lastNameFirst:
            return "\(lastName) \(firstName)".trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}
