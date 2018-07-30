//
//  LoanDetailsInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class LoanDetailsInboxViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var loanType: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amtRequired: UILabel!
    @IBOutlet weak var guarantor: UILabel!
    @IBOutlet weak var paymentPeriod: UILabel!
    @IBOutlet weak var deducatedLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    // -- MARK: Variables
    
    var loanDeatilsForLoan: LoanDetails?
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLabels()
        setViewAlignment()
        setupCommentView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set up

    func setupCommentView(){
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
    }
    
    func setUpLabels(){
        if let loanDeatilsForLoan = loanDeatilsForLoan{
            loanType.text = loanDeatilsForLoan.LoanType
            date.text = loanDeatilsForLoan.CreatedDate
            amtRequired.text = loanDeatilsForLoan.AmountRequired
            guarantor.text = loanDeatilsForLoan.Guarantor_Name
            paymentPeriod.text = loanDeatilsForLoan.PayPeriod
            deducatedLabel.text = "Deduction - \(loanDeatilsForLoan.Monthly_Pay) each month"
        }
    }
}





