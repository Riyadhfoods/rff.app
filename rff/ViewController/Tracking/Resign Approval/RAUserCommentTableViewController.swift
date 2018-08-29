//
//  RAUserCommentTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class RAUserCommentTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_RAUserComment"
    
    // -- MARK: View kife Cycle
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RAUserCommentCell {
            return cell
        }
        return UITableViewCell()
    }

}

class RAUserCommentCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
}













