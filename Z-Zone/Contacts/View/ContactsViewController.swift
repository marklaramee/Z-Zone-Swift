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
    
    @IBOutlet weak var contactsTableView: UITableView!
    
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
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        requestAccessForContacts()
    
        viewModel.contactsRelay.asObservable().subscribe(onNext: { [weak self] contactsArray in
            self?.contacts = contactsArray
            DispatchQueue.main.async {
                self?.contactsTableView.reloadData()
            }
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

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? RawStyleTableViewCell else {
//            return
//        }

        // TODO: handle order tapped
        guard let contact = viewModel.contactsRelay.value[safe: indexPath.row] else {
            ZLogger.shared.logError(message: "Could not get contact", category: .contacts)
            return
        }
        
        viewModel.enterZZone(contact)
    }
}

// MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RawStyleTableViewCell", for: indexPath) as? RawStyleTableViewCell else {
            return UITableViewCell()
        }
        
        guard let contact = contacts[safe: indexPath.row] else {
            // TODO: log
            return UITableViewCell()
        }
        
        let nameString = viewModel.convertToFullName(contact, as: .firstNameFirst)
        cell.set(nameString)
        
        return cell
    }
}
