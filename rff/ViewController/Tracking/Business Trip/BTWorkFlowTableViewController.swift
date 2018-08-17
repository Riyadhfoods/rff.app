//
//  BTWorkFlowTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class BTWorkFlowTableViewController: UITableViewController {

    // -- MARK: Variables
    
    var workFlow = [WorkFlowModul]()
    let cellId = "cell_workFlowBT"
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BTWorkFlowCell{
            
            let workFlowElement = workFlow[indexPath.row]
            
            cell.empID.text = workFlowElement.WorkFlow_Empid
            cell.empName.text = workFlowElement.WorkFlow_EmpName
            cell.empRole.text = workFlowElement.WorkFlow_EmpRole
            cell.status.text = workFlowElement.WorkFlow_EmpStatus
            cell.transDate.text = workFlowElement.WorkFlow_EmpTransDate
            
            return cell
        }
        return UITableViewCell()
    }

}

class BTWorkFlowCell: UITableViewCell{
    
    @IBOutlet weak var empID: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empRole: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var transDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
    }
}
