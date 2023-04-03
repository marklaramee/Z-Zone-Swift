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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // TODO: delete
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ contact: ContactModel) {
        let nameString = NSMutableAttributedString(zString: contact.fullName, size: 18, style: .regular)
        nameLabel.attributedText = nameString
        
        if contact.isZZone {
            zImageView.isHidden = false
        } else {
            zImageView.isHidden = true
        }
    }

}
