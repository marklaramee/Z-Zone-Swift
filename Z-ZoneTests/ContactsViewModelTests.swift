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

    func testGetContacts_hasCorrectDisplayName_normal() throws {
        testClient.generateContacts(normal: 1, zone: 0)
        let validation: TestData = testClient.testData[0]
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            let model = models![0]
            XCTAssert(model.contact.familyName == validation.family)
            XCTAssert(model.fullName == "\(validation.family), \(validation.given)")
        } catch {
            XCTAssert(false)
        }
    }
    
    func testGetContacts_hasCorrectDisplayName_zZone() throws {
        testClient.generateContacts(normal: 0, zone: 1)
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
    
    func testGetContacts_sortOrder() throws {
        testClient.generateContacts(normal: 2, zone: 2)
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            XCTAssert(models![0].fullName == "Hill, Walter")
            XCTAssert(models![4].fullName == "Stanton, Harry Dean")
        } catch {
            XCTAssert(false)
        }
    }

}
