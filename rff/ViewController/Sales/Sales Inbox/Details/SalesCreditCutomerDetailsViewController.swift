//
//  SalesCreditCutomerDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesCreditCutomerDetailsViewController: UIViewController {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var creditLimit: UILabel!
    @IBOutlet weak var totalDue: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var customerCreditDetailsArray = [SalesReturn]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpData(){
        for customerCredit in customerCreditDetailsArray{
            customerName.text = customerCredit.SRI_CustomerName
            creditLimit.text = customerCredit.SRI_CreditLimit
            totalDue.text = customerCredit.SRI_TotalDue
            status.text = customerCredit.SRI_Status
        }
    }

}
