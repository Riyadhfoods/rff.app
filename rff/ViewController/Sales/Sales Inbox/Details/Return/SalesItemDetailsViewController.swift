//
//  SalesItemDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var itemsTableView: UITableView!
    var salesItemDetails = [SalesItemDetails]()
    let cellId = "cell_SalesitemDetails"
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesItemDetailsCell{
            let salesItem = salesItemDetails[indexPath.row]
            
            cell.serialNumber.text = "\(indexPath.row + 1)"
            cell.InvoiceNo.text = salesItem.InvoiceNumber
            cell.LOTNo.text = salesItem.LOTNumber
            cell.ItemNo.text = salesItem.ItemNumber
            cell.desc.text = salesItem.desc
            cell.qty.text = salesItem.qty
            cell.uofm.text = salesItem.uofm
            cell.unitPrice.text = salesItem.unitPrice
            cell.totalCost.text = salesItem.totalCast
            cell.invoiceDate.text = salesItem.invoiceDate
            cell.returnType.text = salesItem.returnType
            
            return cell
        }
        return UITableViewCell()
    }

}
