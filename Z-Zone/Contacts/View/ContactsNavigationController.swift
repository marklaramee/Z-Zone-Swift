//
//  ContactsNavigationController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import UIKit

class ContactsNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let startVC = ContactsViewController.newInstance()
        self.viewControllers = [startVC]
    }

}
