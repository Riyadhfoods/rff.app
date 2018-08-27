//
//  TravelAndResidenceDetailsTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class TravelAndResidenceDetailsTableViewController: UITableViewController {
    
    // -- MARK: Variables
    
    var travelAndResidenceDetailsArray = [BusinessTrip_AppTravelModel]()
    let cellId = "cell_TraveAndResidenceDetails"
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelAndResidenceDetailsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TravelAndResidenceDetailsCell{
            
            let travelD = travelAndResidenceDetailsArray[indexPath.row]
            
            cell.airlines.text = travelD.AirLineGrid
            
            if travelD.VisaGrid {
                cell.visaButton.setBackgroundImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            } else { cell.visaButton.setBackgroundImage(UIImage(), for: .normal) }
            
            cell.toLoc.text = travelD.ToLocGrid
            cell.fromLoc.text = travelD.FromLocGrid
            cell.Todate.text = travelD.ToDateGrid
            cell.fromDate.text = travelD.FromDateGrid
            
            return cell
        }
        return UITableViewCell()
    }

}

class TravelAndResidenceDetailsCell: UITableViewCell{
    
    @IBOutlet weak var airlines: UILabel!
    @IBOutlet weak var visaButton: UIButton!
    @IBOutlet weak var visaTitle: UILabel!
    @IBOutlet weak var toLoc: UILabel!
    @IBOutlet weak var fromLoc: UILabel!
    @IBOutlet weak var Todate: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
        visaTitle.textAlignment = .center
    }
}
