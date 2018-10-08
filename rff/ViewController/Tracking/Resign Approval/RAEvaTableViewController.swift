//
//  RAEvaTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class RAEvaTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_RAEva"
    var evaDetailsArray = [EvaDetailsModul]()
    
    // -- MARK: View kife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evaDetailsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RAEvaCell {
            let eva = evaDetailsArray[indexPath.row]
            cell.dateLabel.text = eva.Date
            cell.totalLabel.text = eva.Total
            cell.resultLabel.text = eva.Result
            cell.managerRemarkLabel.text = eva.MGr_Remark
            
            return cell
        }
        return UITableViewCell()
    }

}

class RAEvaCell: UITableViewCell{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var managerRemarkLabel: UILabel!
    
}








