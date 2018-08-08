//
//  CustomerCreditDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CustomerCreditDetailsViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var customerId: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var creditLimitRight: UILabel!
    @IBOutlet weak var totalDueRight: UILabel!
    @IBOutlet weak var upTo31Right: UILabel!
    @IBOutlet weak var upTo60Right: UILabel!
    @IBOutlet weak var upTo90Right: UILabel!
    @IBOutlet weak var upTo120Right: UILabel!
    @IBOutlet weak var moreThan90Right: UILabel!
    @IBOutlet weak var statusRight: UILabel!
    
    // -- MARK: Variables
    
    var orderId = ""
    var customerCreditDetailsArray = [OrderApproveCreditModul]()
    
    // -- MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cutomer Credit Details"
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
        setUpData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpData(){
        //customerCreditDetailsArray = webservice.BindCustomerCreditGridView_SalesApprovalForm(ordernumber: orderId)
        for customerCredit in customerCreditDetailsArray{
            customerId.text = customerCredit.CUSTOMERID
            customerName.text = customerCredit.CUSTOMERNAME
            creditLimitRight.text = customerCredit.CREDITLIMIT
            totalDueRight.text = customerCredit.TOTALDUE
            upTo31Right.text = customerCredit.ZEROTOTHIRYONEDAYS
            upTo60Right.text = customerCredit.THIRYONETOSIXTYDAYS
            upTo90Right.text = customerCredit.SIXTYONETONINETYDAYS
            upTo120Right.text = customerCredit.NINETYONETOHUNDREDTWENTYDAYS
            moreThan90Right.text = customerCredit.ABOVE120DAYS
            statusRight.text = customerCredit.STATUS
        }
    }
}













