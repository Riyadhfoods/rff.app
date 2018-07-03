//
//  DetailsSalesReturnApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var invoiceDetails = [SalesReturnItemsDetailsModel]()
class DetailsSalesReturnApprovalViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

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
    var isItemsChecked = [Bool]()
    var userId = ""
    var returnId = ""
    var requestDateString = ""
    var returnDateString = ""
    
    var isThereItems = false
    var isThereCustomerCredit = false
    var isThereUserComment = false
    var isThereWorkFlow = false
    var remainRows: CGFloat = 4
    
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
        //itemsDetailsArray.isEmpty && customerCreditDetailsArray.isEmpty &&
        if  userCommentArray.isEmpty && workFlowArray.isEmpty{
            
            userCommentArray = webService.SRA_BindUserGrid(empno: userId, returnid: returnId)
            isThereUserComment = !userCommentArray.isEmpty
            
            workFlowArray = webService.SRA_BindApproverGrid(empno: userId, returnid: returnId)
            isThereWorkFlow = !workFlowArray.isEmpty
            
            remainRows = 4
            DetailsSalesReturnTableview.reloadData()
            activityIndicator.stopAnimating()
        }
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
        
        requestDate.text = requestDateString
        ReturnDate.text = returnDateString
    }
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        }
        return true
    }
    
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
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let rowHeight: CGFloat = 44
//
//        if !isThereItems{
//            if indexPath.row == 0 {
//                return 0
//            }
//        } else if !isThereCustomerCredit{
//            if indexPath.row == 1 {
//                return 0
//            }
//        } else if !isThereUserComment{
//            if indexPath.row == 2 {
//                return 0
//            }
//        } else if !isThereWorkFlow{
//            if indexPath.row == 3 {
//                return 0
//            }
//        }
////        if  !isThereItems && !isThereCustomerCredit && !isThereUserComment && !isThereWorkFlow { DetailsSalesReturnTableview.isHidden = true }
////        else { DetailsSalesReturnTableview.isHidden = false }
//        return 44
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showItemsDetails"{
//            if let vc = segue.destination as? ItemsDetailsViewController{
//                vc.orderId = self.orderId
//            }
//        } else if segue.identifier == "showCustomerCreditDetails" {
//            if let vc = segue.destination as? CustomerCreditDetailsViewController{
//                vc.customerCreditDetailsArray = self.customerCreditDetailsArray
//            }
//        } else
        if segue.identifier == "showUserCommentReturnApproval" {
            if let vc = segue.destination as? UserCommentReturnViewController{
                vc.userCommentArray = self.userCommentArray
            }
        } else if segue.identifier == "showWorkFlowReturnApproval"{
            if let vc = segue.destination as? WorkFlowReturnViewController{
                vc.workFlowArray = self.workFlowArray
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
    
    // -- MARK: IBActions
    @IBAction func approveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
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






