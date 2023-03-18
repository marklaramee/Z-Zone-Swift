//
//  ContactsClient.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/10/23.
//

import Foundation
import Contacts

class ContactsClient {
    
    static let shared = ContactsClient()
    var sortOrder: ContactNameSort = .familyName
    let store = CNContactStore()
    
    // TODO: convert to async
    // https://developer.apple.com/videos/play/wwdc2021/10194/?time=1290
    
    
    // TODO: make private  - other shared as well
    init() {
        switch (CNContactsUserDefaults.shared().sortOrder) {
        case .familyName:
            sortOrder = .familyName
        case .givenName:
            sortOrder = .givenName
        default:
            ZLogger.shared.logError("Invalid sort order from store.", category: .contactsClient)
        }
    }

    func getContacts(completion: @escaping ([CNContact]?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            do {
                var contacts: [CNContact] = []
                try self.store.enumerateContacts(with: request) { contact, stop in
                    contacts.append(contact)
                }
                completion(contacts)
            } catch {
                completion(nil)
                print("Error retrieving contacts: \(error.localizedDescription)")
            }
        }
    }
    
    func updateContact(_ contact: CNMutableContact) {
        guard sortOrder == .givenName || sortOrder == .familyName else {
            ZLogger.shared.logError("Invalid name sort order.", category: .contactsClient)
            return
        }
        let saveRequest = CNSaveRequest()
        saveRequest.update(contact)
        
        do {
            try store.execute(saveRequest)
            ZLogger.shared.log(level: .info, message: "Contact saved successfully", category: .contactsClient)
        } catch {
            ZLogger.shared.logError("Error saving contact: \(error.localizedDescription)", category: .contactsClient)
        }
    }
}
