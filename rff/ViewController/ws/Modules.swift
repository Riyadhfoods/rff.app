//
//  Modules.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

// -- MARK: HOME

class Task_InboxModul{
    var FormId : String = ""
    var EnglishDes : String = ""
    var ArabicDesc : String = ""
    var PageName : String = ""
    var Count : Int = 0
}

// -- MARK: Inbox

class InboxGridModul{
    var pid : String = ""
    var empname : String = ""
    var empid : String = ""
    var date : String = ""
}

class ListTypeModul{
    var listtype : String = ""
    var listname : String = ""
}

class VacationApprovalModul{
    var EmpName: String = ""
    var JoinDate: String = ""
    var StartDate: String = ""
    var ManagerName: String = ""
    var JobDesc: String = ""
    var SubJobDesc: String = ""
    var Department: String = ""
    var Nationality: String = ""
    var NumberofDays: String = ""
    var LeaveStartDate: String = ""
    var ReturnDate: String = ""
    var RequestDate: String = ""
    var VacationType: String = ""
    var ExitReEntry: String = ""
    var ExitReEntryDays: String = ""
    var City: String = ""
    var Vacation_Number: String = ""
    var VacTypeAdmin: String = ""
    var VacationDays_Details: String = ""
    var Used_Details: String = ""
    var Requested: String = ""
    var Remaining_Detail: String = ""
    var Name_Companion: String = ""
    var City_Companion: String = ""
    var DOB_Companion: String = ""
    var VisaRequest_Companion: String = ""
    var Total_SettlementAmount: String = ""
    var TicketRequired: String = ""
}

class LoanApprovalModul{
    var LoanType : String = ""
    var Emp_ID : String = ""
    var AmountRequired : String = ""
    var Guarantor_Name : String = ""
    var PayPeriod : String = ""
    var Monthly_Pay : String = ""
    var CreatedDate : String = ""
    var Emp_Name : String = ""
    var L_LoanType : String = ""
    var Join_Date : String = ""
    var Start_Date : String = ""
    var Company : String = ""
    var Manager : String = ""
    var Job_Desc : String = ""
    var Sub_JobDesc : String = ""
    var Department : String = ""
    var Nationality : String = ""
    var Basic_Sal : String = ""
    var Package : String = ""
    var L_Date : String = ""
    var L_StartDate : String = ""
    var L_Guarantor : String = ""
    var L_Amount : String = ""
    var L_MonthlyPay : String = ""
    var L_DeductedValue : String = ""
    var L_BalAmount : String = ""
}

class CommentModul {
    var Name: String = ""
    var Comment: String = ""
    var Id: String = ""
}

class WorkFlowModul{
    var WorkFlow_Empid: String = ""
    var WorkFlow_EmpName: String = ""
    var WorkFlow_EmpRole: String = ""
    var WorkFlow_EmpStatus: String = ""
    var WorkFlow_EmpTransDate: String = ""
}

// -- MARK: Vacation

class UpdateVacationDetailsInfoModul{
    var exitrentry : String = ""
    var Emp_Id : String = ""
    var Balance_Vacation : String = ""
    var Number_Days : String = ""
    var ExitReEntry : String = ""
    var RequireVisa : String = ""
}

class EmpVacationDetailsModul{
    var exitrentry : String = ""
    var extradays : String = ""
    var Job_Num : String = ""
    var Job_English : String = ""
    var Job_Arabic : String = ""
    var Sub_Job_Num : String = ""
    var Sub_Job_English : String = ""
    var Sub_Job_Arabic : String = ""
    var Nationality_Num : String = ""
    var Nationality_English : String = ""
    var Nationality_Arabic : String = ""
    var Manager_Id : String = ""
    var Manager_English : String = ""
    var Manager_Arabic : String = ""
    var Department_Num : String = ""
    var Department_English : String = ""
    var JoinDate : String = ""
    var StartDate : String = ""
    var Leave_Start_Dt : String = ""
    var Leave_Return_Dt : String = ""
    var Balance_Vacation : String = ""
    var Number_Days : String = ""
    var ExitReEntry : String = ""
    var ExtraDays : String = ""
    var SettlementAmount : String = ""
    var Dependent_Ticket : String = ""
    var RequireVisa : String = ""
}

class EmpInfoModul{
    var Emp_Id : Int = 0
    var Emp_Ename : String = ""
    var Emp_AName : String = ""
}

class VacTypeInfoModul{
    var Vac_Type : String = ""
    var Vac_Desc : String = ""
}

