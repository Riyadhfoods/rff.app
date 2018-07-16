//
//  SalesOrderItemDetailsCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderItemDetailsCell: UITableViewCell {

    @IBOutlet weak var serialNo: UILabel!
    @IBOutlet weak var itemNo: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var uofm: UILabel!
    @IBOutlet weak var unitCost: UILabel!
    @IBOutlet weak var exitCost: UILabel!
    @IBOutlet weak var lastYear: UILabel!
    @IBOutlet weak var yearToDate: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
