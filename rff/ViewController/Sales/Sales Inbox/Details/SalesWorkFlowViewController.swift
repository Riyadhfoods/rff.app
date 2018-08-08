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
        
        if !workFlowArray.isEmpty{
            for index in 0..<workFlowArray.count where index != 0{
                workFlowWithOutTheCreator.append(workFlowArray[index])
            }
        } else {
            for index in 0..<workFlowOrderArray.count where index != 0{
                workFlowOrderWithOutTheCreator.append(workFlowOrderArray[index])
            }
        }
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !workFlowOrderWithOutTheCreator.isEmpty { return workFlowOrderWithOutTheCreator.count }
        return workFlowWithOutTheCreator.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesWorkFlow", for: indexPath) as? SalesWorkFlowCell{
            
            if !workFlowWithOutTheCreator.isEmpty{
                let workFlow = workFlowWithOutTheCreator[indexPath.row]
                cell.empID.text = workFlow.WorkFlow_Empid
                cell.empName.text = workFlow.WorkFlow_EmpName
                cell.empRole.text = workFlow.WorkFlow_EmpRole
                cell.transDate.text = workFlow.WorkFlow_EmpTransDate
                cell.status.text = workFlow.WorkFlow_EmpStatus
            } else {
                let workFlow = workFlowOrderWithOutTheCreator[indexPath.row]
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
