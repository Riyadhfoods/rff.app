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
    
    let webservice = Sales()
    let cellId = "cell_workFlow"
    var orderId = ""
    var workFlowArray = [SalesModel]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //workFlowArray = webservice.BindApprovalGrid_SalesApprovalForm(orderid: orderId)
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if workFlowArray.count == 0{
            emptyMessage(message: "No Data".localize(), viewController: self, tableView: workFlowTableView)
        }
        return workFlowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? WorkFlowCell{
            
            let workFlow = workFlowArray[indexPath.row]
            cell.empId.text = workFlow.SOA_EMPID
            cell.empName.text = workFlow.SOA_EMPNAME
            cell.empRole.text = workFlow.SOA_EMPROLE
            cell.transDate.text = workFlow.SOA_TRANSACTIONDATE
            cell.status.text = workFlow.SOA_STATUS
            
            return cell
        }
        return UITableViewCell()
    }
    
}
