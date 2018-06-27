//
//  OrderStyleCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class OrderStyleCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var idTitle: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var empCreatedTitle: UILabel!
    @IBOutlet weak var empCreatedLabel: UILabel!
    @IBOutlet weak var custNameTitle: UILabel!
    @IBOutlet weak var custNameLabel: UILabel!
    @IBOutlet weak var itemsTitle: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var statusTitle: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pendingByTitle: UILabel!
    @IBOutlet weak var pendingByLabel: UILabel!
    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var viewOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        contentView.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        changeBoldFontAndColor(labelLeft: statusTitle, labelRight: statusLabel, langauge: LoginViewController.languageChosen)
        
        setUpHeaderLabel(label: idTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: idLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: custNameTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: custNameLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: empCreatedTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: empCreatedLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: dateTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: dateLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: itemsTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: itemsLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: statusTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: statusLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: pendingByTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: pendingByLabel, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: commentTitle, language: LoginViewController.languageChosen)
        setUpHeaderLabel(label: commentLabel, language: LoginViewController.languageChosen)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
