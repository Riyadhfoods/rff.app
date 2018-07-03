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
    
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_workFlowReturn"
    var orderId = ""
    var workFlowArray = [SalesReturn]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Work Flow"
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workFlowArray.count == 0{
            emptyMessage(message: "No Data".localize(), viewController: self, tableView: workFlowReturnTableview)
        }
        return workFlowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WorkFlowReturnCell{
            let workFlow = workFlowArray[indexPath.row]
            cell.empId.text = workFlow.SRA_EMP_ID
            cell.empName.text = workFlow.SRA_Name
            cell.empRole.text = workFlow.SRA_EmpRole
            cell.transDate.text = workFlow.SRA_TransDate
            cell.status.text = workFlow.SRA_Status
            
            return cell
        }
        return UITableViewCell()
    }

}
