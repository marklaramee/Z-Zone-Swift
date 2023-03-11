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
    var contacts: BehaviorRelay<[ContactModel]> = BehaviorRelay(value: [])
    var displayType = ContactDisplayType.rawStyle
    
    init(client: ContactsClient) {
        self.client = client
    }
    
    func getContacts() {
        guard let strongClient = client else {
            return
        }
        let cnContacts = strongClient.getContacts()
        
        let model: [ContactModel] = cnContacts.map { cnContact in
            return ContactModel(firstName: "FirstName", lastName: "LastName", contact: cnContact)
        }
        contacts.accept(model)
    }
    
    func convertToFullName(_ contact: ContactModel, as: ContactNameSort) -> String {
        // TODO: implement
        return "First Lastname"
    }
}
