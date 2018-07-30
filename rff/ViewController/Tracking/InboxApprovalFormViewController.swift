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
    
    func setUpVacData(){
        VacData.shared.setValueToDefault()
        empVacDetails = webserviceForVac.GetData(
            langid: LoginViewController.languageChosen,
            pid: pid,
            emp_number: AuthServices.currentUserId)
        
        for empVac in empVacDetails{
            empGeneralInfoArrayForVac = VacData.shared.setEmpGeneralInfo(empVac: empVac)
            leaveDetailsArrayForVac = VacData.shared.setleaveDetailsInfo(empVac: empVac)
            administrativeUseArrayForVac = VacData.shared.setAdministrativeUse(empVac: empVac)
            companionsDetailsArrayForVac = VacData.shared.setCompanionsDetails(empVac: empVac)
            settlementTicketDetailsArrayForVac = VacData.shared.setSettlementAndTicketDetails(empVac: empVac)
        }
        
        workFlowForVac = webserviceForVac.BindApproversGrid(
            formid: listFormId,
            pid: pid,
            langid: LoginViewController.languageChosen)
        for workFlow in workFlowForVac{
            workFlowNamesForVac.append(workFlow.WorkFlow_EmpName)
        }
        userCommentForVac = webserviceForVac.BindCommentGrid(
            pid: pid,
            fid: listFormId,
            gvApp_RowCount: workFlowForVac.count)
        
        updateWorkFlowPendingStatus(workFlowArray: workFlowForVac, editWorkFlowArray: &editWorkFlowForVac)
        handleTheHeightOfTableView()
    }
    
    func setUpLoanData(){
        LoanData.shared.setValueToDefault()
        empLaonDetails = webserviceForLoan.Get_Emps_Details(
            langid: LoginViewController.languageChosen,
            emp_id: AuthServices.currentUserId,
            pid: pid,
            fid: "\(listFormId)",
            loanemp_id: appliedEmpId)
        
        for empLoan in empLaonDetails{
            empInfoForLoan = LoanData.shared.setEmployeeDetails(empLoan: empLoan)
            prevLoanForLoan = LoanData.shared.getLastLoan(empLoan: empLoan)
            loanDeatilsForLoan = LoanData.shared.getLoanDetails(empLoan: empLoan)
        }
        
        workFlowForLoan = webserviceForLoan.BindApproversGrid(formid: listFormId, pid: pid, langid: LoginViewController.languageChosen)
        for workFlow in workFlowForLoan{
            workFlowNamesForLoan.append(workFlow.WorkFlow_EmpName)
        }
        userCommentForLoan = webserviceForLoan.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlowForLoan.count)
        
        updateWorkFlowPendingStatus(workFlowArray: workFlowForLoan, editWorkFlowArray: &editWorkFlowForLoan)
        handleTheHeightOfTableView()
        
        print("--------------------------------------------------------------------")
        if let empInfoForLoan = empInfoForLoan{
            print("Emp_Name = \(empInfoForLoan.Emp_Name)")
            print("Join_Date = \(empInfoForLoan.Join_Date)")
            print("Start_Date = \(empInfoForLoan.Start_Date)")
            print("Company = \(empInfoForLoan.Company)")
            print("Manager = \(empInfoForLoan.Manager)")
            print("Job_Desc = \(empInfoForLoan.Job_Desc)")
            print("Sub_JobDesc = \(empInfoForLoan.Sub_JobDesc)")
            print("Department = \(empInfoForLoan.Department)")
            print("Nationality = \(empInfoForLoan.Nationality)")
            print("Basic_Sal = \(empInfoForLoan.Basic_Sal)")
            print("Package = \(empInfoForLoan.Package)")
        }
        for prevLoan in prevLoanForLoan{
            print("L_Date = \(prevLoan.L_Date)")
            print("L_StartDate = \(prevLoan.L_StartDate)")
            print("L_Guarantor = \(prevLoan.L_Guarantor)")
            print("L_LoanType = \(prevLoan.L_LoanType)")
            print("L_Amount = \(prevLoan.L_Amount)")
            print("L_MonthlyPay = \(prevLoan.L_MonthlyPay)")
            print("L_DeductedValue = \(prevLoan.L_DeductedValue)")
            print("L_BalAmount = \(prevLoan.L_BalAmount)")
        }
        if let loanDeatilsForLoan = loanDeatilsForLoan{
            print("LoanType = \(loanDeatilsForLoan.LoanType)")
            print("CreatedDate = \(loanDeatilsForLoan.CreatedDate)")
            print("AmountRequired = \(loanDeatilsForLoan.AmountRequired)")
            print("Guarantor_Name = \(loanDeatilsForLoan.Guarantor_Name)")
            print("PayPeriod = \(loanDeatilsForLoan.PayPeriod)")
            print("Monthly_Pay = \(loanDeatilsForLoan.Monthly_Pay)")
        }
        for comment in userCommentForLoan{
            print("Cmt_Name = \(comment.Cmt_Name)")
            print("Cmt_Comment = \(comment.Cmt_Comment)")
        }
        for workFlow in editWorkFlowForLoan{
            print("WorkFlow_Empid = \(workFlow.WorkFlow_Empid)")
            print("WorkFlow_EmpName = \(workFlow.WorkFlow_EmpName)")
            print("WorkFlow_EmpRole = \(workFlow.WorkFlow_EmpRole)")
            print("WorkFlow_EmpStatus = \(workFlow.WorkFlow_EmpStatus)")
            print("WorkFlow_EmpTransDate = \(workFlow.WorkFlow_EmpTransDate)")
        }
        print("--------------------------------------------------------------------")
    }
    
    // -- MARK: Helper Functions
    
    func isVacArrayEmpty() -> Bool{
        return
            empVacDetails.isEmpty &&
            userCommentForVac.isEmpty &&
            workFlowForVac.isEmpty
    }
    
    func isLoanArrayEmpty() -> Bool{
        return empLaonDetails.isEmpty &&
                userCommentForLoan.isEmpty &&
                workFlowForLoan.isEmpty
    }
    
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
    
    func approveActionForVac(buttonType: String, actionTitle: String){
        if let commentText = commentTextView.text,
            let vaction = leaveDetailsArrayForVac,
            let workFlowLast = workFlowForVac.last{
            
            let approveVacationResult = webserviceForVac.Approve_Vacation(
                vac_number: vaction.Vacation_Number,
                Emp_ID: appliedEmpId,
                fid: "\(listFormId)",
                pid: pid,
                comment: commentText,
                buttonType: buttonType,
                FormId: listFormId,
                Comment: commentText,
                grid_empid: gridEmpId,
                totalgrd_rows: workFlowForVac.count,
                login_empId: AuthServices.currentUserId,
                finalApp_EmpId: workFlowLast.WorkFlow_Empid,
                finalApp_Status: workFlowLast.WorkFlow_EmpStatus)
            
            if approveVacationResult == "" {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success",
                    alertMessage: "Vacation request " + actionTitle + " successfully",
                    actionTitle: "OK", onAction: {
                        
                        ActivityIndicatorDisplayAndAction(activityIndicator: self.activityIndicator, action: {
                            if let delegate = self.delegate{
                                delegate.approveAction(isSuccess: true, row: self.cellRow, categorySelected: self.categorySelected)
                            }
                            self.navigationController?.popViewController(animated: true)
                        })
                        
                }, cancelAction: nil, self)
            } else {
                if let delegate = self.delegate{
                    delegate.approveAction(isSuccess: false, row: self.cellRow, categorySelected: categorySelected)
                }
            }
        }
    }
    
    func approveActionForLoan(buttonType: String, actionTitle: String){
        if let commentText = commentTextView.text,
            let workFlowLast = workFlowForLoan.last{
            
            print("""
                Emp_ID: \(appliedEmpId),
                pid: \(pid),
                buttonType: \(buttonType),
                FormId: \(listFormId),
                Comment: \(commentText),
                grid_empid: \(gridEmpId),
                totalgrd_rows: \(workFlowForLoan.count),
                login_empId: \(AuthServices.currentUserId),
                finalApp_EmpId: \(workFlowLast.WorkFlow_Empid),
                finalApp_Status: \(workFlowLast.WorkFlow_EmpStatus)
                """)
            
            let approveVacationResult = webserviceForLoan.Approve_Loan(
                Emp_ID: appliedEmpId,
                pid: pid,
                buttonType: buttonType,
                FormId: listFormId,
                Comment: commentText,
                grid_empid: gridEmpId,
                totalgrd_rows: workFlowForLoan.count,
                login_empId: AuthServices.currentUserId,
                finalApp_EmpId: workFlowLast.WorkFlow_Empid,
                finalApp_Status: workFlowLast.WorkFlow_EmpStatus)
            
            if approveVacationResult == "" {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success",
                    alertMessage: "Loan request " + actionTitle + " successfully",
                    actionTitle: "OK", onAction: {
                        
                        ActivityIndicatorDisplayAndAction(activityIndicator: self.activityIndicator, action: {
                            if let delegate = self.delegate{
                                delegate.approveAction(isSuccess: true, row: self.cellRow, categorySelected: self.categorySelected)
                            }
                            self.navigationController?.popViewController(animated: true)
                        })
                        
                }, cancelAction: nil, self)
            } else {
                if let delegate = self.delegate{
                    delegate.approveAction(isSuccess: false, row: self.cellRow, categorySelected: self.categorySelected)
                }
            }
        }
    }
    
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
            if indexPath.row == 0 {
                if empGeneralInfoArrayForVac == nil{ return 0 }
            } else if indexPath.row == 1 {
                if leaveDetailsArrayForVac == nil{ return 0 }
            } else if indexPath.row == 2 {
                if administrativeUseArrayForVac == nil{ return 0 }
            } else if indexPath.row == 3 {
                if companionsDetailsArrayForVac.isEmpty{ return 0 }
            } else if indexPath.row == 4 {
                if settlementTicketDetailsArrayForVac == nil{ return 0 }
            } else if indexPath.row == 5 {
                if userCommentForVac.isEmpty{ return 0 }
            } else if indexPath.row == 6 {
                if workFlowForVac.isEmpty{ return 0 }
            }
            return 44
        }
        else if listFormId == 1004 {
            if indexPath.row == 0 {
                if empInfoForLoan == nil{ return 0 }
            } else if indexPath.row == 1 {
                if prevLoanForLoan.isEmpty{ return 0 }
            } else if indexPath.row == 2 {
                if loanDeatilsForLoan == nil{ return 0 }
            } else if indexPath.row == 3 {
                if userCommentForLoan.isEmpty{ return 0 }
            } else if indexPath.row == 4 {
                if workFlowForLoan.isEmpty{ return 0 }
            }
            return 44
        }
        return 0
    }
    
    // -- MARK: Helper functions
    
    func handleTheHeightOfTableView(){
        if listFormId == 10 {
            var emptyArray = [Bool]()
            var emptyArrayCount = 0
            
            emptyArray.append(empGeneralInfoArrayForVac == nil)
            emptyArray.append(leaveDetailsArrayForVac == nil)
            emptyArray.append(administrativeUseArrayForVac == nil)
            emptyArray.append(companionsDetailsArrayForVac.isEmpty)
            emptyArray.append(settlementTicketDetailsArrayForVac == nil)
            emptyArray.append(userCommentForVac.isEmpty)
            emptyArray.append(workFlowForVac.isEmpty)
            
            for isEmpty in emptyArray{
                if isEmpty{
                    emptyArrayCount += 1
                }
            }
            
            tableViewHeight.constant = CGFloat(44 * (cellTitleArrayForVac.count - emptyArrayCount))
        } else if listFormId == 1004 {
            var emptyArray = [Bool]()
            var emptyArrayCount = 0
            
            emptyArray.append(empInfoForLoan == nil)
            emptyArray.append(prevLoanForLoan.isEmpty)
            emptyArray.append(loanDeatilsForLoan == nil)
            emptyArray.append(userCommentForLoan.isEmpty)
            emptyArray.append(workFlowForLoan.isEmpty)
            
            for isEmpty in emptyArray{
                if isEmpty{
                    emptyArrayCount += 1
                }
            }
            
            tableViewHeight.constant = CGFloat(44 * (cellTitleArrayForLoan.count - emptyArrayCount))
        }
        detailsTableView.reloadData()
    }
    
    func performSugueForVac(row: Int){
        switch row {
        case 0: performSegue(withIdentifier: "showInboxEmpDetails", sender: nil)
        case 1: performSegue(withIdentifier: "showInboxLeaveDetails", sender: nil)
        case 2: performSegue(withIdentifier: "showAdministrativeUseDetails", sender: nil)
        case 3: performSegue(withIdentifier: "showCompanionsDetailsInbox", sender: nil)
        case 4: performSegue(withIdentifier: "showSettlementandTicketDetails", sender: nil)
        case 5: performSegue(withIdentifier: "showUserCommentInbox", sender: nil)
        case 6: performSegue(withIdentifier: "showWorkFlowInbox", sender: nil)
        default: break}
    }
    
    func performSugueForLoan(row: Int){
        switch row {
        case 0: performSegue(withIdentifier: "showEmpInfoInboxLoan", sender: nil)
        case 1: performSegue(withIdentifier: "showPrevLoanDetailsInbox", sender: nil)
        case 2: performSegue(withIdentifier: "showLoanDetailsInbox", sender: nil)
        case 3: performSegue(withIdentifier: "showUserCommentInbox", sender: nil)
        case 4: performSegue(withIdentifier: "showWorkFlowInbox", sender: nil)
        default: break}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if listFormId == 10 {
            prepareForVac(for: segue, sender: sender)
        } else if listFormId == 1004 {
            prepareForLoan(for: segue, sender: sender)
        }
    }
    
    func prepareForVac(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showInboxEmpDetails"{
            if let vc = segue.destination as? EmployeeGeneralInformationInboxViewController{
                vc.empGeneralInfoArrayForVac = empGeneralInfoArrayForVac
                vc.navigationItem.title = cellTitleArrayForVac[0].localize()
            }
        } else if segue.identifier == "showInboxLeaveDetails"{
            if let vc = segue.destination as? LeaveDetailsInboxViewController{
                vc.leaveDetailsArrayForVac = leaveDetailsArrayForVac
                vc.navigationItem.title = cellTitleArrayForVac[1].localize()
            }
        } else if segue.identifier == "showAdministrativeUseDetails"{
            if let vc = segue.destination as? AdministrativeUseInboxViewController{
                vc.administrativeUseArrayForVac = administrativeUseArrayForVac
                vc.navigationItem.title = cellTitleArrayForVac[2].localize()
            }
        } else if segue.identifier == "showCompanionsDetailsInbox"{
            if let vc = segue.destination as? CompanionsDetailsInboxTableViewController{
                vc.companionsDetailsArrayForVac = companionsDetailsArrayForVac
                vc.navigationItem.title = cellTitleArrayForVac[3].localize()
            }
        } else if segue.identifier == "showSettlementandTicketDetails"{
            if let vc = segue.destination as? SettlementandTicketDetailsViewController{
                vc.settlementTicketDetailsArrayForVac = settlementTicketDetailsArrayForVac
                vc.navigationItem.title = cellTitleArrayForVac[4].localize()
            }
        } else if segue.identifier == "showUserCommentInbox"{
            if let vc = segue.destination as? UserCommentInboxTableViewController{
                vc.userComment = userCommentForVac
                vc.empName = appliedEmpName
                vc.workFlowNames = workFlowNamesForVac
                vc.navigationItem.title = cellTitleArrayForVac[5].localize()
            }
        } else if segue.identifier == "showWorkFlowInbox"{
            if let vc = segue.destination as? WorkFlowInboxTableViewController{
                vc.workFlow = editWorkFlowForVac
                vc.navigationItem.title = cellTitleArrayForVac[6].localize()
            }
        }
    }
    
    func prepareForLoan(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showEmpInfoInboxLoan"{
            if let vc = segue.destination as? EmployeeInfoInboxViewController{
                vc.empInfoForLoan = empInfoForLoan
                vc.navigationItem.title = cellTitleArrayForLoan[0]
            }
        } else if segue.identifier == "showPrevLoanDetailsInbox"{
            if let vc = segue.destination as? PreviousNewLoanDetailsInboxTableViewController{
                vc.prevLoanForLoan = prevLoanForLoan
                vc.navigationItem.title = cellTitleArrayForLoan[1]
            }
        } else if segue.identifier == "showLoanDetailsInbox"{
            if let vc = segue.destination as? LoanDetailsInboxViewController{
                vc.loanDeatilsForLoan = loanDeatilsForLoan
                vc.navigationItem.title = cellTitleArrayForLoan[2]
            }
        } else if segue.identifier == "showUserCommentInbox"{
            if let vc = segue.destination as? UserCommentInboxTableViewController{
                vc.userComment = userCommentForLoan
                vc.empName = appliedEmpName
                vc.workFlowNames = workFlowNamesForLoan
                vc.navigationItem.title = cellTitleArrayForLoan[3]
            }
        } else if segue.identifier == "showWorkFlowInbox"{
            if let vc = segue.destination as? WorkFlowInboxTableViewController{
                vc.workFlow = editWorkFlowForLoan
                vc.navigationItem.title = cellTitleArrayForLoan[4]
            }
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
        
        setViewAlignment()
    }
}

















