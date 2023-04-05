//
//  InfoNavigationController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

import UIKit

class InfoNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let startVC = InfoViewController.newInstance()
        self.viewControllers = [startVC]
    }
}
