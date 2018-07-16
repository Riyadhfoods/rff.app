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
    var workFlowWithOutTheCreator = [SalesReturn]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<workFlowArray.count where index != 0{
            workFlowWithOutTheCreator.append(workFlowArray[index])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workFlowWithOutTheCreator.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesWorkFlow", for: indexPath) as? SalesWorkFlowCell{
            
            let workFlow = workFlowWithOutTheCreator[indexPath.row]
            cell.empID.text = workFlow.SRA_EMP_ID
            cell.empName.text = workFlow.SRA_Name
            cell.empRole.text = workFlow.SRA_EmpRole
            cell.transDate.text = workFlow.SRA_TransDate
            cell.status.text = workFlow.SRA_Status
            
            return cell
        }
        return UITableViewCell()
    }

}
