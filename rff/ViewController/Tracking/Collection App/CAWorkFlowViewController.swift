//
//  CAWorkFlowViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CAWorkFlowViewController: UITableViewController {

    // -- MARK: IBOutlets
    
    
    
    // -- MARK: Variables
    
    let cellId = "cell_CAWorkFlow"
    var workFlow = [WorkFlowModul]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // -- MARK: Set Ups

}

extension CAWorkFlowViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workFlow.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CAWorkFlow{
            let workFlowElement = workFlow[indexPath.row]
            cell.empIdLable.text = workFlowElement.WorkFlow_Empid
            cell.nameLabel.text = workFlowElement.WorkFlow_EmpName
            cell.roleLable.text = workFlowElement.WorkFlow_EmpRole
            cell.statusLabel.text = workFlowElement.WorkFlow_EmpStatus
            cell.tranDateLabel.text = workFlowElement.WorkFlow_EmpTransDate
            return cell
        }
        
        return UITableViewCell()
    }
}

class CAWorkFlow: UITableViewCell{
    
    @IBOutlet weak var empIdLable: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLable: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tranDateLabel: UILabel!
    
}
