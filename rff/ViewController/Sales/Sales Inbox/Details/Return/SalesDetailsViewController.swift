//
//  SalesDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

struct SalesItemDetails{
    var serialNumber: String
    var InvoiceNumber: String
    var LOTNumber: String
    var ItemNumber: String
    var desc: String
    var unitPrice: String
    var totalCast: String
    var qty: String
    var uofm: String
    var invoiceDate: String
    var returnType: String
}

class SalesDetailsViewController: UIViewController {
    
    // -- MARK: IBOutlet
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var salesPerson: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var returnType: UILabel!
    @IBOutlet weak var requestDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variable
    
    let webService = Sales()
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_salesDetails"
    let cellTitleArray = [
        "Item(s) Details".localize(),
        "Cutomer Aging".localize(),
        "User Comment".localize(),
        "Work Flow".localize()]
    var itemsDetailsArray = [SalesReturn]()
    var customerCreditDetailsArray = [SalesReturn]()
    var userCommentArray = [SalesReturn]()
    var workFlowArray = [SalesReturn]()
    var salesItemDetails = [SalesItemDetails]()
    var returnId = ""
    var userId = ""
    var empId = ""
    var barTitle = ""
    
    var emptyArrayElementCheck = [Bool]()
    var emptyArrayCount: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = barTitle
        setbackNavTitle(navItem: navigationItem)
        if let currentUserId = AuthServices.currentUserId{
            userId = currentUserId
        }
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
    
    // -- MARK: Set ups
    
    var count = 0
    func setupData(){
        itemsDetailsArray = webService.SRI_BindItemGrid(returnid: returnId)
        for itemDetail in itemsDetailsArray{
            salesItemDetails.append(SalesItemDetails(
                serialNumber: "\(count)",
                InvoiceNumber: itemDetail.SRA_InvoiceNumber,
                LOTNumber: itemDetail.SRA_LotNumber,
                ItemNumber: itemDetail.SRA_ItemNumber,
                desc: itemDetail.SRA_ItemDesc,
                unitPrice: itemDetail.SRA_Unitprice,
                totalCast: itemDetail.SRA_ExtPrice,
                qty: itemDetail.SRA_Qty,
                uofm: itemDetail.SRA_UOFM,
                invoiceDate: itemDetail.SRA_InvoiceDate,
                returnType: itemDetail.SRA_ReturnType))
            
                setUpLabelText(label: orderID, text: returnId, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: empCreated, text: empId, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: customerName, text: itemDetail.SRA_CustomerName, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: salesPerson, text: itemDetail.SRA_SLSPersonName, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: returnType, text: itemDetail.SRA_ReturnType, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: requestDate, text: itemDetail.SRA_ReqDate, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: returnDate, text: itemDetail.SRA_ReturnDate, isArrayEmpty: itemsDetailsArray.isEmpty)
                setUpLabelText(label: comment, text: itemDetail.SRA_Comment, isArrayEmpty: itemsDetailsArray.isEmpty)
            
            count += 1
        }
        customerCreditDetailsArray = webService.SRI_BindCustomerCreditLimit(returnid: returnId, company: "")
        userCommentArray = webService.SRA_BindUserGrid(empno: userId, returnid: returnId)
        workFlowArray = webService.SRA_BindApproverGrid(empno: userId, returnid: returnId)
    }
    
    func setUpLabelText(label: UILabel, text: String, isArrayEmpty: Bool){
        label.text = isArrayEmpty ? "     " : text
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

extension SalesDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SalesDetailsCell{
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
        case 0: id = "showSalesItemDetails"
        case 1: id = "showSalesCustomerCreditDetails"
        case 2: id = "showSalesUserComment"
        case 3: id = "showSalesWorkFlow"
        default: id = ""}
        return id
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSalesItemDetails"{
            if let vc = segue.destination as? SalesItemDetailsViewController{
               vc.salesItemDetails = salesItemDetails
            }
        } else if segue.identifier == "showSalesCustomerCreditDetails" {
            if let vc = segue.destination as? SalesCreditCutomerDetailsViewController{
                vc.customerCreditDetailsArray = customerCreditDetailsArray
            }
        } else if segue.identifier == "showSalesUserComment" {
            if let vc = segue.destination as? SalesUsersCommentViewController{
                vc.userCommentArray = userCommentArray
            }
        } else if segue.identifier == "showSalesWorkFlow" {
            if let vc = segue.destination as? SalesWorkFlowViewController{
                vc.workFlowArray = workFlowArray
            }
        }
    }
}

extension SalesDetailsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
            self.scrollView.contentInset = contentInset
        }, onHide: { _ in
            self.scrollView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}