class EmpDepVacTicketInfoModul{
    public var RequireVisa : Int = 0
    public var Ticket : String = ""
    public var DependentName : String = ""
    public var BirthDate : String = ""
    public var Age : String = ""
}

class settlmentDetailsModul{
    var TotalSettlementAmount : String = ""
    var DiffTicketAmount : String = ""
    var NetTicketPrice : String = ""
    var TicketPercent : String = ""
    var TicketAmount : String = ""
    var TicketPrice : String = ""
    var VNet : String = ""
    var VAllowances : String = ""
    var VTotal : String = ""
    var VBasic : String = ""
    var SNet : String = ""
    var STotal : String = ""
    var SAllowances : String = ""
    var SBasic : String = ""
    var SDeduction : String = ""
}

class submitModul{
    var Error : String = ""
    var PID : String = ""
}

// -- MARK: Loan

class EmpInfoModul_2{
    var Emp_ID : String = ""
    var Emp_Name : String = ""
}

class SubmitModul{
    var error: String = ""
}

// -- MARK: Business Trip
class BusinessTripClass{
    var EmpNum : String = ""
    var EmpName : String = ""
    var TransDesc : String = ""
    var TransId : String = ""
}

class BusinessTrip_AppModel{
    var TransMode : String = ""
    var ExitReEnteryVisa : Bool = false
    var StartDate : String = ""
    var EndDate : String = ""
    var Dest : String = ""
    var TripAmt : String = ""
    var AmtDesc : String = ""
    var Reason : String = ""
    var MeetAndAssistance : String = ""
    var Luggage : String = ""
    var AirLines : String = ""
    var Membership : String = ""
    var Othersvl : String = ""
}

class BusinessTrip_AppTravelModel{
    var AirLineGrid : String = ""
    var VisaGrid : Bool = false
    var ToLocGrid : String = ""
    var FromLocGrid : String = ""
    var ToDateGrid : String = ""
    var FromDateGrid : String = ""
}

// -- MARK: Resign

class ReasonModul{
    var Error: String = ""
    var ID : String = ""
    var Reason : String = ""
}

class Emp_InfoModul{
    var Error: String = ""
    var Emp_Id : String = ""
    var Emp_Name : String = ""
}

class ResignEmpDetailsModul{
    var Error: String = ""
    var Employee_Name : String = ""
    var Join_Date : String = ""
    var Start_Date : String = ""
    var Compnay : String = ""
    var MGR_Name : String = ""
    var Job_Desc : String = ""
    var Sub_Job_Desc : String = ""
    var Dept_Name : String = ""
    var Nationality : String = ""
    var Work_Hrs : String = ""
    var Basic_Salary : String = ""
    var Package : String = ""
    var Absent_Days : String = ""
    var Resign_type : String = ""
}

class Inc_DecrDetailsModul{
    var Error: String = ""
    var Date : String = ""
    var Old_Basic : String = ""
    var New_Basic : String = ""
    var Inc_Decr : String = ""
}

class EvaDetailsModul{
    var Error: String = ""
    var Date : String = ""
    var Total : String = ""
    var Result : String = ""
    var MGr_Remark : String = ""
}

// -- In Out Deductions

class Emp_Details_Modul{
    var Error: String = ""
    var Employee_Name : String = ""
    var Join_Date : String = ""
    var Start_Date : String = ""
    var Compnay : String = ""
    var MGR_Name : String = ""
    var Job_Desc : String = ""
    var Sub_Job_Desc : String = ""
    var Dept_Name : String = ""
    var Nationality : String = ""
    var Work_Hrs : String = ""
    var Basic_Salary : String = ""
    var Package : String = ""
    var Absent_Days : String = ""
}

class In_Ou_Deduction_Modul{
    var Error: String = ""
    var Date : String = ""
    var FromTime : String = ""
    var ToTime : String = ""
    var TotalMin : String = ""
}


// -- MARK: Sales

class SalesInboxModul{
    var totalrows : Int = 0
    var currentrows : String = ""
    var Flag : Bool = false
    var ID : String = ""
    var EmpCreated : String = ""
    var CustomerName : String = ""
    var RequestDate : String = ""
    var ReturnDate : String = ""
    var Items : String = ""
    var Date : String = ""
    var Status : String = ""
    var PendingBy : String = ""
    var Comment : String = ""
}


