//
//  UploadedFileCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class UploadedFileCell: UITableViewCell {

    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var viewFile: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellHolderViewAndCellBackground(holderView: holderView, contentView: contentView)
        viewFile.layer.cornerRadius = 1
        
        setViewAlignment()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
