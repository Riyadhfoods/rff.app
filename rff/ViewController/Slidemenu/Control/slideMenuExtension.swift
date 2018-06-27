//
//  slideMenuExtension.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

extension SlideMenuViewController {
    
    // -- MAKR: Action Functions
    
    @objc func toggleSection(sender: UIButton) {
        let tappedSection = sender.tag
        
        if tappedSection == 0 || tappedSection == 11{
            guard let identifier =  getSectionidentifierWithNoChild(tappedSection) else {return}
            performSegue(withIdentifier: identifier, sender: nil)
        } else {
            guard let isExpanded = sections[tappedSection].isExpanded else { return }
            sections[tappedSection].isExpanded = !isExpanded
            
            listTableview.beginUpdates()
            for i in 0 ..< sections[tappedSection].items.count {
                listTableview.reloadRows(at: [IndexPath(row: i, section: tappedSection)], with: .fade)
            }
            listTableview.rectForHeader(inSection: tappedSection)
            listTableview.endUpdates()
        }
    }
    
    
    // To get the segue identifier of the header the has no children
    func getSectionidentifierWithNoChild(_ sectionIndexPath: Int) -> String?{
        var identifier: String? = nil
        switch sectionIndexPath{
        case 0:
            identifier = "showHome"
        case 11:
            identifier = "showReport"
        default:
            break
        }
        
        return identifier
    }
    
    // To get the segue identifier of the items cells
    func getRowIdentifier(_ indexPath: IndexPath) -> String?{
        var identifier: String? = nil
        
        switch indexPath.section{
        case 1:
            identifier = "showChangePassword"
        case 2:
            identifier = "showTrackingInbox"
        case 3:
            identifier = getEmployeeMovementRowsIdentifier(rowIndex: indexPath.row)
        case 4:
            identifier = getAttendanceRowsIdentifier(rowIndex: indexPath.row)
        case 5:
            identifier = getPurchaseSystemRowsIdentifier(rowIndex: indexPath.row)
        case 6:
            identifier = getItDepartmentRowsIdentifier(rowIndex: indexPath.row)
        case 7:
            identifier = getPaymentRequisitionRowsIdentifier(rowIndex: indexPath.row)
        case 8:
            identifier = getTaskRowsIdentifier(rowIndex: indexPath.row)
        case 9:
            identifier = getComplainRowsIdentifier(rowIndex: indexPath.row)
        case 10:
            identifier = getSalesRowsIdentifier(rowIndex: indexPath.row)
        default:
            break
        }
        
        return identifier
    }
    
    // To get the segue identifier of Employee Movement Items
    func getEmployeeMovementRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showEmployeeVacation"
        case 1:
            identifier = "showLoan"
        case 2:
            identifier = "showResign"
        case 3:
            identifier = "showEmployeeViolation"
        case 4:
            identifier = "showReturnFromVacation"
        case 5:
            identifier = "showSalaryPreview"
        case 6:
            identifier = "showEmployeeInfo"
        case 7:
            identifier = "showSalaryChange"
        case 8:
            identifier = "showVacationDaysUpdate"
        case 9:
            identifier = "showTicketChange"
        case 10:
            identifier = "showJobTitleChange"
        case 11:
            identifier = "showBusinessTrip"
        case 12:
            identifier = "showInOutDeduction"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Attendance Items
    func getAttendanceRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showAttendance"
        case 1:
            identifier = "showOverTimeCalc"
        case 2:
            identifier = "showSettleCalc"
        case 3:
            identifier = "showAttendanceClearance"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Admin Items
    func getAdminRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showApprovalAction"
        case 1:
            identifier = "showAssignApprovalAction"
        case 2:
            identifier = "showAddForm"
        case 3:
            identifier = "showSalaryCalc"
        case 4:
            identifier = "showSalaryDeductionRule"
        case 5:
            identifier = "showHRDocExpiry"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Purchase System Items
    func getPurchaseSystemRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showPurchaseInbox"
        case 1:
            identifier = "showPurchase"
        case 2:
            identifier = "showPurchseSystem"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of IT Department Items
    func getItDepartmentRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showItRequest"
        case 1:
            identifier = "showItMasterFile"
        case 2:
            identifier = "showAddCategory"
        case 3:
            identifier = "showMyRewuests"
        case 4:
            identifier = "showDeviceDetails"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Payment Requisition Items
    func getPaymentRequisitionRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showNewPaymentReq"
        case 1:
            identifier = "showTrackPaymentReq"
        case 2:
            identifier = "showUpdateBackStatus"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Task Items
    func getTaskRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showNewTask"
        case 1:
            identifier = "showTaskDetails"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Complain Items
    func getComplainRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showNewComplain"
        case 1:
            identifier = "showMyComplain"
        default:
            break
        }
        return identifier
    }
    
    // To get the segue identifier of Sales Items
    func getSalesRowsIdentifier(rowIndex: Int) -> String? {
        var identifier: String? = nil
        switch rowIndex{
        case 0:
            identifier = "showSalesInbox"
        case 1:
            identifier = "showSalesOrderApproval"
        case 2:
            identifier = "showSalesReturnApproval"
        case 3:
            identifier = "showSalesPromotionApproval"
        case 4:
            identifier = "showSalesOrderRequest"
        case 5:
            identifier = "showReturnOrderRequests"
        case 6:
            identifier = "showPromotionRequest"
        case 7:
            identifier = "showOthaimSalesStatus"
        case 8:
            identifier = "showSalesPlanSummay"
        case 9:
            identifier = "showSalesPersonAreaSetup"
        case 10:
            identifier = "showSalesStoreUpdate"
        default:
            break
        }
        return identifier
    }
    
}


