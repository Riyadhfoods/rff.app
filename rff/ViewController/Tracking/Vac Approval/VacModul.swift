//
//  VacModul.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

// From GetData service

struct EmployeeGeneralInfo{
    var EmpName: String
    var JoinDate: String
    var StartDate: String
    var ManagerName: String
    var JobDesc: String
    var SubJobDesc: String
    var Department: String
    var Nationality: String
}

struct LeaveDetails{
    var NumberofDays: String
    var LeaveStartDate: String
    var ReturnDate: String
    var RequestDate: String
    var VacationType: String
    var ExitReEntry: String
    var ExitReEntryDays: String
    var City: String
    var Vacation_Number: String
}

struct AdministrativeUse{
    var VacTypeAdmin: String
    var VacationDays_Details: String
    var Used_Details: String
    var Requested: String
    var Remaining_Detail: String
}

struct CompanionsDetails{
    var Name_Companion: String
    var City_Companion: String
    var DOB_Companion: String
    var VisaRequest_Companion: String
}

struct SettlementAndTicketDetails{
    var Total_SettlementAmount: String
    var TicketRequired: String
}










