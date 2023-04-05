//
//  ZStyleTableViewCell.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/11/23.
//

import UIKit

class ZStyleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var zImageView: UIImageView!
    
    func set(_ contact: ContactModel) {
        let nameString: NSMutableAttributedString
        if contact.isZZone {
            nameString = NSMutableAttributedString(zString: contact.fullName, size: 18, style: .poppinsSemiBold)
            zImageView.isHidden = false
        } else {
            nameString = NSMutableAttributedString(zString: contact.fullName, size: 18, style: .poppinsRegular)
            zImageView.isHidden = true
        }
        nameLabel.attributedText = nameString
    }

}
