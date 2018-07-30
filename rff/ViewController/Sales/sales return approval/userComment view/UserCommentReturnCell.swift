//
//  UserCommentReturnCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class UserCommentReturnCell: UITableViewCell {

    @IBOutlet weak var empNameReturn: UILabel!
    @IBOutlet weak var commentReturn: UILabel!
    @IBOutlet weak var holderViewReturn: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellHolderViewAndCellBackground(holderView: holderViewReturn, contentView: contentView)
        setViewAlignment()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
