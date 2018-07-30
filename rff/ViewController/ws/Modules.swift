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
    var Cmt_Name: String = ""
    var Cmt_Comment: String = ""
    var Cmt_Id: String = ""
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
















