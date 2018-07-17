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
    
    // -- MARK: Variables
    
    let webService = Sales()
    let screenSize = AppDelegate().screenSize
    let cellId = ""
    let cellTitleArray = [
        "Item(s) Details".localize(),
        "Cutomer Credit Details".localize(),
        "User(s) Comment".localize(),
        "Work Flow".localize()]
    
    var checkSalesApprovalArray: [SalesModel] = [SalesModel]()
    var itemsDetailsArray = [SalesReturn]()
    var salesOrderItemDetails = [SalesOrderItemDetails]()
    var customerCreditDetailsArray = [SalesReturn]()
    var userCommentArray = [SalesModel]()
    var workFlowArray = [SalesModel]()
    
    var orderId = ""
    var userId = ""
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewWidth.constant = screenSize.width - 32
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        
        activityIndicator.startAnimating()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            setupData()
//            handleTheHeightOfTableView()
//            self.tableView.reloadData()
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
                orderId: item.SOI_ORDERID,
                empCreated: item.SOI_EMPCREATED,
                salesPerson: item.SOI_SLSPERSONID,
                customerName: item.SOI_CUSTNAME,
                serialNumber: item.SOI_SERIALNUMBER,
                itemId: item.SOI_ITEMID,
                itemDesc: item.SOI_ITEMDESC,
                unitPrice: item.SOI_UNITCOST,
                extCast: item.SOI_EXTCOST,
                qty: item.SOI_QTY,
                uofm: item.SOI_UOFM,
                lastYear: item.SOI_LASTYEAR,
                yearToDate: item.SOI_YEARTODATE,
                requestDate: item.SOI_REQDATE,
                deliveryDate: item.SOI_DELIVERYDATE,
                comment: item.SOI_COMMENT))
            
            orderID.text = item.SOI_ORDERID
            empCreated.text = item.SOI_EMPCREATED
            salesPerson.text = item.SOI_SLSPERSONID
            customerName.text = item.SOI_CUSTNAME
            date.text = item.SOI_DELIVERYDATE
            comment.text = item.SOI_COMMENT
        }
        
        customerCreditDetailsArray = webService.SRI_BindCustomerCreditLimit(returnid: orderId, company: "")
        userCommentArray = webService.BindUserComment_SalesApprovalForm(orderid: orderId)
        workFlowArray = webService.BindApprovalGrid_SalesApprovalForm(orderid: orderId)
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
}









