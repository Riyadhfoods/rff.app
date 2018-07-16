//
//  ReturnPagesCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnPagesCell: UITableViewCell {
    
    @IBOutlet weak var firstPage: UIButton!
    @IBOutlet weak var previousPage: UIButton!
    @IBOutlet weak var nextPage: UIButton!
    @IBOutlet weak var lastPage: UIButton!
    @IBOutlet weak var pageNum: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    let cornerRadius: CGFloat = 35/2
    let borderColor = AppDelegate().mainBackgroundColor
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = borderColor.cgColor
        holderView.layer.borderWidth = 1
        contentView.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
