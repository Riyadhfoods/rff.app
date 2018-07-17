//
//  SalesOrderItemDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var itemTableView: UITableView!
    var salesItemDetails = [SalesOrderItemDetails]()
    let cellId = "cell_salesOrderDetails"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesItemDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesOrderItemDetailsCell{
            
            let salesOrderItem = salesItemDetails[indexPath.row]
            cell.serialNo.text = "\(indexPath.row + 1)"
            cell.itemNo.text = salesOrderItem.itemId
            cell.itemDesc.text = salesOrderItem.itemDesc
            cell.unitCost.text = salesOrderItem.unitPrice
            cell.exitCost.text = salesOrderItem.extCast
            cell.qty.text = salesOrderItem.qty
            cell.uofm.text = salesOrderItem.uofm
            cell.lastYear.text = salesOrderItem.lastYear
            cell.yearToDate.text = salesOrderItem.yearToDate
            
            return cell
        }
        return UITableViewCell()
    }

}
