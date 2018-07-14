//
//  ReturnItemSelectedViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnItemSelectedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_items"
    let webservice = Sales()
    var isAttachmentError = false
    var isSendingError = false
    var sendResultError = ""
    var attachmentError = ""
    var returnId = ""
    var attachmentName = ""
    var attachmentContent = ""
    var action: (() -> Void)?
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ReturnItemSelectedViewController: UITableViewDataSource, UITableViewDelegate{
    // -- MARKK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: itemsTableView, isEmpty: itemsArrayFromWS.count == 0)
        return itemsArrayFromWS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ReturnItemSelectedCell{
            
            let item = itemsArrayFromWS[indexPath.row]
            cell.cellIndex = indexPath.row
            
            cell.serialNmuber.text = "\(indexPath.row + 1)"
            cell.itemNumber.text = item.itemNumberFromWS
            cell.invoiceNumber.text = item.invoiceNumberFromWS
            cell.invoiceDate.text = item.invoiceDateFromWS
            cell.desc.text = item.desc
            cell.uofm.text = item.uofm
            cell.qty.text = item.qty
            cell.avePrice.text = item.avgPrice
            cell.totalCost.text = item.totalPrice
            cell.expiredDate.text = item.expiredDate
            cell.returnType.text = item.returnType
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteItemTapped(sender:)), for: .touchUpInside)
            
            itemsArrayFromWS[indexPath.row].serialNumberFromWS = indexPath.row + 1
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func deleteItemTapped(sender: UIButton){
        itemsArrayFromWS.remove(at: sender.tag)
        itemsTableView.reloadData()
    }
}





