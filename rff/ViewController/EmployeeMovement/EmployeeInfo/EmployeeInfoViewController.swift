//
//  EmployeeInfoViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class EmployeeInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var EmployeeTextField: UITextField!
    @IBOutlet weak var employeeInfoListItem: UITableView!
    
    // -- MARK: Variable
    let screenSize = AppDelegate().screenSize
    let cell_Id = "employeeInfoCell"
    
    let employeeListArray = [
        "1598 - Faisal Alkhotaifi",
        "111 - Ahmed Siddig Ahmed AlGam",
        "992 - Merajuddin Ansari"]
    
    let employeeListInfoArray = [
        "General Information",
        "Mon. Salary Details",
        "Iqama Expiry",
        "Salary",
        "Vacation Details",
        "Loan Details",
        "Evaluation Details",
        "Increment/Decrement Details",
        "Violation Details",
        "Dependent Details",
        "Saudiazation %",
        "Transfer Details",
        "Document Details"
    ]
    
    // -- MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeInfoListItem.delegate = self
        employeeInfoListItem.dataSource = self
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_Id, for: indexPath) as? EmployeeInfoTableViewCell{
            let employeeInfo = employeeListInfoArray[indexPath.row]
            cell.employeeInfoLabel.text = employeeInfo
            
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: IBActions
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addDeductionsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func AddAllowencesButtonTapped(_ sender: Any) {
    }
    
    @IBAction func editEmpDetailsButtonTapped(_ sender: Any) {
    }
    
}
