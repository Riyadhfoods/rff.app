//
//  WorkFlowReturnCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class WorkFlowReturnCell: UITableViewCell {

    @IBOutlet weak var empId: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empRole: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var transDate: UILabel!
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
