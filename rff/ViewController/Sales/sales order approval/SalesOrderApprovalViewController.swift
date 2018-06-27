//
//  SalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var salesOrdertableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MAKR: Variables
    
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_salesOrderApproval"
    let webService = Sales()
    
    var salesOrderDetails: [SalesModel] = [SalesModel]()
    var itemsDetailsArray = [SalesModel]()
    var customerCreditDetailsArray = [SalesModel]()
    var userCommentArray = [SalesModel]()
    var workFlowArray = [SalesModel]()
    
    var urlSrtingArray = [String]()
    var rowIndexSelected = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if salesOrderDetails.count == 0{
            emptyMessage(message: "No Data".localize(), viewController: self, tableView: salesOrdertableview)
        }
        return salesOrderDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesOrderApprovalCell{
            cell.orderId.text = salesOrderDetails[indexPath.row].OrderID
            cell.empCreated.text = salesOrderDetails[indexPath.row].SO_EmpCreated
            cell.customerName.text = salesOrderDetails[indexPath.row].SO_CustomerName
            cell.items.text = salesOrderDetails[indexPath.row].SO_Items
            cell.date.text = salesOrderDetails[indexPath.row].DeliveryDate
            cell.status.text = salesOrderDetails[indexPath.row].SO_Status
            cell.comment.text = salesOrderDetails[indexPath.row].SO_Comment
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
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }

}
