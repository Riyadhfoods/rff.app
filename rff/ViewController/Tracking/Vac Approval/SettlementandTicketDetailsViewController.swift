//
//  SettlementandTicketDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SettlementandTicketDetailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var settlementAmount: UILabel!
    @IBOutlet weak var ticketReqAmount: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    // -- MARK: Variables
    
    var settlementTicketDetailsArrayForVac: SettlementAndTicketDetails?
    
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
    
    // -- MARK: Set ups
    
    func setupCommentView(){
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
    }
    
    func setUpLabels(){
        if let settlementTicketDetailsArrayForVac = settlementTicketDetailsArrayForVac{
            settlementAmount.text = settlementTicketDetailsArrayForVac.Total_SettlementAmount
            ticketReqAmount.text = settlementTicketDetailsArrayForVac.TicketRequired
        }
    }

}





