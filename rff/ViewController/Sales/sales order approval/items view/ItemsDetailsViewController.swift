//
//  ItemsDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
protocol ItemDetailsDelegate{
    func updateItemDeatails(itemsDetails: [SalesOrderItemsDetailsModel])
}

class ItemsDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemDetailsTableView: UITableView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let cellId = "cell_itemsDetails"
    var orderId = ""
    var userId = ""
    var isChecked: Bool = true
    var itemsDetails = [SalesOrderItemsDetailsModel]()
    var delegate: ItemDetailsDelegate?
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        
        title = "Order ID:" + " \(orderId)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: itemDetailsTableView, isEmpty: itemsDetails.count == 0)
        return itemsDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemDetailsCell{
            
            let item = itemsDetails[indexPath.row]
            cell.num.text = "\(indexPath.row + 1)"
            cell.itemDesc.text = item.itemDesc
            cell.changePrice.text = item.changePrice
            cell.orgPrice.text = item.originalPrice
            cell.qty.text = item.qty
            cell.uofm.text = item.unitOfMeasurement
            cell.lastYearORDQty.text = item.lastYearOrderQty
            cell.yearToDateORDQty.text = item.yearToDateOrderQty
            cell.total.text = item.total
            cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxButtonTapped(sender:)), for: .touchUpInside)
            cell.checkBoxBtn.tag = indexPath.row
            
            if item.isItemChecked == true{
                cell.checkBoxBtn.setBackgroundImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            } else {
                cell.checkBoxBtn.setBackgroundImage(UIImage(), for: .normal)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func checkBoxButtonTapped(sender: UIButton){
        isChecked = !isChecked
        
        if isChecked == true{
            sender.setBackgroundImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
        } else {
            sender.setBackgroundImage(UIImage(), for: .normal)
        }
        
        itemsDetails[sender.tag].isItemChecked = isChecked
        let indexPath = IndexPath(row: sender.tag, section: 0)
        itemDetailsTableView.reloadRows(at: [indexPath], with: .none)
        if let delegate = delegate{
            delegate.updateItemDeatails(itemsDetails: itemsDetails)
        }
    }
    
}
