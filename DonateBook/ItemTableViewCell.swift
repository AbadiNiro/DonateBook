//
//  ItemTableViewCell.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
