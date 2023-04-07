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
    @IBOutlet weak var bodyLabel: UILabel!
    
    let headerText = "Z-Zone"
    let bodyText = """
    Do you have contacts on your phone that you can't delete, but you don't want to accidentally call them?
    
    You need a Z-Zone.

    You create a Z-Zone by adding 3 z’s to the beginning of a contact’s name so they are pushed down to the end of your contacts list. This can be a tedious process for many contacts.
    
    The Z-Zone app makes this easy.
    
    You can easily move a contact in or out of your Z-Zone by clicking on it in the contacts tab. Z-Zone contacts will be identified with a purple "Z" background. When you leave the app, your Z-Zone contacts will be safely tucked away at the end of the list.

    """
    
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

        let headerString = NSMutableAttributedString(zString: headerText, size: 36, style: .titan, color: UIColor.ZZone.purple, align: .center)
        headerLabel.attributedText = headerString
        
        let bodyString = NSMutableAttributedString(zString: bodyText, size: 16, style: .poppinsRegular)
        bodyLabel.attributedText = bodyString
    }
}
