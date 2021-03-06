//
//  WebSalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
protocol ApprovalOrderConfomationDelegate{
    func orderRequestStatus(isApproved: Bool)
    func orderRequestStatus(isRejected: Bool)
}

class CheckSalesApprovalModel{
    var appRetail: String = ""
    var appMarket: String = ""
    var appExport: String = ""
    var appDairy: String = ""
    var approver: String = ""
    var approver1: String = ""
}

class DetailsSalesOrderApprovalViewController: UIViewController, UITextViewDelegate, ItemDetailsDelegate, UITextFieldDelegate {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var requestDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var docId: UITextField!
    @IBOutlet weak var loccode: UITextField!
    @IBOutlet weak var approveAndSaveGBBtn: UIButton!
    @IBOutlet weak var approveAndEnterManBtn: UIButton!
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var rejectAllBtn: UIButton!
    @IBOutlet weak var reportIssueBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var docIdStackView: UIStackView!
    @IBOutlet weak var locCodeStackView: UIStackView!
    @IBOutlet weak var commentStackView: UIStackView!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let webservice = SalesOrderApproveService.instance
    let SAH = SaveApproversHistoryService.instance
    let cellId = "cell_detailsSalesOrderRequest"
    
    let cellTitleArray = [
        "Item(s) Details".localize(),
        "Cutomer Credit Details".localize(),
        "User Comment".localize(),
        "Work Flow".localize()]
    
    var checkSalesApprovalArray = [SalesOrderButtonVisibiltyMudel]()
    var itemsDetailsArray = [OrderApproveItem]()
    
    var customerCreditDetailsArray = [OrderApproveCreditModul]()
    var userCommentArray = [CommentModul]()
    var workFlowArray = [WorkFlowModul]()
    var comboBoxArray = [ComBoxMudel]()
    var isItemsChecked = [Bool]()
    var orderId = ""
    var userId = ""
    var reqDate = ""
    var deliveryDate = ""
    var docIdReceived = ""
    var locCodeReveived = ""
    var checkSalasApproveInfo = CheckSalesApprovalModel()
    var itemsDetails = [SalesOrderItemsDetailsModel]()
    
    var emptyArrayElementCheck = [Bool]()
    var emptyArrayCount: CGFloat = 0
    
    var delegate: ApprovalOrderConfomationDelegate?
    
    func updateItemDeatails(itemsDetails: [SalesOrderItemsDetailsModel]) {
        self.itemsDetails = itemsDetails
    }
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
        
        setbackNavTitle(navItem: navigationItem)
        title = "Approval Form".localize()
        stackViewWidth.constant = AppDelegate.shared.screenSize.width - 32
        userId = AuthServices.currentUserId
        
        requestDate.text = reqDate
        returnDate.text = deliveryDate
        docId.text = docIdReceived
        loccode.text = locCodeReveived
        
