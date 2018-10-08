//
//  ResignEmpInfoViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ResignEmpInfoViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var empNameLabel: UILabel!
    @IBOutlet weak var managerLabel: UILabel!
    @IBOutlet weak var DeptLabel: UILabel!
    @IBOutlet weak var NationalityLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var subJobLabel: UILabel!
    @IBOutlet weak var basicSalaryLabel: UILabel!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var workHrsLabel: UILabel!
    @IBOutlet weak var absentDaysLabel: UILabel!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    // MARK: Variables
    
    let screenSize = AppDelegate.shared.screenSize
    var empDetailsArray = [ResignEmpDetailsModul]()
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: SetUps
    
    func setUpView(){
        stackViewWidth.constant = screenSize.width - 32
    }
    
    func setUpData(){
        for emp in empDetailsArray{
            empNameLabel.text = emp.Employee_Name
            managerLabel.text = emp.MGR_Name
            DeptLabel.text = emp.Dept_Name
            NationalityLabel.text = emp.Nationality
            companyLabel.text = emp.Compnay
            joinDateLabel.text = emp.Join_Date
            startDateLabel.text = emp.Start_Date
            jobLabel.text = emp.Job_Desc
            subJobLabel.text = emp.Sub_Job_Desc
            basicSalaryLabel.text = emp.Basic_Salary
            packageLabel.text = emp.Package
            workHrsLabel.text = emp.Work_Hrs
            absentDaysLabel.text = emp.Absent_Days
        }
    }
    
}









