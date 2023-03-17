//
//  InfoViewController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

// https://useyourloaf.com/blog/scroll-view-layouts-with-interface-builder/

import UIKit

class InfoViewController: UIViewController {
    
    static func newInstance() -> InfoViewController {
        let viewController = buildFromStoryboard("Info") as InfoViewController
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
