//
//  ContactsViewModel.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import Foundation
import Contacts

class ContactsViewModel {
    // https://stackoverflow.com/questions/33973574/fetching-all-contacts-in-ios-swift
    
    //https://stackoverflow.com/questions/34178229/how-to-get-contact-firstname-lastname-contactid-number
    
    
    
    
    let contactStore = CNContactStore()
    let keysToFetch = [
        CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey,
        CNContactThumbnailImageDataKey] as [Any]
    
    
}
