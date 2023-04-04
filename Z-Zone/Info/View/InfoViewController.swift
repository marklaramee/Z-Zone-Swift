//
//  InfoViewController.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/9/23.
//

// https://useyourloaf.com/blog/scroll-view-layouts-with-interface-builder/

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    
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

        let headerText = "Z-Zone"
        let headerString = NSMutableAttributedString(zString: headerText, size: 36, style: .extraBold, color: UIColor.ZZone.purple, align: .center)
        headerLabel.attributedText = headerString
    }
}
