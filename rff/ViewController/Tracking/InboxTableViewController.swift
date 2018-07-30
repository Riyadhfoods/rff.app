//
//  InboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 27/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxTableViewController: UITableViewController, VacApproveActionDelegate {

    let cellId = "trackingInboxCell"
    var arrayOfInboxGrid = [InboxGridModul]()
    
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    let languageChosen = LoginViewController.languageChosen
    var listFormId = 0
    var pid = ""
    var empName = ""
    var empId = ""
    var categorySelected = 0
    var cellRow = 0
    var navTitle: String = ""
    
    func approveAction(isSuccess: Bool, row: Int, categorySelected: Int) {
        if isSuccess && !arrayOfInboxGrid.isEmpty && (categorySelected == 1 || categorySelected == 3){
            arrayOfInboxGrid.remove(at: row)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavAndBackButton(navItem: navigationItem, title: navTitle, backTitle: "Return".localize())
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        setViewAlignment()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // -- MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: self.tableView, isEmpty: arrayOfInboxGrid.count == 0)
        return arrayOfInboxGrid.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? InboxTableViewCell {
            cell.contentView.backgroundColor = UIColor.clear
            
            let emp_id = arrayOfInboxGrid[indexPath.row].empid
            let emp_name = arrayOfInboxGrid[indexPath.row].empname
            let date = arrayOfInboxGrid[indexPath.row].date
            
            cell.empIdEnglish.text = emp_id
            cell.empNameEnglish.text = emp_name
            cell.dateEnglish.text = date
            cell.viewForm.addTarget(self, action: #selector(viewFormButtonTapped(sender:)), for: .touchUpInside)
            cell.viewForm.tag = indexPath.row
//
//            print("\(indexPath.row)")
//            print("empid = \(arrayOfInboxGrid[indexPath.row].empid)")
//            print("empname = \(arrayOfInboxGrid[indexPath.row].empname)")
//            print("date = \(arrayOfInboxGrid[indexPath.row].date)")
//            print("pid = \(arrayOfInboxGrid[indexPath.row].pid)")
            
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }
    
    @objc func viewFormButtonTapped(sender: UIButton){
        pid = arrayOfInboxGrid[sender.tag].pid
        empName = arrayOfInboxGrid[sender.tag].empname
        empId = arrayOfInboxGrid[sender.tag].empid
        cellRow = sender.tag
        if listFormId == 10 || listFormId == 1004{
          performSegue(withIdentifier: "showApprovalFormForInbox", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showApprovalFormForInbox"{
            if let viewController = segue.destination as? InboxApprovalFormViewController{
                viewController.listFormId = listFormId
                viewController.pid = pid
                viewController.appliedEmpName = empName
                viewController.appliedEmpId = empId
                viewController.categorySelected = categorySelected
                viewController.delegate = self
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