        setViewAlignment()
        setUpCommentDisplay()
        commentTextView.delegate = self
        docId.delegate = self
        loccode.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        if itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            setUpData()
            setUserCommentAndSetWorkFlow()
            handleTheHeightOfTableView()
            handleVisibilityOfButtons(comment: "")
            detailsTableView.reloadData()
        }
        if comboBoxArray.isEmpty{
            setupComboBox()
        }
        
        stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Setups
    
    func start(){startLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    
    func setUpData(){
        itemsDetailsArray = webservice.BindOrderItemGridFor_SalesApprovalForm(emp_id: userId, ordernumber: orderId)
        for item in itemsDetailsArray{
            
            itemsDetails.append(SalesOrderItemsDetailsModel(
                orderId: item.OrderID,
                serialNumber: item.SERIALNUMBER,
                itemNumber: item.ITEMNUMBER,
                itemDesc: item.ITEMDESC,
                changePrice: item.CHANGEDPRICE,
                originalPrice: item.ORIGINALPRICE,
                qty: item.QTY,
                unitOfMeasurement: item.UNITOFMEASUREMENT,
                lastYearOrderQty: item.LASTYEARORDERQTY,
                yearToDateOrderQty: item.YEARTODATEORDERQTY,
                total: item.TOTAL,
                requestDate: item.REQUESTDATE,
                deliveryDate: item.DELIVERYDATE))
        }
        
        customerCreditDetailsArray = webservice.BindCustomerCreditGridView_SalesApprovalForm(ordernumber: orderId)
    }
    
    func setupComboBox(){
        comboBoxArray = webservice.BindCombobox(ordernumber: orderId)
        for comboBox in comboBoxArray{
            if comboBox.DocumentId != ""{
                docIdReceived = comboBox.DocumentId
                if !docIdStackView.isHidden{ docId.text = docIdReceived }
            }
            if comboBox.LocationCode != ""{
                locCodeReveived = comboBox.LocationCode
                if !locCodeStackView.isHidden{ loccode.text = locCodeReveived }
            }
        }
    }
    
    func handleVisibilityOfButtons(comment: String){
        checkSalesApprovalArray = webservice.CheckSalesApproval(emp_number: userId, order_number: orderId, comment: comment)
        for checkSaleApproval in checkSalesApprovalArray{
            commentStackView.isHidden = !checkSaleApproval.U_Comment
            docIdStackView.isHidden = !checkSaleApproval.DocId_control_vis
            locCodeStackView.isHidden = !checkSaleApproval.Loc_control_vis
            approveAndSaveGBBtn.isHidden = !checkSaleApproval.Savetogp_btn_vis
            approveAndEnterManBtn.isHidden = !checkSaleApproval.ApproveandEnterManually_btn
            approveBtn.isHidden = !checkSaleApproval.App_btn_vis
            rejectAllBtn.isHidden = !checkSaleApproval.Rej_btn_vis
            reportIssueBtn.isHidden = !checkSaleApproval.Report_btn_vis
            
            checkSalasApproveInfo.approver = checkSaleApproval.Approver
            checkSalasApproveInfo.approver1 = checkSaleApproval.Approver1
            checkSalasApproveInfo.appRetail = checkSaleApproval.App_Retail
            checkSalasApproveInfo.appMarket = checkSaleApproval.App_Market
            checkSalasApproveInfo.appExport = checkSaleApproval.App_Export
            checkSalasApproveInfo.appDairy = checkSaleApproval.App_Diary
        }
    }
    
    func setUpCommentDisplay(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
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
        
        tableViewHeight.constant = 44 * (4 - emptyArrayCount)
    }
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // -- MARK: Helper functions
    
    func getId(row: Int) -> String{
        var id = ""
        switch row{
        case 0: id = "showItemsDetails"
        case 1: id = "showCustomerCreditDetails"
        case 2: id = "showUserComment"
        case 3: id = "showWorkFlow"
        default: id = ""}
        return id
    }
    
    func getArray(row: Int) -> Bool{
        switch row{
        case 0: return itemsDetailsArray.isEmpty
        case 1: return customerCreditDetailsArray.isEmpty
        case 2: return userCommentArray.isEmpty
        case 3: return workFlowArray.isEmpty
        default: return false}
    }
    
    func setUserCommentAndSetWorkFlow(){
        workFlowArray = webservice.commonSalesService.BindApprovalGrid_SalesApprovalForm(orderid: orderId)
        userCommentArray = webservice.commonSalesService.BindUserComment_SalesApprovalForm(orderid: orderId)
    }
    
    func handleSuccessAction(action: @escaping () -> Void){
        self.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            action()
            self.stop()
        })
    }
    
    func runBeforeApproveFinalOrderService(){
        for itemDetail in itemsDetails{
            webservice.BeforeApproveFinalOrder(serialnumber: itemDetail.serialNumber, ordernumber: orderId, checkbox: itemDetail.isItemChecked)
        }
    }
    
    func runApproveFinalOrderAndUpdateValues(comment: String){
        approveResult = webservice.ApproveFinalOrder(orderno: orderId, approver: checkSalasApproveInfo.approver, empno: userId, comment: comment)
        AlertMessage().showAlertMessage(alertTitle: approveResult, alertMessage: "", actionTitle: "Ok", onAction: {
            self.handleSuccessAction {
                
                self.setUserCommentAndSetWorkFlow()
                if (self.approveResult.contains("Successfully")){
                    self.runSaveApproveHistory(buttonType: "btnApprove")
                }
                
                self.navigationController?.popToRootViewController(animated: true)
                if let delegate = self.delegate{
                    delegate.orderRequestStatus(isApproved: true)
                }
            }
        }, cancelAction: nil, self)
    }
    
    func runSaveApproveHistory(buttonType: String){
        var finalResult = ""
        if let lastApprover = workFlowArray.last{
            if lastApprover.WorkFlow_Empid == AuthServices.currentUserId || buttonType == "btnReject" {
                for element in workFlowArray{
                    let result = SAH.SaveRP2ApproversHistory(pid: orderId,
                                                fid: salesOrderApproval_formId,
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
        print(finalResult)
        
//        AlertMessage().showAlertForXTime(alertTitle: finalResult, time: 0.05, tagert: self)
    }
    
    var rejectOrReportIssueResault = ""
    func handleRejectAndReportIssue(comment: String, isRejected: Bool){
        rejectOrReportIssueResault = webservice.Reject_SalesOrderApproval(
            ordernumber: orderId,
            empnumber: userId,
            app_diary: checkSalasApproveInfo.appDairy,
            app_retail: checkSalasApproveInfo.appRetail,
            app_market: checkSalasApproveInfo.appMarket,
            export: checkSalasApproveInfo.appExport,
            approval1: checkSalasApproveInfo.approver1,
            approver: checkSalasApproveInfo.approver,
            comment: comment)

        AlertMessage().showAlertMessage(alertTitle: rejectOrReportIssueResault, alertMessage: "", actionTitle: "Ok", onAction: {
            self.setUserCommentAndSetWorkFlow()
            self.handleSuccessAction {
                
                self.setUserCommentAndSetWorkFlow()
                if self.rejectOrReportIssueResault.contains("successfully") || self.rejectOrReportIssueResault.contains("Successfully"){
                    if isRejected { self.runSaveApproveHistory(buttonType: "btnReject") }
                }
                
                self.navigationController?.popToRootViewController(animated: true)
                if let delegate = self.delegate{
                    delegate.orderRequestStatus(isRejected: true)
                }
            }
        }, cancelAction: nil, self)
    }
    
    // -- MARK: IBActions
    
    var saveToGPReturn = [SaveToGpMudel]()
    var approveResult = ""
    @IBAction func approveAndSaveGBButtonTapped(_ sender: Any) {
        var error = ""
        if locCodeReveived == "" || docIdReceived == "" {
            if docId.isHidden == true && loccode.isHidden == true {
                return
            }

            let alertTitle = "Alert!"
            let messageTitle = "Please enter document Id or location code"

            AlertMessage().showAlertMessage(alertTitle: alertTitle , alertMessage: messageTitle, actionTitle: "Ok", onAction: {
                if let delegate = self.delegate{
                    delegate.orderRequestStatus(isApproved: false)
                }
                return
            }, cancelAction: nil, self)
        } else {
            if let comment = commentTextView.text{
                AlertMessage().showAlertMessage(
                    alertTitle: "Confirmation",
                    alertMessage: "Do you want to approve the order and save it to gp?",
                    actionTitle: "OK",
                    onAction: {
                        self.handleSuccessAction {
                            self.handleVisibilityOfButtons(comment: comment)
                            self.saveToGPReturn = self.webservice.SaveToGp(orderno: self.orderId, combo_loc_code: self.locCodeReveived, combo_doc_id: self.docIdReceived, empnumber: self.userId)
                            self.runBeforeApproveFinalOrderService()
                            
                            for saveReturn in self.saveToGPReturn{
                                self.approveAndSaveGBBtn.isHidden = !saveReturn.Savetogp_btn_vis
                                self.approveAndEnterManBtn.isHidden = !saveReturn.ApproveandEnterManually_btn
                                
                                if saveReturn.GP_Error != ""{
                                    error = saveReturn.GP_Error
                                    self.docIdStackView.isHidden = true
                                    AlertMessage().showAlertMessage(
                                        alertTitle: "Alert".localize(),
                                        alertMessage: saveReturn.GP_Error,
                                        actionTitle: nil,
                                        onAction: nil,
                                        cancelAction: "OK",
                                        self)
                                    if let delegate = self.delegate{
                                        delegate.orderRequestStatus(isApproved: false)
                                    }
                                    return
                                }
                            }
                            if error == "" {
                                self.runApproveFinalOrderAndUpdateValues(comment: comment)
                            }
                        }
                }, cancelAction: "Cancel", self)
            }
        }
    }
    
    @IBAction func approveAndEnterManButtonTapped(_ sender: Any) {
        if let comment = commentTextView.text{
            AlertMessage().showAlertMessage(
                alertTitle: "Confirmation",
                alertMessage: "Do you want to approve the order?",
                actionTitle: "OK",
                onAction: {
                     self.handleSuccessAction {
                        self.handleVisibilityOfButtons(comment: comment)
                        self.runBeforeApproveFinalOrderService()
                        self.runApproveFinalOrderAndUpdateValues(comment: comment)
                    }
            }, cancelAction: "Cancel", self)
        }
    }
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        if let comment = commentTextView.text{
            AlertMessage().showAlertMessage(
                alertTitle: "Confirmation",
                alertMessage: "Do you want to approve the order?",
                actionTitle: "OK",
                onAction: {
                    self.handleSuccessAction {
                        self.handleVisibilityOfButtons(comment: comment)
                        self.runBeforeApproveFinalOrderService()
                        self.runApproveFinalOrderAndUpdateValues(comment: comment)
                    }
            }, cancelAction: "Cancel", self)
        }
    }
    
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
        if let comment = commentTextView.text{
            AlertMessage().showAlertMessage(
                alertTitle: "Confirmation",
                alertMessage: "Do you want to reject the order?",
                actionTitle: "OK",
                onAction: {
                    self.handleSuccessAction {
                        self.handleVisibilityOfButtons(comment: comment)
                        self.handleRejectAndReportIssue(comment: comment, isRejected: true)
                    }
            }, cancelAction: "Cancel", self)
        }
    }
    
    @IBAction func reportIssueButtonTapped(_ sender: Any) {
        if let comment = commentTextView.text{
            AlertMessage().showAlertMessage(
                alertTitle: "Confirmation",
                alertMessage: "Do you want to report an issue with order?",
                actionTitle: "OK",
                onAction: {
                    self.handleSuccessAction {
                        self.handleVisibilityOfButtons(comment: comment)
                        self.handleRejectAndReportIssue(comment: comment, isRejected: false)
                    }
            }, cancelAction: "Cancel", self)
        }
    }
}


extension DetailsSalesOrderApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DetailsSalesOrderApprovalCell{
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
            if itemsDetailsArray.isEmpty{ return 0 }
        } else if indexPath.row == 1 {
            if customerCreditDetailsArray.isEmpty{ return 0 }
        } else if indexPath.row == 2 {
            if userCommentArray.isEmpty{ return 0 }
        } else if indexPath.row == 3 {
            if workFlowArray.isEmpty{ return 0 }
        }
        
        if  itemsDetailsArray.isEmpty &&
            customerCreditDetailsArray.isEmpty &&
            userCommentArray.isEmpty &&
            workFlowArray.isEmpty
        { detailsTableView.isHidden = true }
        else { detailsTableView.isHidden = false }
        return 44
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemsDetails"{
            if let vc = segue.destination as? ItemsDetailsViewController{
                vc.orderId = self.orderId
                vc.itemsDetails = self.itemsDetails
            }
        } else if segue.identifier == "showCustomerCreditDetails" {
            if let vc = segue.destination as? CustomerCreditDetailsViewController{
                vc.customerCreditDetailsArray = self.customerCreditDetailsArray
            }
        } else if segue.identifier == "showUserComment" {
            if let vc = segue.destination as? UserCommentViewController{
                vc.userCommentArray = self.userCommentArray
            }
        } else {
            if let vc = segue.destination as? WorkFlowViewController{
                vc.workFlowArray = self.workFlowArray
            }
        }
    }
}

extension DetailsSalesOrderApprovalViewController{
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











