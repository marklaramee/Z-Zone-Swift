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
    Do you have numbers in your phone that you can’t delete; but,never want to accidentally call? Like your landlord or an ex?
    
    You need a Z-Zone.

    You create a Z-Zone by adding 3 z’s to the beginning of a contact’s name so they are pushed down to the end of your contacts list.

    When I found out about this I had dozens of contacts to move there.  However, it was a very tedious process.

    The Z-Zone app makes it easy to add and remove contacts from your Z-Zone. Simply go to the contacts screen and click a contact to move it in or out of your Z-Zone. A contact in your Z-Zone will appear with a purple “Z” background. When you leave the app and go to your phone’s contacts, you’ll see that all of your Z-Zone contacts are now safely tucked away at the bottom of the list.
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

        let headerString = NSMutableAttributedString(zString: headerText, size: 36, style: .extraBold, color: UIColor.ZZone.purple, align: .center)
        headerLabel.attributedText = headerString
        
        let bodyString = NSMutableAttributedString(zString: bodyText, size: 18, style: .regular)
        bodyLabel.attributedText = bodyString
    }
}
