//
//  IODWorkFlowTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 03/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class IODWorkFlowTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_IOBWorkFlow"
    var workFlow = [WorkFlowModul]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workFlow.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? IOBWorkFlowCell{
            let workFlowElement = workFlow[indexPath.row]
            cell.idLabel.text = workFlowElement.WorkFlow_Empid
            cell.nameLabel.text = workFlowElement.WorkFlow_EmpName
            cell.roleLabel.text = workFlowElement.WorkFlow_EmpRole
            cell.statusLabel.text = workFlowElement.WorkFlow_EmpStatus
            cell.transDateLabel.text = workFlowElement.WorkFlow_EmpTransDate
            return cell
        }
        return UITableViewCell()
    }

}

class IOBWorkFlowCell: UITableViewCell{
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var transDateLabel: UILabel!
}






