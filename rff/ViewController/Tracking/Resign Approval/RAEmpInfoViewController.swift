//
//  RAEmpInfoViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class RAEmpInfoViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var jobDescLabel: UILabel!
    @IBOutlet weak var subJobLabel: UILabel!
    @IBOutlet weak var basicSalaryLabel: UILabel!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var workHrsLabel: UILabel!
    @IBOutlet weak var absentDaysLabel: UILabel!
    
    // -- MARK: Variables
    
    var savedEmpDetailsArray = [ResignEmpDetailsModul]()
    var empDetailsArray = [ResignEmpDetailsModul]()
    
    // -- MARK: View kife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Setups
    
    func setUpData(){
        for emp in empDetailsArray{
            nameLabel.text = emp.Employee_Name
            managerLabel.text = emp.MGR_Name
            deptLabel.text = emp.Dept_Name
            nationalityLabel.text = emp.Nationality
            joinDateLabel.text = emp.Join_Date
            startDateLabel.text = emp.Start_Date
            jobDescLabel.text = emp.Job_Desc
            subJobLabel.text = emp.Sub_Job_Desc
            basicSalaryLabel.text = emp.Basic_Salary
            packageLabel.text = emp.Package
            companyLabel.text = emp.Compnay
        }
        for savedemp in savedEmpDetailsArray{
            workHrsLabel.text = savedemp.Work_Hrs
            absentDaysLabel.text = savedemp.Absent_Days
        }
    }
    
    
}
