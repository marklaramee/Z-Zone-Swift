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
    
    func getContacts() -> [CNContact] {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        let store = CNContactStore()
        // TODO: change format
        var contacts = [CNContact]()
        
        do {
            
            // TODO: put on qos thread
            try store.enumerateContacts(with: request) { contact, stop in
                contacts.append(contact)
            }
        } catch {
            print("Error retrieving contacts: \(error.localizedDescription)")
        }
        
        return contacts
    }
    
    // TODO:
    func editContact(contact: CNContact, newLastName: String) {
        // Create a mutable copy of the contact
        let mutableContact = contact.mutableCopy() as! CNMutableContact
        
        // Set the new last name
        mutableContact.familyName = newLastName
        
        // Save the edited contact to the contact store
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.update(mutableContact)
        
        do {
            try store.execute(saveRequest)
            print("Contact saved successfully")
        } catch {
            print("Error saving contact: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    
    
    // for reference
    
    // https://stackoverflow.com/questions/33973574/fetching-all-contacts-in-ios-swift
    
    //https://stackoverflow.com/questions/34178229/how-to-get-contact-firstname-lastname-contactid-number
    
    
    func getFNLNContacts() -> [(firstName: String, lastName: String)] {
        var contacts: [(firstName: String, lastName: String)] = []
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        let store = CNContactStore()
        
        // TODO: dispatch on qos thread
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                let firstName = contact.givenName
                let lastName = contact.familyName
                contacts.append((firstName, lastName))
            }
        } catch {
            print("Error retrieving contacts: \(error.localizedDescription)")
        }
        
        return contacts
    }
    
    let contactStore = CNContactStore()
    let keysToFetch = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey,
        CNContactThumbnailImageDataKey] as [Any]
    
    func oldGetContacts() {
        print("ML: get contacts")
        
        findContactsOnBackgroundThread() { contacts in
            print("got contacst")
        }
        
//        var validContacts: [CNContact] = []
//        let contactStore = CNContactStore()
//
//
//        do {
//            let keys: [CNKeyDescriptor] = [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactThumbnailImageDataKey]
//            // Specify the key fields that you want to be fetched.
//            // Note: if you didn't specify your specific field request. your app will crash
//            let fetchRequest: CNContactFetchRequest = CNContactFetchRequest(keysToFetch: keys)
//
//            try contactStore.enumerateContacts(with: fetchRequest, usingBlock: { (contact, error) -> Void in
//
//                // Lets filter (optional)
//                if !contact.emailAddresses.isEmpty || !contact.phoneNumbers.isEmpty {
//                    validContacts.append(contact)
//                }
//            })
//
//            print(validContacts)
//        }catch let e as NSError {
//            print(e)
//        }
    }
    
    func findContactsOnBackgroundThread ( completion: @escaping ([CNContact]?)-> Void) {
        
        // maybe change to qos background
        DispatchQueue.main.async {
            
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactPhoneNumbersKey] //CNContactIdentifierKey
            // let fetchRequest = CNContactFetchRequest( keysToFetch: keysToFetch)
//                            var contacts = [CNContact]()
//                            CNContact.localizedStringForKey(CNLabelPhoneNumberiPhone)
//
//                            fetchRequest.mutableObjects = false
//                            fetchRequest.unifyResults = true
//                            fetchRequest.sortOrder = .UserDefault
//
//                            let contactStoreID = CNContactStore().defaultContainerIdentifier()
//                            print("\(contactStoreID)")
            

//                        do {
//
//                            try CNContactStore().enumerateContactsWithFetchRequest(fetchRequest) { (contact, stop) -> Void in
//                                //do something with contact
//                                if contact.phoneNumbers.count > 0 {
//                                    contacts.append(contact)
//                                }
//
//                            }
//                        } catch let e as NSError {
//                            print(e.localizedDescription)
//                        }
//
//                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                            completionHandler(contacts: contacts)
//
//                        })
            
            
            completion(nil)
        }
    }
    
}
