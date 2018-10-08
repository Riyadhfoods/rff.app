//
//  IODEmpDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 03/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class IODEmpDetailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mgrLabel: UILabel!
    @IBOutlet weak var deptLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var jobDescLabel: UILabel!
    @IBOutlet weak var subJobLabel: UILabel!
    @IBOutlet weak var basicSalayLabel: UILabel!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var workHrsLabel: UILabel!
    @IBOutlet weak var absentLabel: UILabel!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    var empDetailsArray = [Emp_Details_Modul]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    func setUpData(){
        for emp in empDetailsArray{
            if isError(error: emp.Error, target: self) {
                navigationController?.popViewController(animated: true)
                break
            }
            
            nameLabel.text = emp.Employee_Name
            mgrLabel.text = emp.MGR_Name
            deptLabel.text = emp.Dept_Name
            nationalityLabel.text = emp.Nationality
            joinDateLabel.text = emp.Join_Date
            startDateLabel.text = emp.Start_Date
            jobDescLabel.text = emp.Job_Desc
            subJobLabel.text = emp.Sub_Job_Desc
            basicSalayLabel.text = emp.Basic_Salary
            packageLabel.text = emp.Package
            companyLabel.text = emp.Compnay
            workHrsLabel.text = emp.Work_Hrs
            absentLabel.text = emp.Absent_Days
        }
    }

}