class SalesItemInboxModul{
    // sales return
    var Return_SerialNumber : String = ""
    var Return_CustomerName : String = ""
    var Return_SLSPersonName : String = ""
    var Return_ReturnType : String = ""
    var Return_ReqDate : String = ""
    var Return_ReturnDate : String = ""
    var Return_Comment : String = ""
    var Return_InvoiceNumber : String = ""
    var Return_LotNumber : String = ""
    var Return_ItemNumber : String = ""
    var Return_ItemDesc : String = ""
    var Return_Unitprice : String = ""
    var Return_ExtPrice : String = ""
    var Return_Qty : String = ""
    var Return_UOFM : String = ""
    var Return_InvoiceDate : String = ""
    
    // sales order
    var Order_ORDERID : String = ""
    var Order_EMPCREATED : String = ""
    var Order_SLSPERSONID : String = ""
    var Order_CUSTNAME : String = ""
    var Order_SERIALNUMBER : String = ""
    var Order_ITEMID : String = ""
    var Order_ITEMDESC : String = ""
    var Order_UNITCOST : String = ""
    var Order_EXTCOST : String = ""
    var Order_QTY : String = ""
    var Order_UOFM : String = ""
    var Order_LASTYEAR : String = ""
    var Order_YEARTODATE : String = ""
    var Order_REQDATE : String = ""
    var Order_DELIVERYDATE : String = ""
    var Order_COMMENT : String = ""
}


class SalesCreditLimmitInboxModul{
    var CustomerID : String = ""
    var CustomerName : String = ""
    var CreditLimit : String = ""
    var TotalDue : String = ""
    var Status : String = ""
}

class SalesReturnWorkFlowInboxModul{
    var EMP_ID : String = ""
    var Name : String = ""
    var EmpRole : String = ""
    var Status : String = ""
    var TransDate : String = ""
}

class SalesOrderApproveModul{
    var OrderID : String = ""
    var ReqDate : String = ""
    var DeliveryDate : String = ""
    var EmpCreated : String = ""
    var Comment : String = ""
    var CustomerName : String = ""
    var Items : String = ""
    var Status : String = ""
}

class OrderApproveItem{
    var SERIALNUMBER : String = ""
    var ITEMNUMBER : String = ""
    var ITEMDESC : String = ""
    var CHANGEDPRICE : String = ""
    var ORIGINALPRICE : String = ""
    var QTY : String = ""
    var UNITOFMEASUREMENT : String = ""
    var LASTYEARORDERQTY : String = ""
    var YEARTODATEORDERQTY : String = ""
    var TOTAL : String = ""
    var REQUESTDATE : String = ""
    var DELIVERYDATE : String = ""
    var OrderID : String = ""
}

class OrderApproveCreditModul{
    var CUSTOMERID : String = ""
    var CUSTOMERNAME : String = ""
    var CREDITLIMIT : String = ""
    var TOTALDUE : String = ""
    var ZEROTOTHIRYONEDAYS : String = ""
    var THIRYONETOSIXTYDAYS : String = ""
    var SIXTYONETONINETYDAYS : String = ""
    var NINETYONETOHUNDREDTWENTYDAYS : String = ""
    var ABOVE120DAYS : String = ""
    var STATUS : String = ""
}

class ComBoxMudel{
    var DocumentId : String = ""
    var LocationCode : String = ""
}

class SalesOrderButtonVisibiltyMudel{
    var ApproveandEnterManually_btn : Bool = false
    var U_Comment : Bool = false
    var App_btn_vis : Bool = false
    var Rej_btn_vis : Bool = false
    var Report_btn_vis : Bool = false
    var Savetogp_btn_vis : Bool = false
    var Loc_control_vis : Bool = false
    var DocId_control_vis : Bool = false
    var Flag : Bool = false
    var Approver: String = ""
    var Approver1: String = ""
    var App_Market: String = ""
    var App_Retail: String = ""
    var App_Export: String = ""
    var App_Diary: String = ""
}

class SaveToGpMudel{
    public var GP_Save : String = ""
    public var GP_Error : String = ""
    public var Savetogp_btn_vis : Bool = false
    public var ApproveandEnterManually_btn : Bool = false
}

class SalesReturnApproveModul{
    var ReturnID : String = ""
    var EmpCreated : String = ""
    var Items : String = ""
    var ReqDate : String = ""
    var RetDate : String = ""
    var Comment : String = ""
}

class ReturnApproveItemModel{
    var SerialNumber : String = ""
    var EmpCreated : String = ""
    var CustomerName : String = ""
    var SalesPerson : String = ""
    var ReqDate : String = ""
    var ReturnDate : String = ""
    var InvoiceNumber : String = ""
    var LotNumber : String = ""
    var ItemNumber : String = ""
    var Description : String = ""
    var Unitprice : String = ""
    var TotalCost : String = ""
    var Qty : String = ""
    var UOFM : String = ""
    var ReturnType : String = ""
}

