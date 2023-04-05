//
//  RootTabBarController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 4/3/23.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let firstLoad: Bool = UserStorage.shared.readGlobalValue(forKey: .firstLoad) else {
            UserStorage.shared.saveGlobalValue(forKey: .firstLoad, value: false)
            selectedIndex = 0
            return
        }
        selectedIndex = 1
    }
}
