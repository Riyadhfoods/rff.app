//
//  DetailsSalesReturnApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var itemReturnDetails = [SalesReturnItemsDetailsModel]()
class DetailsSalesReturnApprovalViewController: UIViewController, UITextViewDelegate {

    // -- MARK: IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var DetailsSalesReturnTableview: UITableView!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var salesPerson: UILabel!
    @IBOutlet weak var requestDate: UILabel!
    @IBOutlet weak var ReturnDate: UILabel!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var approveButtonOutlet: UIButton!
    @IBOutlet weak var rejectAllButtonOutlet: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variable
    
    let webService = Sales()
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_detailsSalesReturnRequest"
    let cellTitleArray = ["Item(s) Details", "Cutomer Aging", "User Comment", "Work Flow"]
    var itemsDetailsArray = [SalesReturn]()
    var customerCreditDetailsArray = [SalesReturn]()
    var userCommentArray = [SalesReturn]()
    var workFlowArray = [SalesReturn]()
    var loadCompleteArray = [SalesReturn]()
    var loadCompleteArrayWithComment = [SalesReturn]()
    var attachmentArray = [SalesReturn]()
    var isItemsChecked = [Bool]()
    var userId = ""
    var returnId = ""
    var requestDateString = ""
    var returnDateString = ""
    var approver = ""
    
    var emptyArrayElementCheck = [Bool]()
    var emptyArrayCount: CGFloat = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavAndBackButton(navItem: navigationItem, title: "Approval Form", backTitle: nil)
        if let currentUserId = AuthServices.currentUserId{
            userId = currentUserId
        }
        stackviewWidth.constant = screenSize.width - 32
        comment.delegate = self
        
        activityIndicator.startAnimating()
        setViewAlignment()
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            setupData()
            handleTheHeightOfTableView()
            DetailsSalesReturnTableview.reloadData()
        }
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    func setUpViews(){
        comment.text = ""
        comment.layer.cornerRadius = 5.0
        comment.layer.borderColor = mainBackgroundColor.cgColor
        comment.layer.borderWidth = 1
    }
    
    func setupData(){
        itemsDetailsArray = webService.SRA_BindItemGrid(empno: userId, returnid: returnId)
        for itemDetail in itemsDetailsArray{
            itemReturnDetails.append(SalesReturnItemsDetailsModel(
                serialNumber: "0",
                InvoiceNumber: itemDetail.SRA_InvoiceNumber,
                LOTNumber: itemDetail.SRA_LotNumber,
                ItemNumber: itemDetail.SRA_ItemNumber,
                desc: itemDetail.SRA_Description,
                unitPrice: itemDetail.SRA_Unitprice,
                totalCast: itemDetail.SRA_TotalCost,
                qty: itemDetail.SRA_Qty,
                uofm: itemDetail.SRA_UOFM,
                returnType: itemDetail.SRA_ReturnType))
            
            setUpLabelText(label: empCreated, text: itemDetail.SRA_EmpCreated, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: customerName, text: itemDetail.SRA_CustomerName, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: salesPerson, text: itemDetail.SRA_SalesPerson, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: requestDate, text: itemDetail.SRA_ReqDate, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: ReturnDate, text: itemDetail.SRA_ReturnDate, isArrayEmpty: itemsDetailsArray.isEmpty)
            
            print(itemDetail.SRA_CustomerName)
            print(itemDetail.SRA_SalesPerson)
            print(itemDetail.SRA_ReqDate)
        }
        userCommentArray = webService.SRA_BindUserGrid(empno: userId, returnid: returnId)
        workFlowArray = webService.SRA_BindApproverGrid(empno: userId, returnid: returnId)
        
        loadCompleteArray = webService.SRA_ONLOADCOMPLETE(empnumber: "106", returnid: returnId, comment: "")
        for loadComplete in loadCompleteArray{
            approveButtonOutlet.isHidden = !loadComplete.SRA_APPROVE_BTN
            rejectAllButtonOutlet.isHidden = !loadComplete.SRA_REJECT_BTN
            approver = loadComplete.SRA_APPROVER
        }
        attachmentArray = webService.SRA_BindAttachmentGrid(empno: userId, returnid: "664")
        
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
    
    func setUpLabelText(label: UILabel, text: String, isArrayEmpty: Bool){
        label.text = isArrayEmpty ? "     " : text
    }
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        }
        return true
    }
    
    // -- MARK: IBActions
    
    func re_call_onLoadComplete(){
        if let commentText = comment.text{
            if !commentText.isEmpty{
                loadCompleteArrayWithComment = webService.SRA_ONLOADCOMPLETE(empnumber: userId, returnid: returnId, comment: commentText)
            }
        }
    }
    
    var beforeApproveResault = ""
    var approveResault = ""
    @IBAction func approveButtonTapped(_ sender: Any) {
        
        re_call_onLoadComplete()
        for itemDetail in itemReturnDetails{
            beforeApproveResault = webService.SRA_BEFOREAPPROVE(empno: userId, returnid: returnId, gridcheckbox: itemDetail.isItemChecked, serialnumber: itemDetail.serialNumber)
            
            if beforeApproveResault != "" {
                return
            }
            print("before approve result \"\(beforeApproveResault)\" ")
        }
        
//        if let commentText = comment.text{
//            approveResault = webService.SRA_APPROVE(empnumber: userId, returnid: returnId, approver: approver, comment: commentText)
//        }
    }
    
    var rejectResault = ""
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
        
        re_call_onLoadComplete()
        if let commentText = comment.text{
            rejectResault = webService.SRA_REJECT(returnid: returnId, empnumber: userId, comment: commentText, approver: approver)
        }
    }
    
    @IBAction func attachmentButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAttchmentFiles", sender: nil)
    }
    
}

