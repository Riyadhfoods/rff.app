//
//  InboxApprovalFormViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol ApproveActionDelegate{
    func approveAction(isSuccess: Bool, row: Int, categorySelected: Int)
}

class InboxApprovalFormViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var activityIndicatorContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    
    // -- MARK: Variables
    
    let webserviceForVac = VacactionApprovalService.instance
    let webserviceForLoan = LoanApprovalService.instance
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
    var gridEmpId_prev = ""
    var gridEmpId = ""
    var gridEmpId_next = ""
    var delegate: ApproveActionDelegate?
    var isOnHoldStatus = false
    
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
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        super.viewDidAppear(animated)
        if isVacArrayEmpty() && listFormId == 10{
            setUpVacData()
        } else if isLoanArrayEmpty() && listFormId == 1004{
            setUpLoanData()
        }
        stop()
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
    
    func start(){ startLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator) }
    func stop(){ stopLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator) }
    
    func handleVisibilityOfButtons(status: String, emp_id: String){
        if status == "On Hold" || status == "Pending" {
            if emp_id == AuthServices.currentUserId{
                buttonsStackView.isHidden = false
            }
        }
    }
    
    func updateDelegateFunction(isSuccess: Bool){
        if let delegate = self.delegate{
            delegate.approveAction(isSuccess: isSuccess, row: self.cellRow, categorySelected: self.categorySelected)
        }
    }
    
    // MARK: IBActions
    
    func runApproveAction(buttonType: String, actionTitle: String){
        
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to \(actionTitle) the request?",
            actionTitle: "OK",
            onAction: {
                
                self.start()
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    if self.listFormId == 10{
                        self.approveActionForVac(buttonType: buttonType, actionTitle: actionTitle)
                    } else if self.listFormId == 1004{
                        self.approveActionForLoan(buttonType: buttonType, actionTitle: actionTitle)
                    }
                    self.stop()
                })
                
        }, cancelAction: "Cancel", self)
    }

    @IBAction func approveButtonTapped(_ sender: Any) {
        runApproveAction(buttonType: "BtnApprove", actionTitle: "approved")
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        runApproveAction(buttonType: "BtnHold", actionTitle: "put onhold")
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        runApproveAction(buttonType: "BtnReject", actionTitle: "rejected")
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

















