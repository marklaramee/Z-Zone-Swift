//
//  RawStyleTableViewCell.swift
//  Z-Zone
//
//  Created by Mark Laramee on 3/11/23.
//

import UIKit

class RawStyleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
