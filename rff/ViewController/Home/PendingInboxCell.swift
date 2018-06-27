//
//  PendingInboxCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class PendingInboxCell: UITableViewCell {
    @IBOutlet weak var englishDescriptionLeft: UILabel!
    @IBOutlet weak var arabicDescriptionLeft: UILabel!
    @IBOutlet weak var countLeft: UILabel!
   
    @IBOutlet weak var englishDescriptionRight: UILabel!
    @IBOutlet weak var arabicDescriptionRight: UILabel!
    @IBOutlet weak var countRight: UILabel!
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var viewButton: UIButton!
    
    let language = LoginViewController.languageChosen
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
        setUpHeaderLabel(label: englishDescriptionLeft, language: language)
        setUpHeaderLabel(label: arabicDescriptionLeft, language: language)
        setUpHeaderLabel(label: countLeft, language: language)
        
        setUpHeaderLabel(label: englishDescriptionRight, language: language)
        setUpHeaderLabel(label: arabicDescriptionRight, language: language)
        setUpHeaderLabel(label: countRight, language: language)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
