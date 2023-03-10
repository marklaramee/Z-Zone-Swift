//
//  ContactsViewController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import UIKit

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
    }
}
