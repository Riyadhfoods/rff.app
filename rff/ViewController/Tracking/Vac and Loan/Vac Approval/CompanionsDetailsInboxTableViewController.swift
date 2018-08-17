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
    var companionsDetailsArrayForVac = [CompanionsDetails]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: tableView, isEmpty: companionsDetailsArrayForVac.isEmpty)
        return companionsDetailsArrayForVac.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CompanionsDetailsInbox{
            
            let companion = companionsDetailsArrayForVac[indexPath.row]
            cell.name.text = companion.Name_Companion
            cell.city.text = companion.City_Companion
            cell.dob.text = companion.DOB_Companion
            cell.visaReq.text = companion.VisaRequest_Companion
            
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
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
    }
}
