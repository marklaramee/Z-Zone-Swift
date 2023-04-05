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
        let nameString = NSMutableAttributedString(zString: contact.fullName, size: 18, style: .almaraiRegular)
        nameLabel.attributedText = nameString
        
        if contact.isZZone {
            zImageView.isHidden = false
        } else {
            zImageView.isHidden = true
        }
    }

}
