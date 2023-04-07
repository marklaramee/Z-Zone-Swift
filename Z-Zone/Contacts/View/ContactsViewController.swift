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
    let cellHeight: CGFloat = 36
    
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    // localization
    let headerText = "Contacts"
    let errorText = "Contacts unavailable due to permissions error."
    
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
        
        let headerString = NSMutableAttributedString(
            zString: headerText, size: 24, style: .almaraiBold, color: UIColor.ZZone.purple ,isAllCaps: true)
        headerLabel.attributedText = headerString
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsTableView.layoutMargins = UIEdgeInsets.zero
        contactsTableView.separatorInset = UIEdgeInsets.zero
        
        requestAccessForContacts()
    
        viewModel.contactsRelay.asObservable().subscribe(onNext: { [weak self] contactsArray in
            self?.contacts = contactsArray
            DispatchQueue.main.async {
                self?.contactsTableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.permissionsIssue {
            requestAccessForContacts()
        }
    }
    
    private func requestAccessForContacts() {
        
        let contactStore = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts, completionHandler: { access, error in
                if access {
                    self.viewModel.permissionsIssue = false
                    self.viewModel.getContacts()
                } else {
                    self.viewModel.permissionsIssue = true
                    self.manualPermissionInstuctions()
                }
            })
        case .authorized:
            self.viewModel.permissionsIssue = false
            viewModel.getContacts()
        case .restricted:
            self.viewModel.permissionsIssue = true
            manualPermissionInstuctions()
        case .denied:
            self.viewModel.permissionsIssue = true
            manualPermissionInstuctions()
        @unknown default:
            self.viewModel.permissionsIssue = true
            displayError()
        }
    }
    
    private func displayError() {
        DispatchQueue.main.async {
            self.contactsTableView.isHidden = true
            self.errorLabel.isHidden = false
            let errorString = NSMutableAttributedString(zString: self.errorText, size: 24, style: .almaraiRegular, align: .center)
            self.errorLabel.attributedText = errorString
        }
    }
    
    private func manualPermissionInstuctions() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: "Contacts Permission Needed",
                message: "Please enable contacts access in your phone's setting to use this app.",
                preferredStyle: .alert
            )

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }

                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
            alertController.addAction(settingsAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) 
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        displayError()
    }
}

// MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard var contact = viewModel.contactsRelay.value[safe: indexPath.row] else {
            ZLogger.shared.logError("Could not get contact", category: .contactsViewController)
            return
        }
        
        switch(contact.isZZone) {
        case true:
            viewModel.leaveZZone(&contact)
        case false:
            viewModel.enterZZone(&contact)
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ZStyleTableViewCell", for: indexPath) as? ZStyleTableViewCell else {
            return UITableViewCell()
        }
        
        guard let contact = contacts[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.layoutMargins = UIEdgeInsets.zero
        cell.set(contact)
        
        return cell
    }
}