extension DetailsSalesReturnApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DetailsSalesReturnApprovalCell{
            cell.textLabel?.text = cellTitleArray[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowDetailsArray = getArray(row: indexPath.row)
        let performId = getId(row: indexPath.row)
        
        if !rowDetailsArray.isEmpty{
            performSegue(withIdentifier: performId, sender: nil)}
        tableView.deselectRow(at: indexPath, animated: true)
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
        
        if  itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty
        { DetailsSalesReturnTableview.isHidden = true }
        else { DetailsSalesReturnTableview.isHidden = false }
        
        return 44
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemReturnApproval"{
            if let vc = segue.destination as? ItemReturnDetailsViewController{
                vc.itemsDetailsArray = self.itemsDetailsArray
            }
        } else if segue.identifier == "showCustomerAgingReturnApproval" {
            if let vc = segue.destination as? CustomerAgingViewController{
                vc.customerCreditDetailsArray = self.customerCreditDetailsArray
            }
        } else
            if segue.identifier == "showUserCommentReturnApproval" {
            if let vc = segue.destination as? UserCommentReturnViewController{
                vc.userCommentArray = self.userCommentArray
            }
        } else if segue.identifier == "showWorkFlowReturnApproval"{
            if let vc = segue.destination as? WorkFlowReturnViewController{
                vc.workFlowArray = self.workFlowArray
            }
        } else if segue.identifier == "showAttchmentFiles" {
                if let vc = segue.destination as? AttachmentReturnViewController{
                    vc.attachmentArray = self.attachmentArray
                }
        }
    }
    
    // -- MARK: Helper function
    
    func getId(row: Int) -> String{
        var id = ""
        switch row{
        case 0: id = "showItemReturnApproval"
        case 1: id = "showCustomerAgingReturnApproval"
        case 2: id = "showUserCommentReturnApproval"
        case 3: id = "showWorkFlowReturnApproval"
        default: id = ""}
        return id
    }
    
    func getArray(row: Int) -> [SalesReturn]{
        var array = [SalesReturn]()
        switch row{
        case 0: array = itemsDetailsArray
        case 1: array = customerCreditDetailsArray
        case 2: array = userCommentArray
        case 3: array = workFlowArray
        default: array = [SalesReturn]()}
        return array
    }
    
    func setTableViewHeight(height: CGFloat){
        tableViewHeight.constant = height
    }
}

extension DetailsSalesReturnApprovalViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 73, right: 0)
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






