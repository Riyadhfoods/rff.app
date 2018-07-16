//
//  SalesItemDetailsCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesItemDetailsCell: UITableViewCell {
    
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var InvoiceNo: UILabel!
    @IBOutlet weak var LOTNo: UILabel!
    @IBOutlet weak var ItemNo: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var uofm: UILabel!
    @IBOutlet weak var invoiceDate: UILabel!
    @IBOutlet weak var returnType: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
    }
    
}
