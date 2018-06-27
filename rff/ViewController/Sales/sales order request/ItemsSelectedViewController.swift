//
//  ItemsSelectedViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol ItemCountAddedDelegate {
    func setCount(count: Int)
    //func itemsArrayReceived(itemsArray: [ItemsModul])
}

class ItemsSelectedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_addedItem"
    let webservice = Sales()
    var count: Int = 0
    var delegate: ItemCountAddedDelegate?
    var unoits = [SalesModel]()
    var itemSentStatus = [SalesModel]()
    var sentStatus = [SalesModel]()
    var error: String = ""
    
    // -- MARk: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Summary".localize()
        setViewAlignment()
        setDelegate()
    }
    
    func setDelegate(){
        if delegate != nil{
            delegate?.setCount(count: salesRequestDetails.itemsArray.count)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if salesRequestDetails.itemsArray.count == 0 {
            emptyMessage(message: "No data".localize(), viewController: self, tableView: itemsTableView)
        }
        return salesRequestDetails.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemsSelectedCell{
            cell.unoits = webservice.BindSalesOrderUnitofMeasure(itemid: salesRequestDetails.itemsArray[indexPath.row].Grid_Desc)
            
            cell.num.text = "\(indexPath.row + 1)"
            cell.desc.text = salesRequestDetails.itemsArray[indexPath.row].Grid_Desc
            cell.PCSTextfield.text = salesRequestDetails.itemsArray[indexPath.row].Grid_UOM
            cell.qtyTextfield.text = salesRequestDetails.itemsArray[indexPath.row].Grid_Qty
            cell.unitPriceTextfield.text = salesRequestDetails.itemsArray[indexPath.row].Grid_UnitPrice
            cell.totalPrice.text = salesRequestDetails.itemsArray[indexPath.row].Grid_TotalPrice
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(handleDeleteAction(sender:)), for: .touchUpInside)
            cell.indexpathRow = indexPath.row
            
            cell.qtyTextfield.tag = indexPath.row
            cell.unitPriceTextfield.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func handleDeleteAction(sender: UIButton){
        salesRequestDetails.itemsArray.remove(at: sender.tag)
        itemsTableView.reloadData()
        setDelegate()
    }
    
    // -- MARK: IBOutlets
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        var count = 0
        salesRequestDetails.table = !salesRequestDetails.itemsArray.isEmpty
        if salesRequestDetails.table{
            for item in salesRequestDetails.itemsArray{
                itemSentStatus = webservice.SendItemGrid(orderid: salesRequestDetails.orderId, serialno: count, customerid: salesRequestDetails.customer, Grid_ItemId: item.Grid_ItemId, Grid_Desc: item.Grid_Desc, Grid_UnitPrice: item.Grid_UnitPrice, Grid_Qty: item.Grid_Qty, Grid_TotalPrice: item.Grid_TotalPrice, Grid_UOM: item.Grid_UOM)
                for status in itemSentStatus{
                    if status.grid_error != ""{
                        let alertTitle = "Alert".localize()
                        let alertMessage = status.grid_error
                        AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "Ok", onAction: {
                            return
                        }, cancelAction: nil, self)
                    } else {
                        if salesRequestDetails.orderId == ""{
                            salesRequestDetails.orderId = status.OrderID
                        }
                        if status.Flag == "true" {
                            salesRequestDetails.flag = true
                        } else { salesRequestDetails.flag = false }
                        count += 1
                        print("It sent successfully")
                    }
                }
            }
            
            print(salesRequestDetails)
            sentStatus = webservice.Senditem(
                orderid: salesRequestDetails.orderId,
                branchid: salesRequestDetails.branchId,
                customerid: salesRequestDetails.customer,
                branch: salesRequestDetails.branch,
                table: salesRequestDetails.table,
                salesperson: salesRequestDetails.salesperson,
                company: salesRequestDetails.companyId,
                emp_id: salesRequestDetails.emp_id,
                comment: salesRequestDetails.comment,
                city: salesRequestDetails.city,
                store: salesRequestDetails.store,
                salespersonstore: salesRequestDetails.salespersonstore,
                merchandiser: salesRequestDetails.merchandiser,
                offer: salesRequestDetails.offer,
                deliverydate: salesRequestDetails.deliverydate,
                loccode: salesRequestDetails.loccode,
                docid: salesRequestDetails.docid,
                purchasegrid: salesRequestDetails.purchasegrid,
                supermarket: salesRequestDetails.supermarket,
                flag: salesRequestDetails.flag)
            
            for status in sentStatus{
                if status.grid_error != ""{
                    error = status.grid_error
                }
            }
            
            if error != ""{
                AlertMessage().showAlertMessage(alertTitle: "Alert!".localize(), alertMessage: error, actionTitle: "Ok", onAction: {
                    return
                }, cancelAction: nil, self)
            } else {
                AlertMessage().showAlertMessage(alertTitle: "Success".localize(), alertMessage: "Order request sent successfully".localize(), actionTitle: "Ok", onAction: {
                    salesRequestDetails.removeAll()
                    self.navigationController?.popToRootViewController(animated: true)
                }, cancelAction: nil, self)
            }
            
        }
    }
}

extension ItemsSelectedViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 81, right: 0)
            self.itemsTableView.contentInset = contentInset
        }, onHide: { _ in
            self.itemsTableView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}


