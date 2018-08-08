//
//  WorkFlowReturnViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class WorkFlowReturnViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlet
    
    @IBOutlet weak var workFlowReturnTableview: UITableView!
    
    
    // -- MARK: Variable
    
    let cellId = "cell_workFlowReturn"
    var orderId = ""
    var workFlowArray = [WorkFlowModul]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Work Flow".localize()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: workFlowReturnTableview, isEmpty: workFlowArray.count == 0)
        return workFlowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WorkFlowReturnCell{
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
