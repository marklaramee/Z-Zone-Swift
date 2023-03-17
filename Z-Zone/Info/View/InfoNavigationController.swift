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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
