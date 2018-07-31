//
//  Extension LoanApprove.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 31/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

extension InboxApprovalFormViewController{
    
    // -- MARK: Set ups
    
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
    
    func setHeightForRowForLoan(indexPath: IndexPath) -> CGFloat{
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
    
    func handleHeighOfTableViewForLoan(){
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
    
    // -- MARK: Helper Functions
    
    func isLoanArrayEmpty() -> Bool{
        return empLaonDetails.isEmpty &&
            userCommentForLoan.isEmpty &&
            workFlowForLoan.isEmpty
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
    
    func performSugueForLoan(row: Int){
        switch row {
        case 0: performSegue(withIdentifier: "showEmpInfoInboxLoan", sender: nil)
        case 1: performSegue(withIdentifier: "showPrevLoanDetailsInbox", sender: nil)
        case 2: performSegue(withIdentifier: "showLoanDetailsInbox", sender: nil)
        case 3: performSegue(withIdentifier: "showUserCommentInbox", sender: nil)
        case 4: performSegue(withIdentifier: "showWorkFlowInbox", sender: nil)
        default: break}
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
