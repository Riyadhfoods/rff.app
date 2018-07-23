//
//  EmployeeGeneralInformationInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class EmployeeGeneralInformationInboxViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var joinDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var manager: UILabel!
    @IBOutlet weak var jobDesc: UILabel!
    @IBOutlet weak var subJobDesc: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var nationality: UILabel!
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
