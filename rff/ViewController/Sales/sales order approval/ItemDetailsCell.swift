//
//  ItemDetailsCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemDetailsCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var changePrice: UILabel!
    @IBOutlet weak var orgPrice: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var uofm: UILabel!
    @IBOutlet weak var lastYearORDQty: UILabel!
    @IBOutlet weak var yearToDateORDQty: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
        checkBoxBtn.layer.cornerRadius = 39/2
        checkBoxBtn.layer.borderWidth = 1
        checkBoxBtn.layer.borderColor = AppDelegate().mainBackgroundColor.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
