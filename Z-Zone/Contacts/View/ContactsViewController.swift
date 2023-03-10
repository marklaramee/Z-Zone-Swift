//
//  ContactsViewController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import UIKit
import Contacts

class ContactsViewController: UIViewController {
    
    static func newInstance() -> ContactsViewController {
        let viewController = buildFromStoryboard("Contacts") as ContactsViewController
        return viewController
    }

    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // contactsTest()
        requestAccessForContacts()
    }
    
    private func contactsTest() {
        
        var validContacts: [CNContact] = []
        let contactStore = CNContactStore()

        // Request for contact access
//        contactStore.requestAccessForEntityType(.Contacts) { (granted, e) -> Void in
//
//            if granted {
//
//                do {
//                    // Specify the key fields that you want to be fetched.
//                    // Note: if you didn't specify your specific field request. your app will crash
//                    let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactImageDataKey, CNContactThumbnailImageDataKey])
//
//                    try contactStore.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (contact, error) -> Void in
//
//                        // Lets filter (optional)
//                        if !contact.emailAddresses.isEmpty || !contact.phoneNumbers.isEmpty {
//                            validContacts.append(contact)
//                        }
//                    })
//
//                    print(validContacts)
//                }catch let e as NSError {
//                    print(e)
//                }
//            }
//        }
    }
    
    private func requestAccessForContacts() {
        
        let contactStore = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .denied, .notDetermined:
            contactStore.requestAccess(for: .contacts, completionHandler: { access, error in

                if access {
                    print("super")
                } else {
                    print("problem")
                }
            })
        case .authorized:
            print("ok")
        case .restricted:
            print("restricted")
//        case .notDetermined:
//            <#code#>
//        case .denied:
//            <#code#>
        @unknown default:
            print("default")
        }
    }
}
