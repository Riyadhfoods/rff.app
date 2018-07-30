//
//  LeaveDetailsInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class LeaveDetailsInboxViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var numOfDays: UILabel!
    @IBOutlet weak var leaveDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    @IBOutlet weak var requestDate: UILabel!
    @IBOutlet weak var vacationType: UILabel!
    @IBOutlet weak var exitReEntry: UILabel!
    @IBOutlet weak var exitReEntryDays: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    // -- MARK: Variables
    
    var leaveDetailsArrayForVac: LeaveDetails?
    
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
    
    // -- MARK: Setups
    
    func setupCommentView(){
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
    }
    
    func setUpLabels(){
        if let leaveDetailsArrayForVac = leaveDetailsArrayForVac{
            numOfDays.text = leaveDetailsArrayForVac.NumberofDays
            leaveDate.text = leaveDetailsArrayForVac.LeaveStartDate
            returnDate.text = leaveDetailsArrayForVac.ReturnDate
            requestDate.text = leaveDetailsArrayForVac.RequestDate
            vacationType.text = leaveDetailsArrayForVac.VacationType
            exitReEntry.text = leaveDetailsArrayForVac.ExitReEntry
            exitReEntryDays.text = leaveDetailsArrayForVac.ExitReEntryDays
            country.text = leaveDetailsArrayForVac.City
        }
    }

}







