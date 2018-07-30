//
//  SalesWorkFlowCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesWorkFlowCell: UITableViewCell {
    
    @IBOutlet weak var empID: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empRole: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var transDate: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
    }
}
