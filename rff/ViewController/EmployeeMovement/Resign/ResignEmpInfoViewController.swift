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
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: SetUps
    
    func setUpView(){
        stackViewWidth.constant = screenSize.width - 64
    }
}
