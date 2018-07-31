//
//  InboxApprovalFormViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol VacApproveActionDelegate{
    func approveAction(isSuccess: Bool, row: Int, categorySelected: Int)
}

class InboxApprovalFormViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    // -- MARK: Variables
    
    let webserviceForVac = VacactionApprovalService.shared
    let webserviceForLoan = LoanApprovalService.shared
    var listFormId: Int = 0
    var cellRow = 0
    var categorySelected = 0
    var pid = ""
    let cellId = "cell_inboxApprovalForm"
    let cellTitleArrayForVac = ["Employee General Information".localize(),
                                "Leave Details".localize(),
                                "For Administrative Use Only".localize(),
                                "Companions Details".localize(),
                                "Settlement and Ticket Details".localize(),
                                "User Comment".localize(),
                                "Work Flow".localize()]
    let cellTitleArrayForLoan = ["Employee Information".localize(),
                                 "Previous/New Loan Details".localize(),
                                 "Loan Details".localize(),
                                 "User Comment".localize(),
                                 "Work Flow".localize()]
    
    var empVacDetails = [VacationApprovalModul]()
    var empGeneralInfoArrayForVac: EmployeeGeneralInfo?
    var leaveDetailsArrayForVac: LeaveDetails?
    var administrativeUseArrayForVac: AdministrativeUse?
    var companionsDetailsArrayForVac = [CompanionsDetails]()
    var settlementTicketDetailsArrayForVac: SettlementAndTicketDetails?
    var userCommentForVac = [CommentModul]()
    var workFlowForVac = [WorkFlowModul]()
    var workFlowNamesForVac = [String]()
    var editWorkFlowForVac = [WorkFlowModul]()
    
    var empLaonDetails = [LoanApprovalModul]()
    var empInfoForLoan: EmployeeDetails?
    var prevLoanForLoan = [LastLoan]()
    var loanDeatilsForLoan: LoanDetails?
    var userCommentForLoan = [CommentModul]()
    var workFlowForLoan = [WorkFlowModul]()
    var workFlowNamesForLoan = [String]()
    var editWorkFlowForLoan = [WorkFlowModul]()
    
    var appliedEmpName = ""
    var appliedEmpId = ""
    var gridEmpId = ""
    var delegate: VacApproveActionDelegate?
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if LanguageManger.isArabicLanguage{
            title = "نموذج الموافقة"
        } else {  title = "Approval Form" }
        setbackNavTitle(navItem: navigationItem)
        buttonsStackView.isHidden = true
        
        setViewAlignment()
        setupCommentView()
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isVacArrayEmpty() && listFormId == 10{
            setUpVacData()
        } else if isLoanArrayEmpty() && listFormId == 1004{
            setUpLoanData()
        }
        activityIndicator.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // -- MARK: Set ups
    
    func setupCommentView(){
        commentTextView.delegate = self
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
        
        stackViewWidth.constant = AppDelegate.shared.screenSize.width - 32
    }
    
    // -- MARK: Helper Functions
    
    func updateWorkFlowPendingStatus(workFlowArray: [WorkFlowModul], editWorkFlowArray: inout [WorkFlowModul]){
        var isPending = false
        var isRejected = false
        var isOnHold = false
        for workFlow in workFlowArray{
            print(workFlow.WorkFlow_EmpStatus)
            if workFlow.WorkFlow_EmpStatus == "Rejected"{
                isRejected = true
            } else if workFlow .WorkFlow_EmpStatus == "On Hold"{
                gridEmpId = workFlow.WorkFlow_Empid
                isOnHold = true
                if workFlow.WorkFlow_Empid == AuthServices.currentUserId{
                    buttonsStackView.isHidden = false
                }
            }
            
            if workFlow.WorkFlow_EmpStatus == "" && !isRejected && !isOnHold{
                if !isPending{
                    gridEmpId = workFlow.WorkFlow_Empid
                    workFlow.WorkFlow_EmpStatus = "Pending"
                    isPending = true
                    
                    if workFlow.WorkFlow_Empid == AuthServices.currentUserId{
                        buttonsStackView.isHidden = false
                    }
                }
            }
            editWorkFlowArray.append(workFlow)
        }
    }
    
    // MARK: IBActions
    
    func runApproveAction(buttonType: String, actionTitle: String){
        if listFormId == 10{
            approveActionForVac(buttonType: buttonType, actionTitle: actionTitle)
        } else if listFormId == 1004{
            approveActionForLoan(buttonType: buttonType, actionTitle: actionTitle)
        }
    }

    @IBAction func approveButtonTapped(_ sender: Any) {
        
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to approve the request?",
            actionTitle: "OK",
            onAction: {

                ActivityIndicatorDisplayAndAction(activityIndicator: self.activityIndicator, action: {
                    self.runApproveAction(buttonType: "BtnApprove", actionTitle: "approved")
                })

        }, cancelAction: "Cancel", self)
        
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to onhold the request?",
            actionTitle: "OK",
            onAction: {
                
                ActivityIndicatorDisplayAndAction(activityIndicator: self.activityIndicator, action: {
                    self.runApproveAction(buttonType: "BtnHold", actionTitle: "put onhold")
                })
                
        }, cancelAction: "Cancel", self)
        
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to reject the request?",
            actionTitle: "OK",
            onAction: {
                
                ActivityIndicatorDisplayAndAction(activityIndicator: self.activityIndicator, action: {
                    self.runApproveAction(buttonType: "BtnReject", actionTitle: "rejected")
                })
                
        }, cancelAction: "Cancel", self)
    }
}

extension InboxApprovalFormViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listFormId == 10 { return cellTitleArrayForVac.count }
        else if listFormId == 1004 { return cellTitleArrayForLoan.count }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? InboxApprovalFormCell{
            
            var cellTitle = ""
            
            if listFormId == 10 { cellTitle = cellTitleArrayForVac[indexPath.row] }
            else if listFormId == 1004 { cellTitle = cellTitleArrayForLoan[indexPath.row] }
            
            cell.textLabel?.text = cellTitle
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if listFormId == 10 { performSugueForVac(row: indexPath.row) }
        else if listFormId == 1004 { performSugueForLoan(row: indexPath.row) }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listFormId == 10 {
            return setHeightForRowForVac(indexPath: indexPath)
        }
        else if listFormId == 1004 {
            return setHeightForRowForLoan(indexPath: indexPath)
        }
        return 0
    }
    
    // -- MARK: Helper functions
    
    func handleTheHeightOfTableView(){
        if listFormId == 10 {
            handleHeighOfTableViewForVac()
        } else if listFormId == 1004 {
            handleHeighOfTableViewForLoan()
        }
        detailsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if listFormId == 10 {
            prepareForVac(for: segue, sender: sender)
        } else if listFormId == 1004 {
            prepareForLoan(for: segue, sender: sender)
        }
    }
}

extension InboxApprovalFormViewController: UITextViewDelegate{
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension InboxApprovalFormViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 116, right: 0)
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

// -- MARK: Table View Cell

class InboxApprovalFormCell: UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        setViewAlignmentWithNoSubviews()
    }
}

















