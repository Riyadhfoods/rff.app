//
//  InboxTableViewCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 27/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxTableViewCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var InnerHolderView: UIView!
    @IBOutlet weak var empIdEnglish: UILabel!
    @IBOutlet weak var empNameEnglish: UILabel!
    @IBOutlet weak var dateEnglish: UILabel!
    @IBOutlet weak var viewForm: UIButton!
    
    @IBOutlet weak var empIdArabic: UILabel!
    @IBOutlet weak var empNameArabic: UILabel!
    @IBOutlet weak var dateArabic: UILabel!
    @IBOutlet weak var titlesStackViewWidth: NSLayoutConstraint!
    
    let language = LoginViewController.languageChosen
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
