//
//  Z_ZoneTests.swift
//  Z-ZoneTests
//
//  Created by Mark Laramee on 1/14/23.
//

import XCTest
import Contacts
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
        let validation = testClient.testData[0]
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
