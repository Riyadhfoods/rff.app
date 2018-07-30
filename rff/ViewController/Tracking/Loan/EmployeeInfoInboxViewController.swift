//
//  EmployeeInfoInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class EmployeeInfoInboxViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var department: UILabel!
    @IBOutlet weak var nationality: UILabel!
    @IBOutlet weak var jobDesc: UILabel!
    @IBOutlet weak var subJob: UILabel!
    @IBOutlet weak var basicSalary: UILabel!
    @IBOutlet weak var package: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var manager: UILabel!
    @IBOutlet weak var joinDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    
    // -- MARK: Variables
    
    var empInfoForLoan: EmployeeDetails?
    
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
    
    // -- MARK: Set up
    
    func setupCommentView(){
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
    }
    
    func setUpLabels(){
        if let empInfoForLoan = empInfoForLoan {
            empName.text = empInfoForLoan.Emp_Name
            department.text = empInfoForLoan.Department
            nationality.text = empInfoForLoan.Nationality
            jobDesc.text = empInfoForLoan.Job_Desc
            subJob.text = empInfoForLoan.Sub_JobDesc
            basicSalary.text = empInfoForLoan.Basic_Sal
            package.text = empInfoForLoan.Package
            company.text = empInfoForLoan.Company
            manager.text = empInfoForLoan.Manager
            joinDate.text = empInfoForLoan.Join_Date
            startDate.text = empInfoForLoan.Start_Date
        }
    }
    
}




