//
//  WebSalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import WebKit

var itemsDetails = [SalesOrderItemsDetailsModel]()
class DetailsSalesOrderApprovalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
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
    @IBOutlet weak var exportBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var docIdStackView: UIStackView!
    @IBOutlet weak var locCodeStackView: UIStackView!
    @IBOutlet weak var commentStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let cellId = "cell_detailsSalesOrderRequest"
    let cellTitleArray = ["Item(s) Details", "Cutomer Credit Details", "User Comment", "Work Flow"]
    var checkSalesApprovalArray: [SalesModel] = [SalesModel]()
    var itemsDetailsArray = [SalesModel]()
    
    var customerCreditDetailsArray = [SalesModel]()
    var userCommentArray = [SalesModel]()
    var workFlowArray = [SalesModel]()
    var comboBoxArray = [SalesModel]()
    var isItemsChecked = [Bool]()
    var orderId = ""
    var userId = ""
    var reqDate = ""
    var deliveryDate = ""
    var docIdReceived = ""
    var locCodeReveived = ""
    var checkSalasApproveInfo = CheckSalesApprovalModel()
    
    var isThereItems = false
    var isThereCustomerCredit = false
    var isThereUserComment = false
    var isThereWorkFlow = false
    
    func setItemDetailsArray(itemDetailsArray: [SalesOrderItemsDetailsModel]) {
        itemsDetails = itemDetailsArray
    }
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavAndBackButton(navItem: navigationItem, title: "Approval Form", backTitle: nil)
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        activityIndicator.startAnimating()
        if let currentUserId = AuthServices.currentUserId{
            userId = currentUserId
        }
        
        setupComboBox()
        
        requestDate.text = reqDate
        returnDate.text = deliveryDate
        docId.text = docIdReceived
        loccode.text = locCodeReveived
        
        setViewAlignment()
        setUpCommentDisplay()
        commentTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            
            itemsDetailsArray = webservice.BindOrderItemGridFor_SalesApprovalForm(emp_id: userId, ordernumber: orderId)
            isThereItems = !itemsDetailsArray.isEmpty
            for item in itemsDetailsArray{
                
                itemsDetails.append(SalesOrderItemsDetailsModel(
                    orderId: item.OrderID,
                    serialNumber: item.SOA_SERIALNUMBER,
                    itemNumber: item.SOA_ITEMNUMBER,
                    itemDesc: item.SOA_ITEMDESC,
                    changePrice: item.SOA_CHANGEDPRICE,
                    originalPrice: item.SOA_ORIGINALPRICE,
                    qty: item.SOA_QTY,
                    unitOfMeasurement: item.SOA_UNITOFMEASUREMENT,
                    lastYearOrderQty: item.SOA_LASTYEARORDERQTY,
                    yearToDateOrderQty: item.SOA_YEARTODATEORDERQTY,
                    total: item.SOA_TOTAL,
                    requestDate: item.SOA_REQUESTDATE,
                    deliveryDate: item.SOA_DELIVERYDATE))
            }
            
            customerCreditDetailsArray = webservice.BindCustomerCreditGridView_SalesApprovalForm(ordernumber: orderId)
            isThereCustomerCredit = !customerCreditDetailsArray.isEmpty
            setUserCommentAndSetWorkFlow()
            handleVisibilityOfButtons()
            detailsTableView.reloadData()
            activityIndicator.stopAnimating()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Setups
    
    func setupComboBox(){
        comboBoxArray = webservice.BindCombobox(ordernumber: orderId)
        for comboBox in comboBoxArray{
            if comboBox.DocumentId != ""{
               docIdReceived = comboBox.DocumentId
            }
            if comboBox.LocationCode != ""{
                locCodeReveived = comboBox.LocationCode
            }
        }
    }
    
    func handleVisibilityOfButtons(){
        checkSalesApprovalArray = webservice.CheckSalesApproval(emp_number: orderId, order_number: orderId, comment: "")
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
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DetailsSalesOrderApprovalCell{
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let rowHeight: CGFloat = 44
//
//        if !isThereItems{
//            if indexPath.row == 0 {
//                setTableViewHeight(height: rowHeight * 3)
//                return 0
//            }
//        } else if !isThereCustomerCredit{
//            if indexPath.row == 1 {
//                setTableViewHeight(height: rowHeight * 3)
//                return 0
//            }
//        } else if !isThereUserComment{
//            if indexPath.row == 2 {
//                setTableViewHeight(height: rowHeight * 3)
//                return 0
//            }
//        } else if !isThereWorkFlow{
//            if indexPath.row == 3 {
//                setTableViewHeight(height: rowHeight * 3)
//                return 0
//            }
//        } else {
//            setTableViewHeight(height: rowHeight * 4)
//        }
//
//        if  !isThereItems && !isThereCustomerCredit && !isThereUserComment && !isThereWorkFlow { detailsTableView.isHidden = true }
//        else { detailsTableView.isHidden = false }
//        return 44
//    }
    
    func setTableViewHeight(height: CGFloat){
        tableViewHeight.constant = height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemsDetails"{
            if let vc = segue.destination as? ItemsDetailsViewController{
                vc.orderId = self.orderId
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
            if let vc = segue.destination as?WorkFlowViewController{
                vc.workFlowArray = self.workFlowArray
            }
        }
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
    
    func getArray(row: Int) -> [SalesModel]{
        var array = [SalesModel]()
        switch row{
        case 0: array = itemsDetailsArray
        case 1: array = customerCreditDetailsArray
        case 2: array = userCommentArray
        case 3: array = workFlowArray
        default: array = [SalesModel]()}
        return array
    }
    
    func setUserCommentAndSetWorkFlow(){
        userCommentArray = webservice.BindUserComment_SalesApprovalForm(orderid: orderId)
        isThereUserComment = !userCommentArray.isEmpty
        workFlowArray = webservice.BindApprovalGrid_SalesApprovalForm(orderid: orderId)
        isThereWorkFlow = !workFlowArray.isEmpty
    }
    
    func runBeforeApproveFinalOrderService(){
        for itemDetail in itemsDetails{
            webservice.BeforeApproveFinalOrder(serialnumber: itemDetail.serialNumber, ordernumber: orderId, checkbox: itemDetail.isItemChecked)
        }
    }
    
    func runApproveFinalOrderAndUpdateValues(){
        guard let commentText = commentTextView.text else { return }
        approveResult = webservice.ApproveFinalOrder(orderno: orderId, approver: checkSalasApproveInfo.approver, empno: userId, comment: commentText)
        AlertMessage().showAlertMessage(alertTitle: approveResult, alertMessage: "", actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
        updateValues()
    }
    
    func updateValues(){
        setUserCommentAndSetWorkFlow()
    }
    
    var rejectOrReportIssueResault = ""
    func handleRejectAndReportIssue(){
        guard let commentText = commentTextView.text else { return }
        rejectOrReportIssueResault = webservice.Reject_SalesOrderApproval(
            ordernumber: orderId,
            empnumber: userId,
            app_diary: checkSalasApproveInfo.appDairy,
            app_retail: checkSalasApproveInfo.appRetail,
            app_market: checkSalasApproveInfo.appMarket,
            export: checkSalasApproveInfo.appExport,
            approval1: checkSalasApproveInfo.approver1,
            approver: checkSalasApproveInfo.approver,
            comment: commentText)

        AlertMessage().showAlertMessage(alertTitle: rejectOrReportIssueResault, alertMessage: "", actionTitle: "Ok", onAction: {
            self.updateValues()
            self.navigationController?.popToRootViewController(animated: true)
        }, cancelAction: nil, self)
    }
    
    // -- MARK: IBActions
    
    var saveToGPReturn = [SaveToGpModel]()
    var approveResult = ""
    @IBAction func approveAndSaveGBButtonTapped(_ sender: Any) {
//        if locCodeReveived == "" || docIdReceived == "" {
//            if docId.isHidden == true && loccode.isHidden == true {
//                return
//            }
//
//            let alertTitle = "Alert!"
//            let messageTitle = "Please enter document Id or location code"
//
//            AlertMessage().showAlertMessage(alertTitle: alertTitle , alertMessage: messageTitle, actionTitle: "Ok", onAction: {
//                return
//            }, cancelAction: nil, self)
//        }
//
//        saveToGPReturn = webservice.SaveToGp(orderno: orderId, combo_loc_code: locCodeReveived, combo_doc_id: docIdReceived, empnumber: userId)
//
//        runBeforeApproveFinalOrderService()
//
//        for saveReturn in saveToGPReturn{
//            approveAndSaveGBBtn.isHidden = !saveReturn.Savetogp_btn_vis
//            approveAndEnterManBtn.isHidden = !saveReturn.ApproveandEnterManually_btn
//
//            if saveReturn.GP_Error != ""{
//                return
//            }
//        }
//
//        runApproveFinalOrderAndUpdateValues()
    }
    
    @IBAction func approveAndEnterManButtonTapped(_ sender: Any) {
        runBeforeApproveFinalOrderService()
        runApproveFinalOrderAndUpdateValues()
    }
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        runBeforeApproveFinalOrderService()
        runApproveFinalOrderAndUpdateValues()
    }
    
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
        handleRejectAndReportIssue()
    }
    
    @IBAction func reportIssueButtonTapped(_ sender: Any) {
        handleRejectAndReportIssue()
    }
    
    @IBAction func exportButtonTapped(_ sender: Any) {
        for item in itemsDetails{
            print(item)
        }
        
    }
    
    
}












