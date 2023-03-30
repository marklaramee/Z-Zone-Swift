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
    
    func testEnterZone_updates() throws {
        testClient.generateContacts(normal: 1, zone: 0)
        let validation: TestData = testClient.testData[0]
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            var model = models![0]
            viewModel.enterZZone(&model)
            let zoneModels: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            let zoneModel = zoneModels![0]
            XCTAssert(zoneModel.fullName == model.fullName)
            XCTAssert(zoneModel.contact.familyName == "\(testClient.zZone)\(validation.family)")
        } catch {
            XCTAssert(false)
        }
    }
    
    func testEnterZone_doesNotUpdaate() throws {
        testClient.generateContacts(normal: 0, zone: 1)
        let validation: TestData = testClient.testData[0]
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            var model = models![0]
            viewModel.enterZZone(&model)
            let zoneModels: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            let zoneModel = zoneModels![0]
            XCTAssert(zoneModel.fullName == model.fullName)
            XCTAssert(zoneModel.contact.familyName == "\(testClient.zZone)\(validation.family)")
        } catch {
            XCTAssert(false)
        }
    }
    
    func testLeaveZone_updates() throws {
        testClient.generateContacts(normal: 0, zone: 1)
        let validation: TestData = testClient.testData[0]
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            var model = models![0]
            viewModel.leaveZZone(&model)
            let zoneModels: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            let zoneModel = zoneModels![0]
            XCTAssert(zoneModel.fullName == model.fullName)
            XCTAssert(zoneModel.contact.familyName == validation.family)
        } catch {
            XCTAssert(false)
        }
    }
    
    // TODO: possibly delete or change this. Not sure it tests anything
    func testLeaveZone_doesNotUpdate() throws {
        testClient.generateContacts(normal: 1, zone: 0)
        let validation: TestData = testClient.testData[0]
        viewModel.getContacts()
        do {
            let models: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            var model = models![0]
            viewModel.leaveZZone(&model)
            let zoneModels: [ContactModel]? = try viewModel.contactsRelay.toBlocking().first()
            let zoneModel = zoneModels![0]
            XCTAssert(zoneModel.fullName == model.fullName)
            XCTAssert(zoneModel.contact.familyName == validation.family)
        } catch {
            XCTAssert(false)
        }
    }

}
