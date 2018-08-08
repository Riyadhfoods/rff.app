//
//  CustomerAgingViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CustomerAgingViewController: UIViewController {

    // -- MARK: IBOutlet
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var creditLimitRight: UILabel!
    @IBOutlet weak var totalDueRight: UILabel!
    @IBOutlet weak var upTo31Right: UILabel!
    @IBOutlet weak var upTo60Right: UILabel!
    @IBOutlet weak var upTo90Right: UILabel!
    @IBOutlet weak var upTo120Right: UILabel!
    @IBOutlet weak var moreThan90Right: UILabel!
    @IBOutlet weak var statusRight: UILabel!
    
    // -- MARK: Variable
    
    let screenSize = AppDelegate.shared.screenSize
    var customerCreditDetailsArray = [ReturnApproveCreditModul]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cutomer Aging".localize()
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
            creditLimitRight.text = customerCredit.CreditLimit
            totalDueRight.text = customerCredit.TotalDue
            upTo31Right.text = customerCredit.ZeroTo31Days
            upTo60Right.text = customerCredit.ThirtyOneto60Days
            upTo90Right.text = customerCredit.SixtyOneTo90Days
            upTo120Right.text = customerCredit.Nineoneto120Days
            moreThan90Right.text = customerCredit.Above120Days
            statusRight.text = customerCredit.Status
        }
    }
}
