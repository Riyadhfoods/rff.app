//
//  WorkFlowViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class WorkFlowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var workFlowTableView: UITableView!
    
    
    // -- MARK: Variables
    
    let cellId = "cell_workFlow"
    var orderId = ""
    var workFlowArray = [WorkFlowModul]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Work Flow"
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: workFlowTableView, isEmpty: workFlowArray.count == 0)
        return workFlowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WorkFlowCell{
            
            let workFlow = workFlowArray[indexPath.row]
            cell.empId.text = workFlow.WorkFlow_Empid
            cell.empName.text = workFlow.WorkFlow_EmpName
            cell.empRole.text = workFlow.WorkFlow_EmpRole
            cell.transDate.text = workFlow.WorkFlow_EmpTransDate
            cell.status.text = workFlow.WorkFlow_EmpStatus
            
            return cell
        }
        return UITableViewCell()
    }
    
}
