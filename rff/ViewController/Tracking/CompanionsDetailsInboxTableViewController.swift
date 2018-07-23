//
//  CompanionsDetailsInboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CompanionsDetailsInboxTableViewController: UITableViewController {
    
    // -- MARK: Varaibles
    
    let cellId = "cell_companionsDetailsInbox"

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
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CompanionsDetailsInbox{
            
            return cell
        }
        return UITableViewCell()
    }

}

class CompanionsDetailsInbox: UITableViewCell{
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var visaReq: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
    }
}
