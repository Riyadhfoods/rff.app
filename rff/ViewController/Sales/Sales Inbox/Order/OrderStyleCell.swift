//
//  OrderStyleCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class OrderStyleCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var empCreatedLabel: UILabel!
    @IBOutlet weak var custNameLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pendingByLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var viewOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        contentView.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
