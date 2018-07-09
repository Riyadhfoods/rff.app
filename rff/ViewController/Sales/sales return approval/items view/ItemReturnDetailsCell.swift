//
//  ItemReturnDetailsCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemReturnDetailsCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var invoiceNo: UILabel!
    @IBOutlet weak var lotNo: UILabel!
    @IBOutlet weak var itemNo: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var unitePRice: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var uofm: UILabel!
    @IBOutlet weak var returnType: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellHolderViewAndCellBackground(holderView: holderView, contentView: contentView)
        
        checkBoxBtn.layer.cornerRadius = 39/2
        checkBoxBtn.layer.borderWidth = 1
        checkBoxBtn.layer.borderColor = AppDelegate().mainBackgroundColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
