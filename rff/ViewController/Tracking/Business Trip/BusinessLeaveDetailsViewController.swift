//
//  BusinessLeaveDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class BusinessLeaveDetailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var journeyStartDate: UILabel!
    @IBOutlet weak var journeyEndDate: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var businessTripAmount: UILabel!
    @IBOutlet weak var amountDesc: UILabel!
    @IBOutlet weak var reason: UILabel!
    
    // -- MARK: Variables
    
    var businessLeaveDtailsArray = [BusinessTrip_AppModel]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setData(){
        
    }
    
}
