//
//  ContactsTestClient.swift
//  Z-ZoneTests
//
//  Created by Mark Laramee on 3/18/23.
//

import Foundation
import Contacts
@testable import Z_Zone

struct TestData {
    var given: String
    var family: String
}

class ContactsTestClient: ContactsClient {
    let zZone = "zzz"
    let testData: [TestData] = [
        TestData(given: "Walter", family: "Hill"),
        TestData(given: "Ian" , family: "Holm"),
        TestData(given: "Harry Dean", family: "Stanton"),
        TestData(given: "Helen", family: "Horton"),
        TestData(given: "Eddie" , family: "Powell"),
        TestData(given: "Gordon", family: "Carroll"),
        TestData(given: "Ivor", family: "Powell"),
        TestData(given: "Derek" , family: "Vanlint"),
        TestData(given: "Michael", family: "Seymour"),
        TestData(given: "Ian", family: "Whittaker"),
        TestData(given: "Jon" , family: "Mollo"),
        TestData(given: "Les", family: "Dilley")
    ]
    var testContactsNormal: [CNContact] = []
    var testContactsZone: [CNContact] = []
    
    func generateContacts(normal: Int, zone: Int) {
        
    }
    
    private func generateContact(given: String, family: String, isZone: Bool, sortOrder: ContactNameSort) -> CNContact {
        guard var mutableContact = CNContact().mutableCopy() as? CNMutableContact else {
            return CNContact()
        }
        mutableContact.givenName = given
        mutableContact.familyName = family
        guard isZone else {
            return mutableContact
        }
        
        switch (sortOrder) {
        case .familyName:
            mutableContact.familyName = "\(zZone)\(mutableContact.familyName)"
        case .givenName:
            mutableContact.givenName = "\(zZone)\(mutableContact.givenName)"
        }
        return mutableContact
    }
}
