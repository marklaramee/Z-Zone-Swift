//
//  Z_ZoneTests.swift
//  Z-ZoneTests
//
//  Created by Mark Laramee on 1/14/23.
//

import Foundation
import XCTest
import Contacts
import RxBlocking
@testable import Z_Zone

final class ContactsViewModelTests: XCTestCase {
    var testClient: ContactsTestClient!
    var viewModel: ContactsViewModel!

    override func setUp()  {
        testClient = ContactsTestClient()
        viewModel = ContactsViewModel(client: testClient)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetContacts_HasCorrectDisplayNameFamily() throws {
        testClient.generateContacts(normal: 0, zone: 1, sortOrder: .familyName)
        let validation: TestData = testClient.testData[0]
        let zoneValidation = "\(testClient.zZone)\(validation.family)"
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            let model = models![0]
            XCTAssert(model.contact.familyName == zoneValidation)
            XCTAssert(model.fullName == "\(validation.family), \(validation.given)")
        } catch {
            XCTAssert(false)
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
