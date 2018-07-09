//
//  ItemReturnDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemReturnDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // -- MARK: IBOutlet
    
    @IBOutlet weak var itemReturnDetailsTableview: UITableView!
    
    // -- MARK: Variable
    
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_itemReturnDetails"
    var itemsDetailsArray = [SalesReturn]()
    var isChecked: Bool = true
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemReturnDetailsCell{
            let itemDetail = itemReturnDetails[indexPath.row]
            itemReturnDetails[indexPath.row].serialNumber = "\(indexPath.row + 1)"
            
            cell.num.text = itemDetail.serialNumber
            cell.invoiceNo.text = itemDetail.InvoiceNumber
            cell.lotNo.text =  itemDetail.LOTNumber
            cell.itemNo.text = itemDetail.ItemNumber
            cell.desc.text = itemDetail.desc
            cell.unitePRice.text = itemDetail.unitPrice
            cell.totalCost.text = itemDetail.totalCast
            cell.qty.text =  itemDetail.qty
            cell.uofm.text = itemDetail.uofm
            cell.returnType.text = itemDetail.returnType
            cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxButtonTapped(sender:)), for: .touchUpInside)
            cell.checkBoxBtn.tag = indexPath.row
            
            if itemDetail.isItemChecked == true{
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
        
        itemReturnDetails[sender.tag].isItemChecked = isChecked
        itemReturnDetailsTableview.reloadData()
    }
    

}














