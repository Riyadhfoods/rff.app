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
    var workFlowArray = [SalesReturn]()
    var workFlowOrderArray = [SalesModel]()
    var workFlowWithOutTheCreator = [SalesReturn]()
    var workFlowOrderWithOutTheCreator = [SalesModel]()
    
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
                cell.empID.text = workFlow.SRA_EMP_ID
                cell.empName.text = workFlow.SRA_Name
                cell.empRole.text = workFlow.SRA_EmpRole
                cell.transDate.text = workFlow.SRA_TransDate
                cell.status.text = workFlow.SRA_Status
            } else {
                let workFlow = workFlowOrderWithOutTheCreator[indexPath.row]
                cell.empID.text = workFlow.SOA_EMPID
                cell.empName.text = workFlow.SOA_NAME
                cell.empRole.text = workFlow.SOA_EMPROLE
                cell.transDate.text = workFlow.SOA_TRANSACTIONDATE
                cell.status.text = workFlow.SOA_STATUS
            }
            
            return cell
        }
        return UITableViewCell()
    }

}
