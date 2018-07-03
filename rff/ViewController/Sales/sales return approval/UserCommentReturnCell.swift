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
        holderViewReturn.layer.cornerRadius = 5.0
        holderViewReturn.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderViewReturn.layer.borderWidth = 1
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
