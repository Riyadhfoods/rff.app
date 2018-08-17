//
//  TravelMembershipViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class TravelMembershipViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var meetAndAssistance: UILabel!
    @IBOutlet weak var luggageAndCargo: UILabel!
    @IBOutlet weak var AirLines: UILabel!
    @IBOutlet weak var membershipCardNo: UILabel!
    @IBOutlet weak var others: UILabel!
    
    // -- MARK: Variables
    
    var travelMenebershipArray = [BusinessTrip_AppModel]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setUpData(){
        
    }
}
