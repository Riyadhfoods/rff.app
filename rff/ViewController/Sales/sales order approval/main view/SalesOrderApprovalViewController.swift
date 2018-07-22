//
//  SalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderApprovalViewController: UIViewController, ApprovalOrderConfomationDelegate {
    
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
    
    var isApproved = false
    var isRejected = false
    
    func orderRequestStatus(isApproved: Bool) {
        self.isApproved = isApproved
    }
    
    func orderRequestStatus(isRejected: Bool) {
        self.isRejected = isRejected
    }
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavAndBackButton(navItem: navigationItem, title: "Sales Order Approval".localize(), backTitle: "Return".localize())
        activityIndicator.startAnimating()
        setViewAlignment()
        
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if salesOrderDetails.isEmpty || isApproved || isRejected{
            getSalesOrderDetails()
        }
        activityIndicator.stopAnimating()
    }
    
    func getSalesOrderDetails(){
        if let userIdInt = Int(AuthServices.currentUserId){
            salesOrderDetails = webService.SalesOrderApprove(empno: userIdInt)
            salesOrdertableview.reloadData()
        }
    }

}

extension SalesOrderApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: salesOrdertableview, isEmpty: salesOrderDetails.count == 0)
        return salesOrderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesOrderApprovalCell{
            
            let salesOrder = salesOrderDetails[indexPath.row]
            cell.orderId.text = salesOrder.OrderID
            cell.empCreated.text = salesOrder.SO_EmpCreated
            cell.customerName.text = salesOrder.SO_CustomerName
            cell.items.text = salesOrder.SO_Items
            cell.date.text = salesOrder.DeliveryDate
            cell.status.text = salesOrder.SO_Status
            cell.comment.text = salesOrder.SO_Comment  == "" ? AppDelegate.noComment : salesOrder.SO_Comment
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
            vc.delegate = self
        }
    }
}









