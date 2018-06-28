//
//  WebSalesOrderApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 11/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import WebKit

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
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let cellId = "cell_detailsSalesOrderRequest"
    let cellTitleArray = ["Item(s) Details", "Cutomer Credit Details", "User Comment", "Work Flow"]
    var buttonVisibilityArray: [SalesModel] = [SalesModel]()
    var itemsDetailsArray = [SalesModel]()
    var customerCreditDetailsArray = [SalesModel]()
    var userCommentArray = [SalesModel]()
    var workFlowArray = [SalesModel]()
    var comboBoxArray = [SalesModel]()
    var orderId = ""
    var userId = ""
    var reqDate = ""
    var deliveryDate = ""
    var docIdReceived = ""
    var locCodeReveived = ""
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomNavAndBackButton(navItem: navigationItem, title: "Aprroval Form")
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let currentUserId = AuthServices.currentUserId{
            userId = currentUserId
        }
        
        setupComboBox()
        
        requestDate.text = reqDate
        returnDate.text = deliveryDate
        docId.text = docIdReceived
        loccode.text = locCodeReveived
        
        handleVisibilityOfButtons()
        setViewAlignment()
        setUpCommentDisplay()
        commentTextView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty && userCommentArray.isEmpty && workFlowArray.isEmpty{
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            itemsDetailsArray = webservice.BindOrderItemGridFor_SalesApprovalForm(emp_id: userId, ordernumber: orderId)
            customerCreditDetailsArray = webservice.BindCustomerCreditGridView_SalesApprovalForm(ordernumber: orderId)
            userCommentArray = webservice.BindUserComment_SalesApprovalForm(orderid: orderId)
            workFlowArray = webservice.BindApprovalGrid_SalesApprovalForm(orderid: orderId)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
        buttonVisibilityArray = webservice.CheckSalesApproval(emp_number: orderId, order_number: orderId, comment: "")
        for buttonVisiblity in buttonVisibilityArray{
            commentStackView.isHidden = setButtonVisibility(booleanString: buttonVisiblity.U_Comment)
            docIdStackView.isHidden = setButtonVisibility(booleanString: buttonVisiblity.DocId_control_vis)
            locCodeStackView.isHidden = setButtonVisibility(booleanString: buttonVisiblity.Loc_control_vis)
            approveAndSaveGBBtn.isHidden = setButtonVisibility(booleanString: buttonVisiblity.Savetogp_btn_vis)
            approveAndEnterManBtn.isHidden = setButtonVisibility(booleanString: buttonVisiblity.ApproveandEnterManually_btn)
            approveBtn.isHidden = setButtonVisibility(booleanString: buttonVisiblity.App_btn_vis)
            rejectAllBtn.isHidden = setButtonVisibility(booleanString: buttonVisiblity.Rej_btn_vis)
            reportIssueBtn.isHidden = setButtonVisibility(booleanString: buttonVisiblity.Report_btn_vis)
        }
    }
    
    func setButtonVisibility(booleanString: String) -> Bool{
        return !(booleanString == "true")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemsDetails"{
            if let vc = segue.destination as? ItemsDetailsViewController{
                vc.itemsDetailsArray = self.itemsDetailsArray
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
    
    // -- MARK: IBActions
    
    var saveToGPReturn = [SaveToGpModel]()
    @IBAction func approveAndSaveGBButtonTapped(_ sender: Any) {
        saveToGPReturn = webservice.SaveToGp(orderno: userId, combo_loc_code: locCodeReveived, combo_doc_id: docIdReceived, empnumber: userId)
        
        for itemDetail in itemsDetailsArray{
            //webservice.BeforeApproveFinalOrder(serialnumber: <#T##String#>, ordernumber: <#T##String#>, checkbox: <#T##Bool#>)
        }
        for saveReturn in saveToGPReturn{
            approveAndSaveGBBtn.isHidden = !saveReturn.Savetogp_btn_vis
            approveAndEnterManBtn.isHidden = !saveReturn.ApproveandEnterManually_btn
            
            if saveReturn.GP_Error != ""{
                return
            }
            
            
        }
        
    }
    
    @IBAction func approveAndEnterManButtonTapped(_ sender: Any) {
    }
    
    @IBAction func approveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
    }
    
    @IBAction func reportIssueButtonTapped(_ sender: Any) {
    }
    
    @IBAction func exportButtonTapped(_ sender: Any) {
    }
}
