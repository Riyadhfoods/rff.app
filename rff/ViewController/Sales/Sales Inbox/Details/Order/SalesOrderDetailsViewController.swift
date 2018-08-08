//
//  SalesOrderDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

struct SalesOrderItemDetails{
    var orderId: String
    var empCreated: String
    var salesPerson: String
    var customerName: String
    var serialNumber: String
    var itemId: String
    var itemDesc: String
    var unitPrice: String
    var extCast: String
    var qty: String
    var uofm: String
    var lastYear: String
    var yearToDate: String
    var requestDate: String
    var deliveryDate: String
    var comment: String
}

class SalesOrderDetailsViewController: UIViewController {

    // -- MARK: Outlets
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var salesPerson: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let webService = SalesInboxService.instance
    let screenSize = AppDelegate.shared.screenSize
    let cellId = ""
    let cellTitleArray = [
        "Item(s) Details".localize(),
        "Cutomer Credit Details".localize(),
        "User(s) Comment".localize(),
        "Work Flow".localize()]
    
    var itemsDetailsArray = [SalesItemInboxModul]()
    var salesOrderItemDetails = [SalesOrderItemDetails]()
    var customerCreditDetailsArray = [SalesCreditLimmitInboxModul]()
    var userCommentArray = [CommentModul]()
    var workFlowArray = [WorkFlowModul]()
    
    var orderId = ""
    var userId = ""
    
    var emptyArrayElementCheck = [Bool]()
    var emptyArrayCount: CGFloat = 0
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewWidth.constant = screenSize.width - 32
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
        setViewAlignment()
        activityIndicator.startAnimating()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            setupData()
            handleTheHeightOfTableView()
            self.tableView.reloadData()
        }
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Setups
    
    func setupData(){
        itemsDetailsArray = webService.SRI_BindItemGrid(returnid: orderId, querytype: "order")
        for item in itemsDetailsArray{
            salesOrderItemDetails.append(SalesOrderItemDetails(
                orderId: item.Order_ORDERID,
                empCreated: item.Order_EMPCREATED,
                salesPerson: item.Order_SLSPERSONID,
                customerName: item.Order_CUSTNAME,
                serialNumber: item.Order_SERIALNUMBER,
                itemId: item.Order_ITEMID,
                itemDesc: item.Order_ITEMDESC,
                unitPrice: item.Order_UNITCOST,
                extCast: item.Order_EXTCOST,
                qty: item.Order_QTY,
                uofm: item.Order_UOFM,
                lastYear: item.Order_LASTYEAR,
                yearToDate: item.Order_YEARTODATE,
                requestDate: item.Order_REQDATE,
                deliveryDate: item.Order_DELIVERYDATE,
                comment: item.Order_COMMENT))
            
            orderID.text = item.Order_ORDERID
            empCreated.text = item.Order_EMPCREATED
            salesPerson.text = item.Order_SLSPERSONID
            customerName.text = item.Order_CUSTNAME
            date.text = item.Order_DELIVERYDATE
            comment.text = item.Order_COMMENT
        }
        
        customerCreditDetailsArray = webService.SRI_BindCustomerCreditLimit(returnid: orderId, company: "")
        userCommentArray = webService.commonSalesService.BindUserComment_SalesApprovalForm(orderid: orderId)
        workFlowArray = webService.commonSalesService.BindApprovalGrid_SalesApprovalForm(orderid: orderId)
    }
    
    func handleTheHeightOfTableView(){
        emptyArrayElementCheck.append(itemsDetailsArray.isEmpty)
        emptyArrayElementCheck.append(customerCreditDetailsArray.isEmpty)
        emptyArrayElementCheck.append(userCommentArray.isEmpty)
        emptyArrayElementCheck.append(workFlowArray.isEmpty)
        
        for isEmpty in emptyArrayElementCheck{
            if isEmpty{
                emptyArrayCount += 1
            }
        }
        
        let rowHeight: CGFloat = 44 * (4 - emptyArrayCount)
        setTableViewHeight(height: rowHeight)
    }
    
    func setTableViewHeight(height: CGFloat){
        tableViewHeight.constant = height
    }
}

extension SalesOrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesOrderDetails", for: indexPath) as? SalesOrderDetailsCell{
            
            cell.textLabel?.text = cellTitleArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let performId = getId(row: indexPath.row)
        performSegue(withIdentifier: performId, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getId(row: Int) -> String{
        var id = ""
        switch row{
        case 0: id = "showSalesOrderItemDetails"
        case 1: id = "showSalesOrderCustomerCreditDetails"
        case 2: id = "showSalesOrderUserComment"
        case 3: id = "showSalesOrderWorkFlow"
        default: id = ""}
        return id
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSalesOrderItemDetails"{
            if let vc = segue.destination as? SalesOrderItemDetailsViewController{
                vc.salesItemDetails = salesOrderItemDetails
            }
        } else if segue.identifier == "showSalesOrderCustomerCreditDetails" {
            if let vc = segue.destination as? SalesCreditCutomerDetailsViewController{
                vc.customerCreditDetailsArray = customerCreditDetailsArray
            }
        } else if segue.identifier == "showSalesOrderUserComment" {
            if let vc = segue.destination as? SalesUsersCommentViewController{
                vc.userCommentOrderArray = userCommentArray
            }
        } else if segue.identifier == "showSalesOrderWorkFlow" {
            if let vc = segue.destination as? SalesWorkFlowViewController{
                vc.workFlowOrderArray = workFlowArray
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if itemsDetailsArray.isEmpty { return 0 }
        } else if indexPath.row == 1 {
            if customerCreditDetailsArray.isEmpty { return 0 }
        } else if indexPath.row == 2 {
            if userCommentArray.isEmpty { return 0 }
        } else if indexPath.row == 3 {
            if workFlowArray.isEmpty { return 0 }
        }
        
        if  itemsDetailsArray.isEmpty &&
            customerCreditDetailsArray.isEmpty &&
            userCommentArray.isEmpty &&
            workFlowArray.isEmpty
        { self.tableView.isHidden = true }
        else { self.tableView.isHidden = false }
        return 44
    }
}









