//
//  SalesOrderCreditDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderCreditDetailsViewController: UIViewController {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var creditLimit: UILabel!
    @IBOutlet weak var totalDue: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
