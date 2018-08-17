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
    
    var empGeneralInfoArrayForVac: EmployeeGeneralInfo?
    
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
        if let empGeneralInfoArrayForVac = empGeneralInfoArrayForVac{
            empName.text = empGeneralInfoArrayForVac.EmpName
            joinDate.text = empGeneralInfoArrayForVac.JoinDate
            startDate.text = empGeneralInfoArrayForVac.StartDate
            manager.text = empGeneralInfoArrayForVac.ManagerName
            jobDesc.text = empGeneralInfoArrayForVac.JobDesc
            subJobDesc.text = empGeneralInfoArrayForVac.SubJobDesc
            department.text = empGeneralInfoArrayForVac.Department
            nationality.text = empGeneralInfoArrayForVac.Nationality
        }
    }

}





