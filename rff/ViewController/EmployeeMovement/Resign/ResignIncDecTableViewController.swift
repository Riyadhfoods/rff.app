//
//  ResignIncDecTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ResignIncDecTableViewController: UITableViewController {
    
    // MARK: Variables
    
    let cellId = "cell_IncDec"
    var IncDecrDetailsArray = [Inc_DecrDetailsModul]()
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: tableView, isEmpty: IncDecrDetailsArray.isEmpty)
        return IncDecrDetailsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? IncDecCell{
            
            let inc_decr = IncDecrDetailsArray[indexPath.row]
            cell.dateLabel.text = inc_decr.Date
            cell.oldBasicLabel.text = inc_decr.Old_Basic
            cell.newBasicLabel.text = inc_decr.New_Basic
            cell.IncrementDecrementLabel.text = inc_decr.Inc_Decr
            
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}

class IncDecCell: UITableViewCell{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var oldBasicLabel: UILabel!
    @IBOutlet weak var newBasicLabel: UILabel!
    @IBOutlet weak var IncrementDecrementLabel: UILabel!
    
}





