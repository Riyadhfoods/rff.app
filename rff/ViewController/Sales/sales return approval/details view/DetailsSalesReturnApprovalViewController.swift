//
//  DetailsSalesReturnApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol ApprovalConfomationDelegate{
    func returnRequestStatus(isApproved: Bool)
    func returnRequestStatus(isRejected: Bool)
}

class DetailsSalesReturnApprovalViewController: UIViewController, UITextViewDelegate, ItemUpdatedValuesDelegate {

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
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variable
    
    let webService = SalesReturnApproveService.instance
    let SAH = SaveApproversHistoryService.instance
    let screenSize = AppDelegate.shared.screenSize
    let cellId = "cell_detailsSalesReturnRequest"
    
    let cellTitleArray = [
        "Item(s) Details".localize(),
        "Cutomer Aging".localize(),
        "User Comment".localize(),
        "Work Flow".localize()]
    
    var itemsDetailsArray = [ReturnApproveItemModel]()
    var customerCreditDetailsArray = [ReturnApproveCreditModul]()
    var userCommentArray = [CommentModul]()
    var workFlowArray = [WorkFlowModul]()
    var loadCompleteArray = [OnLoandModul]()
    var loadCompleteArrayWithComment = [OnLoandModul]()
    var attachmentArray = [ReturnApproveAttachment]()
    var itemReturnDetails = [SalesReturnItemsDetailsModel]()
    var isItemsChecked = [Bool]()
    var userId = ""
    var returnId = ""
    var requestDateString = ""
    var returnDateString = ""
    var approver = ""
    
    var emptyArrayElementCheck = [Bool]()
    var emptyArrayCount: CGFloat = 0
    
    var delegate: ApprovalConfomationDelegate?
    
    func updateItemArray(itemReturnDetails: [SalesReturnItemsDetailsModel]) {
        self.itemReturnDetails = itemReturnDetails
    }
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setbackNavTitle(navItem: navigationItem)
        title = "Approval Form".localize()
        
        userId = AuthServices.currentUserId
        
        stackviewWidth.constant = screenSize.width - 32
        comment.delegate = self
        
        for item in itemReturnDetails{
            item.isItemChecked = true
        }
        
