//
//  RAIncDecTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class RAIncDecTableViewController: UITableViewController {
    
    // -- MARK: Variables
    
    let cellId = "cell_RAIncDec"
    var IncDecrDetailsArray = [Inc_DecrDetailsModul]()
    
    // -- MARK: View kife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IncDecrDetailsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RAIncDecCell {
            let incDec = IncDecrDetailsArray[indexPath.row]
            cell.dateLabel.text = incDec.Date
            cell.oldBasicLabel.text = incDec.Old_Basic
            cell.NewBasicLabel.text = incDec.New_Basic
            cell.IncDecLabel.text = incDec.Inc_Decr
            
            return cell
        }
        return UITableViewCell()
    }

}

class RAIncDecCell: UITableViewCell{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var oldBasicLabel: UILabel!
    @IBOutlet weak var NewBasicLabel: UILabel!
    @IBOutlet weak var IncDecLabel: UILabel!
    
}







