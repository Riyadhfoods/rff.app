//
//  SalesOrderApprovalCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderApprovalCell: UITableViewCell {

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
