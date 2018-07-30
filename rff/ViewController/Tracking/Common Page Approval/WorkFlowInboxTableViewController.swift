//
//  WorkFlowInboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class WorkFlowInboxTableViewController: UITableViewController {
    
    // -- MARK: Variables
    
    let cellId = "cell_workFlowInbox"
    var workFlow = [WorkFlowModul]()
    
    // -- MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: tableView, isEmpty: workFlow.isEmpty)
        return workFlow.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WorkFlowInboxCell{
            
            let workFlow = self.workFlow[indexPath.row]
            cell.empId.text = workFlow.WorkFlow_Empid
            cell.empName.text = workFlow.WorkFlow_EmpName
            cell.empRole.text = workFlow.WorkFlow_EmpRole
            cell.status.text = workFlow.WorkFlow_EmpStatus
            cell.transDate.text = workFlow.WorkFlow_EmpTransDate
            
            return cell
        }
        return UITableViewCell()
    }

}

class WorkFlowInboxCell: UITableViewCell{
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var empId: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empRole: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var transDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
        
    }
    
}





