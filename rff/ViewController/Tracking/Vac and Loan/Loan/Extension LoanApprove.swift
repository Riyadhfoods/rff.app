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
        
        workFlowForLoan = webserviceForLoan.BindApproversGrid(emp_id: appliedEmpId, formid: listFormId, pid: pid, langid: LoginViewController.languageChosen)
        for workFlow in workFlowForLoan{
            workFlowNamesForLoan.append(workFlow.WorkFlow_EmpName)
        }
        userCommentForLoan = webserviceForLoan.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlowForLoan.count)
        
        if editWorkFlowForLoan.isEmpty {
            let updatedValues = CommonTrackFunctions.instance.updateWorkFlowPendingStatus(array: workFlowForLoan, editArray: &editWorkFlowForLoan)
            editWorkFlowForLoan = updatedValues.0
            gridEmpId = updatedValues.1
            gridEmpId_next = updatedValues.2
            buttonsStackView.isHidden = updatedValues.3
            gridEmpId_prev = updatedValues.4
        }
        
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
            print("Cmt_Name = \(comment.Name)")
            print("Cmt_Comment = \(comment.Comment)")
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
            
            for element in editWorkFlowForLoan {
                if element.WorkFlow_Empid == AuthServices.currentUserId {
                    if element.WorkFlow_EmpStatus == "On Hold" {
                        isOnHoldStatus = true
                        break
                    }
                }
                isOnHoldStatus = false
            }
            
            if buttonType == "BtnHold" || buttonType == "BtnReject" || (isOnHoldStatus && buttonType == "BtnApprove"){
                gridEmpId_next = gridEmpId
            }
            
            if buttonType == "BtnApprove" && !isOnHoldStatus{
                gridEmpId_next = gridEmpId
                gridEmpId = gridEmpId_prev
            }
            
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
                finalApp_Status: \(workFlowLast.WorkFlow_EmpStatus),
                gridEmpId_next: \(gridEmpId_next)
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
                finalApp_Status: workFlowLast.WorkFlow_EmpStatus,
                gridEmpid_next: gridEmpId_next)

            if approveVacationResult == "" {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success",
                    alertMessage: "Loan request " + actionTitle + " successfully",
                    actionTitle: "OK", onAction: {
                        self.saveActionForLoan(buttonType: buttonType)
                }, cancelAction: nil, self)
            } else {
                self.updateDelegateFunction(isSuccess: false)
                AlertMessage().showAlertMessage(
                    alertTitle: "Alert",
                    alertMessage: approveVacationResult,
                    actionTitle: nil,
                    onAction: nil,
                    cancelAction: "OK",
                    self)
            }
        }
    }
    
    func saveActionForLoan(buttonType: String){
        start()
        DispatchQueue.main.async {
            let workFlow = self.webserviceForLoan.BindApproversGrid(emp_id: self.appliedEmpId, formid: self.listFormId, pid: self.pid, langid: LoginViewController.languageChosen)
            
            let result = CommonTrackFunctions.instance.saveToHistory(array: workFlow, btnType: buttonType, pid: self.pid, formId: self.listFormId)
            print(result)
            
            self.updateDelegateFunction(isSuccess: true)
            self.navigationController?.popViewController(animated: true)
            self.stop()
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
