//
//  ContactsViewController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import UIKit
import Contacts
import RxSwift

class ContactsViewController: UIViewController {
    
    let viewModel = ContactsViewModel(client: ContactsClient.shared)
    var contacts: [ContactModel] = []
    let disposeBag = DisposeBag()
    
    
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
        requestAccessForContacts()
        
        viewModel.contacts.asObservable().subscribe(onNext: { [weak self] contactsArray in
            self?.contacts = contactsArray
        }).disposed(by: disposeBag)
    }
    
    private func requestAccessForContacts() {
        
        let contactStore = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts, completionHandler: { access, error in
                if access {
                    self.viewModel.getContacts()
                } else {
                    self.handleError()
                }
            })
        case .authorized:
            viewModel.getContacts()
        case .restricted:
            manualPermissionInstuctions()
        case .denied:
            manualPermissionInstuctions()
        @unknown default:
            handleError()
        }
    }
    
    // TODO: implement
    private func handleError() {
        print("handle error")
    }
    
    // TODO: implement
    private func manualPermissionInstuctions() {
        print("manual permissions")
    }
}
