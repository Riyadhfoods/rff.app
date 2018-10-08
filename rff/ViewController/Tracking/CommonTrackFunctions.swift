//
//  CommonTrackFunctions.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class CommonTrackFunctions{
    static let instance = CommonTrackFunctions()
    let SAH = SaveApproversHistoryService.instance
    
    func updateWorkFlowPendingStatus(array: [WorkFlowModul], editArray: inout [WorkFlowModul]) -> ([WorkFlowModul], String, String, Bool, String){
        var isPending = false
        var isRejected = false
        var isOnHold = false
        var gridEmpId_prev = ""
        var gridEmpId = ""
        var gridEmpId_next = ""
        var isHidden = true
        
        for count in 0..<array.count{
            print(array[count].WorkFlow_EmpStatus)
            
            if array[count].WorkFlow_EmpStatus == "Rejected" { isRejected = true }
            if array[count].WorkFlow_EmpStatus == "On Hold"{
                isOnHold = true
                (gridEmpId, gridEmpId_next, gridEmpId_prev) = setEmpsId(currentCount: count, array: array)
                isHidden = isButtonHidden(emp_id: array[count].WorkFlow_Empid)
            } else if array[count].WorkFlow_EmpStatus == "" && !isRejected && !isOnHold && !isPending{

                (gridEmpId, gridEmpId_next, gridEmpId_prev) = setEmpsId(currentCount: count, array: array)
                array[count].WorkFlow_EmpStatus = "Pending"
                isPending = true
                
                isHidden = isButtonHidden(emp_id: array[count].WorkFlow_Empid)
            }
            editArray.append(array[count])
        }
        
        return (editArray, gridEmpId, gridEmpId_next, isHidden, gridEmpId_prev)
    }
    
    func setEmpsId(currentCount c: Int, array: [WorkFlowModul]) -> (String, String, String){
        let gridEmpId_prev = c != 0 ? array[c - 1].WorkFlow_Empid : ""
        let gridEmpId = array[c].WorkFlow_Empid
        let gridEmpId_next = c + 1 < array.count ? array[c + 1].WorkFlow_Empid : ""
        
        return (gridEmpId, gridEmpId_next, gridEmpId_prev)
    }
    
    func isButtonHidden(emp_id id: String) -> Bool{
        if id == AuthServices.currentUserId{
            return false
        }
        return true
    }
    
    func saveToHistory(array: [WorkFlowModul], btnType: String, pid: String, formId: Int) -> String {
        var finalResult = ""
        if let lastApprover = array.last{
            if lastApprover.WorkFlow_Empid == AuthServices.currentUserId || btnType == "BtnReject" {
                for element in array{
                    let result = SAH.SaveApproversHistory(pid: pid,
                                                      fid: formId,
                                                      emp_id: element.WorkFlow_Empid,
                                                      name: element.WorkFlow_EmpName,
                                                      emp_role: element.WorkFlow_EmpRole,
                                                      status: element.WorkFlow_EmpStatus,
                                                      approve_date: element.WorkFlow_EmpTransDate)
                    
                    if result != "" { finalResult = result; break}
                    finalResult = "Saved Successfully"
                }
            }
        }
        
        return finalResult
    }
}
