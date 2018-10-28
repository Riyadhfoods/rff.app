//
//  InboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 27/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxTableViewController: UITableViewController, ApproveActionDelegate {

    let cellId = "trackingInboxCell"
    var arrayOfInboxGrid = [InboxGridModul]()
    
    let mainBackgroundColor = AppDelegate.shared.mainBackgroundColor
    let languageChosen = LoginViewController.languageChosen
    var listFormId = 0
    var pid = ""
    var empName = ""
    var empId = ""
    var empId_next = ""
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
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
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

            print("\(indexPath.row)")
            print("empid = \(arrayOfInboxGrid[indexPath.row].empid)")
            print("empname = \(arrayOfInboxGrid[indexPath.row].empname)")
            print("date = \(arrayOfInboxGrid[indexPath.row].date)")
            print("pid = \(arrayOfInboxGrid[indexPath.row].pid)")
            
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }
    
    @objc func viewFormButtonTapped(sender: UIButton){
        pid = arrayOfInboxGrid[sender.tag].pid
        empName = arrayOfInboxGrid[sender.tag].empname
        empId = arrayOfInboxGrid[sender.tag].empid
        if sender.tag + 1 < arrayOfInboxGrid.count{
            empId_next = arrayOfInboxGrid[sender.tag + 1].empid
        }
        
        cellRow = sender.tag
        if listFormId == 10 || listFormId == 1004{
            performSegue(withIdentifier: "showApprovalFormForInbox", sender: nil)
        } else if listFormId == 2079{
            performSegue(withIdentifier: "showApprovalFormForBusinessTrip", sender: nil)
        } else if listFormId == 1003{
            performSegue(withIdentifier: "showApproveFormForResign", sender: nil)
        } else if listFormId == 2083{
            performSegue(withIdentifier: "showApproveFormForInOutDeduction", sender: nil)
        } else if listFormId == 2112{
            performSegue(withIdentifier: "showApproveFormForCollection", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showApprovalFormForInbox"{
            if let viewController = segue.destination as? InboxApprovalFormViewController{
                viewController.listFormId = listFormId
                viewController.pid = pid
                viewController.appliedEmpName = empName
                viewController.appliedEmpId = empId
                viewController.cellRow = cellRow
                viewController.categorySelected = categorySelected
                viewController.delegate = self
            }
        } else if segue.identifier == "showApprovalFormForBusinessTrip" {
            if let viewController = segue.destination as? BusinessTripApprovalFormViewController{
                viewController.listFormId = listFormId
                viewController.pid = pid
                viewController.appliedEmpName = empName
                viewController.appliedEmpId = empId
                viewController.cellRow = cellRow
                viewController.categorySelected = categorySelected
                viewController.delegate = self
            }
        } else if segue.identifier == "showApproveFormForResign" {
            if let viewController = segue.destination as? ResignApprovalViewController{
                viewController.listFormId = listFormId
                viewController.pid = pid
                viewController.appliedEmpName = empName
                viewController.appliedEmpId = empId
                viewController.cellRow = cellRow
                viewController.categorySelected = categorySelected
                viewController.delegate = self
            }
        } else if segue.identifier == "showApproveFormForInOutDeduction" {
            if let viewController = segue.destination as? InOutDeductionApprovalViewController{
                viewController.listFormId = listFormId
                viewController.pid = pid
                viewController.appliedEmpName = empName
                viewController.appliedEmpId = empId
                viewController.cellRow = cellRow
                viewController.categorySelected = categorySelected
                viewController.delegate = self
            }
        } else if segue.identifier == "showApproveFormForCollection" {
            if let viewController = segue.destination as? CollectionApprovalViewController{
                viewController.listFormId = listFormId
                viewController.pid = pid
                viewController.appliedEmpName = empName
                viewController.appliedEmpId = empId
                viewController.cellRow = cellRow
                viewController.categorySelected = categorySelected
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
