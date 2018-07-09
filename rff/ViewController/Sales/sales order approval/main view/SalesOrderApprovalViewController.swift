//
//  SalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderApprovalViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var salesOrdertableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MAKR: Variables
    
    let cellId = "cell_salesOrderApproval"
    let screenSize = AppDelegate().screenSize
    let webService = Sales()
    var salesOrderDetails: [SalesModel] = [SalesModel]()
    var buttonVisibilityArray: [SalesModel] = [SalesModel]()
    var rowIndexSelected = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavAndBackButton(navItem: navigationItem, title: "Sales Order Approval".localize(), backTitle: "Return")
        activityIndicator.startAnimating()
        setViewAlignment()
        
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if salesOrderDetails.isEmpty{
            if let userId = AuthServices.currentUserId{
                if let userIdInt = Int(userId){
                    salesOrderDetails = webService.SalesOrderApprove(empno: userIdInt)
                    salesOrdertableview.reloadData()
                }
            }
        }
        activityIndicator.stopAnimating()
    }
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }

}

extension SalesOrderApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if salesOrderDetails.count == 0{
            emptyMessage(message: "No Data".localize(), viewController: self, tableView: salesOrdertableview)
        }
        return salesOrderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesOrderApprovalCell{
            
            let orderId = salesOrderDetails[indexPath.row].OrderID
            let empCreate = salesOrderDetails[indexPath.row].SO_EmpCreated
            let customerName = salesOrderDetails[indexPath.row].SO_CustomerName
            let item = salesOrderDetails[indexPath.row].SO_Items
            let date = salesOrderDetails[indexPath.row].DeliveryDate
            let status = salesOrderDetails[indexPath.row].SO_Status
            let comment = salesOrderDetails[indexPath.row].SO_Comment
            
            cell.orderId.text = orderId
            cell.empCreated.text = empCreate
            cell.customerName.text = customerName
            cell.items.text = item
            cell.date.text = date
            cell.status.text = status
            cell.comment.text = comment  == "" ? AppDelegate.noComment : comment
            cell.selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
            cell.selectButton.tag = indexPath.row
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc functions
    
    @objc func selectButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showSalesOrderApproval", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsSalesOrderApprovalViewController{
            vc.orderId = salesOrderDetails[rowIndexSelected].OrderID
            vc.reqDate = salesOrderDetails[rowIndexSelected].ReqDate
            vc.deliveryDate = salesOrderDetails[rowIndexSelected].DeliveryDate
        }
    }
}









