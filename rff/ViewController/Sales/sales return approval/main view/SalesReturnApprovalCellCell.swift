//
//  SalesReturnApprovalCellCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesReturnApprovalCellCell: UITableViewCell {

    @IBOutlet weak var returnId: UILabel!
    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var reqDate: UILabel!
    @IBOutlet weak var rtnDate: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellHolderViewAndCellBackground(holderView: holderView, contentView: contentView)
        setViewAlignment()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
