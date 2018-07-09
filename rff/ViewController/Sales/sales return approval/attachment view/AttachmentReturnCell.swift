//
//  AttachmentReturnCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 03/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AttachmentReturnCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var filenemeLabel: UILabel!
    @IBOutlet weak var filetypeLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var showAttachmentFile: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCellHolderViewAndCellBackground(holderView: holderView, contentView: contentView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
