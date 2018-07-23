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
    
    
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
