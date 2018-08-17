//
//  SalesWorkFlowViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesWorkFlowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workFlowTableView: UITableView!
    var workFlowArray = [WorkFlowModul]()
    var workFlowOrderArray = [WorkFlowModul]()
    var workFlowWithOutTheCreator = [WorkFlowModul]()
    var workFlowOrderWithOutTheCreator = [WorkFlowModul]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !workFlowOrderArray.isEmpty { return workFlowOrderArray.count }
        return workFlowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesWorkFlow", for: indexPath) as? SalesWorkFlowCell{
            
            if !workFlowArray.isEmpty{
                let workFlow = workFlowArray[indexPath.row]
                cell.empID.text = workFlow.WorkFlow_Empid
                cell.empName.text = workFlow.WorkFlow_EmpName
                cell.empRole.text = workFlow.WorkFlow_EmpRole
                cell.transDate.text = workFlow.WorkFlow_EmpTransDate
                cell.status.text = workFlow.WorkFlow_EmpStatus
            } else {
                let workFlow = workFlowOrderArray[indexPath.row]
                cell.empID.text = workFlow.WorkFlow_Empid
                cell.empName.text = workFlow.WorkFlow_EmpName
                cell.empRole.text = workFlow.WorkFlow_EmpRole
                cell.transDate.text = workFlow.WorkFlow_EmpTransDate
                cell.status.text = workFlow.WorkFlow_EmpStatus
            }
            
            return cell
        }
        return UITableViewCell()
    }

}
