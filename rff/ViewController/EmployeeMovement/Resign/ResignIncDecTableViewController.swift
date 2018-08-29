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
    
    // MARK: View life cycle
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? IncDecCell{
            
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





