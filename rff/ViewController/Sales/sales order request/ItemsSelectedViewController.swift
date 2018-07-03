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
            delegate?.setCount(count: salesOrderRequestDetails.itemsArray.count)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if salesOrderRequestDetails.itemsArray.count == 0 {
            emptyMessage(message: "No data".localize(), viewController: self, tableView: itemsTableView)
        }
        return salesOrderRequestDetails.itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ItemsSelectedCell{
            cell.unoits = webservice.BindSalesOrderUnitofMeasure(itemid: salesOrderRequestDetails.itemsArray[indexPath.row].Grid_Desc)
            
            cell.num.text = "\(indexPath.row + 1)"
            cell.desc.text = salesOrderRequestDetails.itemsArray[indexPath.row].Grid_Desc
            cell.PCSTextfield.text = salesOrderRequestDetails.itemsArray[indexPath.row].Grid_UOM
            cell.qtyTextfield.text = salesOrderRequestDetails.itemsArray[indexPath.row].Grid_Qty
            cell.unitPriceTextfield.text = salesOrderRequestDetails.itemsArray[indexPath.row].Grid_UnitPrice
            cell.totalPrice.text = salesOrderRequestDetails.itemsArray[indexPath.row].Grid_TotalPrice
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
        salesOrderRequestDetails.itemsArray.remove(at: sender.tag)
        itemsTableView.reloadData()
        setDelegate()
    }
    
    // -- MARK: IBOutlets
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        var count = 0
        salesOrderRequestDetails.table = !salesOrderRequestDetails.itemsArray.isEmpty
        if salesOrderRequestDetails.table{
            for item in salesOrderRequestDetails.itemsArray{
                itemSentStatus = webservice.SendItemGrid(orderid: salesOrderRequestDetails.orderId, serialno: count, customerid: salesOrderRequestDetails.customer, Grid_ItemId: item.Grid_ItemId, Grid_Desc: item.Grid_Desc, Grid_UnitPrice: item.Grid_UnitPrice, Grid_Qty: item.Grid_Qty, Grid_TotalPrice: item.Grid_TotalPrice, Grid_UOM: item.Grid_UOM)
                for status in itemSentStatus{
                    if status.grid_error != ""{
                        let alertTitle = "Alert".localize()
                        let alertMessage = status.grid_error
                        AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "Ok", onAction: {
                            return
                        }, cancelAction: nil, self)
                    } else {
                        if salesOrderRequestDetails.orderId == ""{
                            salesOrderRequestDetails.orderId = status.OrderID
                        }
                        if status.Flag == true {
                            salesOrderRequestDetails.flag = true
                        } else { salesOrderRequestDetails.flag = false }
                        count += 1
                        print("It sent successfully")
                    }
                }
            }
            
            print(salesOrderRequestDetails)
            sentStatus = webservice.Senditem(
                orderid: salesOrderRequestDetails.orderId,
                branchid: salesOrderRequestDetails.branchId,
                customerid: salesOrderRequestDetails.customer,
                branch: salesOrderRequestDetails.branch,
                table: salesOrderRequestDetails.table,
                salesperson: salesOrderRequestDetails.salesperson,
                company: salesOrderRequestDetails.companyId,
                emp_id: salesOrderRequestDetails.emp_id,
                comment: salesOrderRequestDetails.comment,
                city: salesOrderRequestDetails.city,
                store: salesOrderRequestDetails.store,
                salespersonstore: salesOrderRequestDetails.salespersonstore,
                merchandiser: salesOrderRequestDetails.merchandiser,
                offer: salesOrderRequestDetails.offer,
                deliverydate: salesOrderRequestDetails.deliverydate,
                loccode: salesOrderRequestDetails.loccode,
                docid: salesOrderRequestDetails.docid,
                purchasegrid: salesOrderRequestDetails.purchasegrid,
                supermarket: salesOrderRequestDetails.supermarket,
                flag: salesOrderRequestDetails.flag)
            
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
                    salesOrderRequestDetails.removeAll()
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