class ReturnApproveCreditModul{
    var CreditLimit : String = ""
    var TotalDue : String = ""
    var ZeroTo31Days : String = ""
    var ThirtyOneto60Days : String = ""
    var SixtyOneTo90Days : String = ""
    var Nineoneto120Days : String = ""
    var Above120Days : String = ""
    var Status : String = ""
}

class OnLoandModul{
    var Approver: String = ""
    var APPROVE_BTN: Bool = false
    var REJECT_BTN: Bool = false
    var CustomerDDL: Bool = false
    var SalesPersonDDL: Bool = false
}

class ReturnApproveAttachment{
    var INDEX : String = ""
    var FILENAME : String = ""
    var FILETYPE : String = ""
}


// Sales Order Request

class CompanyModul{
    var Comp_ID : String = ""
    var EName : String = ""
}

class BranchModul{
    var Branch : String = ""
    var AccountEmp : String = ""
}

class LocCodeModul{
    var LocationCode : String = ""
}

class SalesPersonModul{
    var SalesPersonId : String = ""
    var SalesPerson : String = ""
}

class CustomerModul{
    var CustomerId : String = ""
    var CustomerName : String = ""
}

class StoreModul{
    var StoreID : String = ""
    var StoreName : String = ""
    var City : String = ""
    var SalesPersonStore : String = ""
    var Merchandiser : String = ""
}

class CreditLimitModul{
    var CreditLimit : String = ""
    var ToTalDue : String = ""
    var ZEROTO31days : String = ""
    var ThirtyOneTo60Days : String = ""
    var SIXTYOneTo90Days : String = ""
    var NINETYOneTo120Days : String = ""
    var Above120DAYS : String = ""
    var CustomerAgying_Status : String = ""
}

class ItemSalesModel{
    var DRP_ITEMNUMER : String = ""
    var DrpItems : String = ""
    var DrpItemId : String = ""
}

class ItemClassModul{
    var grid_error: String = ""
    var Grid_ItemId: String = ""
    var Grid_Desc: String = ""
    var Grid_UOM: String = ""
    var Grid_Qty: String = ""
    var Grid_UnitPrice: String = ""
    var Grid_TotalPrice: String = ""
    var Onhand: String = ""
}

class ItemSendModul{
    var grid_error: String = ""
    var OrderID: String = ""
    var Flag: Bool = false
    var Status: String = ""
}

class unitOfMeasurementModel{
    var UnitofMeasure: String = ""
}

class ReturnItemSendModel{
    var SRR_ITEMGRID_COLUMN1: String = ""
    var SRR_ITEMGRID_COLUMN2: String = ""
    var SRR_ITEMGRID_COLUMN3: String = ""
    var SRR_ITEMGRID_COLUMN4: String = ""
    var SRR_ITEMGRID_COLUMN5: String = ""
    var SRR_ITEMGRID_COLUMN6: String = ""
    var SRR_ITEMGRID_COLUMN7: String = ""
    var SRR_ITEMGRID_COLUMN8: String = ""
    var SRR_ITEMGRID_COLUMN9: String = ""
    var SRR_ITEMGRID_COLUMN10: String = ""
    var SRR_ITEMGRID_COLUMN11: String = ""
}

class InvoiceAndItemModul{
    var Sop_Number: String = ""
    var Items: String = ""
}

// -- Sales Collection

class TerritoryModul{
    var territoryId: String = ""
    var territoryName: String = ""
}

class CollCustomerModul{
    var CustomerId: String = ""
    var CustomerName: String = ""
}

class CollectionTypeModul{
    var Desc: String = ""
    var Id: String = ""
}

class BankTypeModul{
    var Name: String = ""
    var Id: String = ""
}

class CollSalesPersonModul{
    var SalesPersonId : String = ""
    var SalespersonName : String = ""
}

class CreatorAndCollectionDetailsModul{
    var emp_name : String = ""
    var mgr_name : String = ""
    var dept_name : String = ""
    var nationality : String = ""
    var join_date : String = ""
    var start_date : String = ""
    var job_desc : String = ""
    var sub_job_desc : String = ""
    var comp : String = ""
    var basic_salary : String = ""
    var package : String = ""
    var customer_name : String = ""
    var sales_person : String = ""
    var coll_type : String = ""
    var territory : String = ""
    var invoice_date : String = ""
    var invoice_no : String = ""
    var amount : String = ""
    var check_book_no : String = ""
    var error : String = ""
}
