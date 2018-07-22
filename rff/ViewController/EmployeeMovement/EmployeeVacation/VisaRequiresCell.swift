//
//  VisaRequiresCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 14/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class VisaRequiresCell: UITableViewCell {
    
    @IBOutlet weak var selectorVisaYes: UIView!
    @IBOutlet weak var selectorVisaNo: UIView!
    @IBOutlet weak var innerSelectorVisaYes: UIView!
    @IBOutlet weak var innerSelectorVisaNo: UIView!
    @IBOutlet weak var visaYesButton: UIButton!
    @IBOutlet weak var visaNoButton: UIButton!
    
    @IBOutlet weak var holderView: UIView!
        
    @IBOutlet weak var ticketNumber: UILabel!
    @IBOutlet weak var dependentNameRight: UILabel!
    
    
    let langauge = LoginViewController.languageChosen
    
    // 0 --> No , 1 --> Yes
    var requiredVisaSelected: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func visaYesButtonTapped(_ sender: Any) {
        visaYesButton.backgroundColor = mainBackgroundColor
        visaNoButton.backgroundColor = .white
    }

    @IBAction func visaNoButtonTapped(_ sender: Any) {
        visaYesButton.backgroundColor = .white
        visaNoButton.backgroundColor = mainBackgroundColor
    }
    
    
    

}