        start()
        setViewAlignment()
        setUpViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        if  itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            setupData()
            handleTheHeightOfTableView()
            DetailsSalesReturnTableview.reloadData()
        }
        stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    func start(){startLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    
    func setUpViews(){
        comment.text = ""
        comment.layer.cornerRadius = 5.0
        comment.layer.borderColor = mainBackgroundColor.cgColor
        comment.layer.borderWidth = 1
    }
    
    var count = 1
    func setupData(){
        itemsDetailsArray = webService.SRA_BindItemGrid(empno: userId, returnid: returnId)
        for itemDetail in itemsDetailsArray{
            itemReturnDetails.append(SalesReturnItemsDetailsModel(
                serialNumber: itemDetail.SerialNumber,
                InvoiceNumber: itemDetail.InvoiceNumber,
                LOTNumber: itemDetail.LotNumber,
                ItemNumber: itemDetail.ItemNumber,
                desc: itemDetail.Description,
                unitPrice: itemDetail.Unitprice,
                totalCast: itemDetail.TotalCost,
                qty: itemDetail.Qty,
                uofm: itemDetail.UOFM,
                returnType: itemDetail.ReturnType))
            
            setUpLabelText(label: empCreated, text: itemDetail.EmpCreated, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: customerName, text: itemDetail.CustomerName, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: salesPerson, text: itemDetail.SalesPerson, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: requestDate, text: itemDetail.ReqDate, isArrayEmpty: itemsDetailsArray.isEmpty)
            setUpLabelText(label: ReturnDate, text: itemDetail.ReturnDate, isArrayEmpty: itemsDetailsArray.isEmpty)
            
            customerCreditDetailsArray = webService.SRR_BindCustomerAging(customer_no: itemDetail.CustomerName)
            count += 1
        }
        userCommentArray = webService.commonSalesService.SRA_BindUserGrid(empno: userId, returnid: returnId)
        workFlowArray = webService.commonSalesService.SRA_BindApproverGrid(empno: userId, returnid: returnId)
        
        loadCompleteArray = webService.SRA_ONLOADCOMPLETE(empnumber: userId, returnid: returnId, comment: "")
        for loadComplete in loadCompleteArray{
            approveButtonOutlet.isHidden = !loadComplete.APPROVE_BTN
            rejectAllButtonOutlet.isHidden = !loadComplete.REJECT_BTN
            approver = loadComplete.Approver
        }
        attachmentArray = webService.SRA_BindAttachmentGrid(empno: userId, returnid: returnId)
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
    
    func re_call_onLoadComplete(comment: String){
        loadCompleteArrayWithComment = webService.SRA_ONLOADCOMPLETE(empnumber: userId, returnid: returnId, comment: comment)
        for loadComplete in self.loadCompleteArrayWithComment{
            self.approver = loadComplete.Approver
        }
    }
    
    var beforeApproveResault = ""
    var approveResault = ""
    @IBAction func approveButtonTapped(_ sender: Any) {
        AlertMessage().showAlertMessage(alertTitle: "Confirmation".localize(), alertMessage: "Do you want to approve the order", actionTitle: "OK".localize(), onAction: {
            
            if let commentText = self.comment.text{
                self.re_call_onLoadComplete(comment: commentText)
                for itemDetail in self.itemReturnDetails{
                    // serial number start with 1
                    self.beforeApproveResault = self.webService.SRA_BEFOREAPPROVE(empno: self.userId, returnid: self.returnId, gridcheckbox: itemDetail.isItemChecked, serialnumber: itemDetail.serialNumber)
                    print("before approve result \"\(self.beforeApproveResault)\" ")
                    if self.beforeApproveResault != "" {
                        AlertMessage().showAlertMessage(alertTitle: "Alert".localize(), alertMessage: self.beforeApproveResault, actionTitle: nil, onAction: nil, cancelAction: "OK", self)
                        return
                    }
                }
            
                self.approveResault = self.webService.SRA_APPROVE(empnumber: self.userId, returnid: self.returnId, approver: self.approver, comment: commentText)
                print("After approval result \(self.approveResault)")
                if self.approveResault != "" {
                    AlertMessage().showAlertMessage(alertTitle: "Error".localize(), alertMessage: self.approveResault, actionTitle: nil, onAction: nil, cancelAction: "OK", self)
                    if self.delegate != nil {
                        self.delegate?.returnRequestStatus(isApproved: false)
                    }
                } else {
                    AlertMessage().showAlertMessage(alertTitle: "Saved".localize(), alertMessage: "Order Id".localize() + " \(self.returnId) " + "approved successfully".localize(), actionTitle: "OK", onAction: {
                        self.handleSuccessAction {
                            
                            // TODO: Save to history
                            self.workFlowArray = self.webService.commonSalesService.SRA_BindApproverGrid(empno: self.userId, returnid: self.returnId)
                            self.runSaveApproveHistory(buttonType: "btnApproved")
                            
                            self.navigationController?.popToRootViewController(animated: true)
                            if let delegate = self.delegate {
                                delegate.returnRequestStatus(isApproved: true)
                            }
                        }
                        
                    }, cancelAction: nil, self)
                }
            }
        }, cancelAction: "Cancel".localize(), self)
        
        
    }
    
    var rejectResault = ""
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
        AlertMessage().showAlertMessage(alertTitle: "Confirmation".localize(), alertMessage: "Do you want to reject the order".localize(), actionTitle: "OK", onAction: {
            
            if let commentText = self.comment.text{
                self.re_call_onLoadComplete(comment: commentText)
                self.rejectResault = self.webService.SRA_REJECT(returnid: self.returnId, empnumber: self.userId, comment: commentText, approver: self.approver)
                print("reject result \"\(self.approveResault)\"")
                if self.rejectResault != ""{
                    if let delegate = self.delegate {
                        delegate.returnRequestStatus(isRejected: false)
                    }
                } else {
                    AlertMessage().showAlertMessage(alertTitle: "Saved".localize(), alertMessage: "Order Id".localize() + " \(self.returnId) " + "rejected successfully".localize(), actionTitle: "OK", onAction: {
                        
                        // TODO: Save to history
                        self.workFlowArray = self.webService.commonSalesService.SRA_BindApproverGrid(empno: self.userId, returnid: self.returnId)
                        self.runSaveApproveHistory(buttonType: "btnReject")
                        
                        self.handleSuccessAction {
                            self.navigationController?.popToRootViewController(animated: true)
                            if let delegate = self.delegate {
                                delegate.returnRequestStatus(isRejected: true)
                            }
                        }
                    }, cancelAction: nil, self)
                }
            }
        }, cancelAction: "Cancel", self)
    }
    
    @IBAction func attachmentButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showAttchmentFiles", sender: nil)
    }
 
    func handleSuccessAction(action: @escaping () -> Void){
        self.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            action()
            self.stop()
        })
    }
    
    func runSaveApproveHistory(buttonType: String){
        var finalResult = ""
        if let lastApprover = workFlowArray.last{
            if lastApprover.WorkFlow_Empid == AuthServices.currentUserId || buttonType == "btnReject" {
                for element in workFlowArray{
                    let result = SAH.SaveRP2ApproversHistory(pid: returnId,
                                                             fid: salesReturnOrder_formId,
                                                             final_emp_id: element.WorkFlow_Empid,
                                                             name: element.WorkFlow_EmpName,
                                                             emp_role: element.WorkFlow_EmpRole,
                                                             final_status: element.WorkFlow_EmpStatus,
                                                             approve_date: element.WorkFlow_EmpTransDate)
                    
                    if result != "" { finalResult = result; break}
                    finalResult = "Saved Successfully"
                }
            }
        }
        
        AlertMessage().showAlertForXTime(alertTitle: finalResult, time: 0.05, tagert: self)
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
            cell.textLabel?.textAlignment = LanguageManger.isArabicLanguage ? .right : .left
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let performId = getId(row: indexPath.row)
        
        if !getArray(row: indexPath.row){
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
        
        if  itemsDetailsArray.isEmpty &&
            customerCreditDetailsArray.isEmpty &&
            userCommentArray.isEmpty &&
            workFlowArray.isEmpty
        { DetailsSalesReturnTableview.isHidden = true }
        else { DetailsSalesReturnTableview.isHidden = false }
        return 44
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemReturnApproval"{
            if let vc = segue.destination as? ItemReturnDetailsViewController{
                vc.itemReturnDetails = self.itemReturnDetails
                vc.delegate = self
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
    
    func getArray(row: Int) -> Bool{
        switch row{
        case 0: return itemsDetailsArray.isEmpty
        case 1: return customerCreditDetailsArray.isEmpty
        case 2: return userCommentArray.isEmpty
        case 3: return workFlowArray.isEmpty
        default: return false }
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






