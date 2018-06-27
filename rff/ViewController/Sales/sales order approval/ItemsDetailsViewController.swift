//
//  ItemsDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemsDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemDetailsTableView: UITableView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let cellId = "cell_itemsDetails"
    var orderId = ""
    var userId = ""
    var itemsDetailsArray = [SalesModel]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        
        title = "Order ID" + " \(orderId)"
        //itemsDetailsArray = webservice.BindOrderItemGridFor_SalesApprovalForm(emp_id: userId, ordernumber: orderId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemsDetailsArray.count == 0{
            emptyMessage(message: "No Data".localize(), viewController: self, tableView: itemDetailsTableView)
        }
        return itemsDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemDetailsCell{
            
            let item = itemsDetailsArray[indexPath.row]
            cell.num.text = item.SOA_SERIALNUMBER
            cell.itemDesc.text = item.SOA_ITEMDESC
            cell.changePrice.text = item.SOA_CHANGEDPRICE
            cell.orgPrice.text = item.SOA_ORIGINALPRICE
            cell.qty.text = item.SOA_QTY
            cell.uofm.text = item.SOA_UNITOFMEASUREMENT
            cell.lastYearORDQty.text = item.SOA_LASTYEARORDERQTY
            cell.yearToDateORDQty.text = item.SOA_YEARTODATEORDERQTY
            cell.total.text = item.SOA_TOTAL
            
            return cell
        }
        return UITableViewCell()
    }
    
}
