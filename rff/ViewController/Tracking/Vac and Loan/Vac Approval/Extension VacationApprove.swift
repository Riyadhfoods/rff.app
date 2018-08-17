//
//  Extension VacationApprove.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 31/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

extension InboxApprovalFormViewController{
    
    // -- MARK: Set ups
    
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
    
    func setHeightForRowForVac(indexPath: IndexPath) -> CGFloat{
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
    
    func handleHeighOfTableViewForVac(){
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
    }
    
    // -- MARK: Helper Functions
    
    func isVacArrayEmpty() -> Bool{
        return
            empVacDetails.isEmpty &&
                userCommentForVac.isEmpty &&
                workFlowForVac.isEmpty
    }
    
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
                finalApp_Status: workFlowLast.WorkFlow_EmpStatus,
                gridEmpid_next: gridEmpId_next)
            
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
    
}
