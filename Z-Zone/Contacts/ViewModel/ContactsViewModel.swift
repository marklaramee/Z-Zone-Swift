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
    var contacts: BehaviorRelay<[CNContact]?> = BehaviorRelay(value: nil)
    
    init(client: ContactsClient) {
        self.client = client
    }
    
    func getContacts() {
        let staticContacts = client?.getContacts()
        contacts.accept(staticContacts)
    }
}
