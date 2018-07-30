//
//  VacData.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 25/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class VacData{
    static let shared = VacData()
    private var EmpName = ""
    private var JoinDate = ""
    private var StartDate = ""
    private var ManagerName = ""
    private var JobDesc = ""
    private var SubJobDesc = ""
    private var Department = ""
    private var Nationality = ""
    private var NumberofDays = ""
    private var LeaveStartDate = ""
    private var ReturnDate = ""
    private var RequestDate = ""
    private var VacationType = ""
    private var ExitReEntry = ""
    private var ExitReEntryDays = ""
    private var City = ""
    private var VacNumber = ""
    private var VacTypeAdmin = ""
    private var VacationDays_Details = ""
    private var Used_Details = ""
    private var Requested = ""
    private var Remaining_Detail = ""
    var companionsDetailsArray = [CompanionsDetails]()
    private var Total_SettlementAmount = ""
    private var TicketRequired = ""
    
    func setEmpGeneralInfo(empVac: VacationApprovalModul) -> EmployeeGeneralInfo{
        EmpName = EmpName == "" ? empVac.EmpName : EmpName
        JoinDate = JoinDate == "" ? empVac.JoinDate : JoinDate
        StartDate = StartDate == "" ? empVac.StartDate : StartDate
        ManagerName = ManagerName == "" ? empVac.ManagerName : ManagerName
        JobDesc = JobDesc == "" ? empVac.JobDesc : JobDesc
        SubJobDesc = SubJobDesc == "" ? empVac.SubJobDesc : SubJobDesc
        Department = Department == "" ? empVac.Department : Department
        Nationality = Nationality == "" ? empVac.Nationality : Nationality
        
        return EmployeeGeneralInfo(EmpName: EmpName,
                                   JoinDate: JoinDate,
                                   StartDate: StartDate,
                                   ManagerName: ManagerName,
                                   JobDesc: JobDesc,
                                   SubJobDesc: SubJobDesc,
                                   Department: Department,
                                   Nationality: Nationality)
    }
    
    func setleaveDetailsInfo(empVac: VacationApprovalModul) -> LeaveDetails {
        NumberofDays = NumberofDays == "" ? empVac.NumberofDays : NumberofDays
        LeaveStartDate = LeaveStartDate == "" ? empVac.LeaveStartDate : LeaveStartDate
        ReturnDate = ReturnDate == "" ? empVac.ReturnDate : ReturnDate
        RequestDate = RequestDate == "" ? empVac.RequestDate : RequestDate
        VacationType = VacationType == "" ? empVac.VacationType : VacationType
        ExitReEntry = ExitReEntry == "" ? empVac.ExitReEntry : ExitReEntry
        ExitReEntryDays = ExitReEntryDays == "" ? empVac.ExitReEntryDays : ExitReEntryDays
        City = City == "" ? empVac.City : City
        VacNumber = VacNumber == "" ? empVac.Vacation_Number : VacNumber
        
        return LeaveDetails(NumberofDays: NumberofDays,
                            LeaveStartDate: LeaveStartDate,
                            ReturnDate: ReturnDate,
                            RequestDate: RequestDate,
                            VacationType: VacationType,
                            ExitReEntry: ExitReEntry,
                            ExitReEntryDays: ExitReEntryDays,
                            City: City,
                            Vacation_Number: VacNumber)
    }
    
    func setAdministrativeUse(empVac: VacationApprovalModul) -> AdministrativeUse{
        VacTypeAdmin = VacTypeAdmin == "" ? empVac.VacTypeAdmin : VacTypeAdmin
        VacationDays_Details = VacationDays_Details == "" ? empVac.VacationDays_Details : VacationDays_Details
        Used_Details = Used_Details == "" ? empVac.Used_Details : Used_Details
        Requested = Requested == "" ? empVac.Requested : Requested
        Remaining_Detail = Remaining_Detail == "" ? empVac.Remaining_Detail : Remaining_Detail
        
        return AdministrativeUse(VacTypeAdmin: VacTypeAdmin,
                                 VacationDays_Details: VacationDays_Details,
                                 Used_Details: Used_Details,
                                 Requested: Requested,
                                 Remaining_Detail: Remaining_Detail)
    }
    
    func setCompanionsDetails(empVac: VacationApprovalModul) -> [CompanionsDetails]{
        if empVac.Name_Companion != ""{
            companionsDetailsArray.append(CompanionsDetails(Name_Companion: empVac.Name_Companion,
                                                            City_Companion: empVac.City_Companion,
                                                            DOB_Companion: empVac.DOB_Companion,
                                                            VisaRequest_Companion: empVac.VisaRequest_Companion))
        }
        
        return companionsDetailsArray
    }
    
    func setSettlementAndTicketDetails(empVac: VacationApprovalModul) -> SettlementAndTicketDetails{
        Total_SettlementAmount = Total_SettlementAmount == "" ? empVac.Total_SettlementAmount : Total_SettlementAmount
        TicketRequired = TicketRequired == "" ? empVac.TicketRequired : TicketRequired
        
        return SettlementAndTicketDetails(Total_SettlementAmount: Total_SettlementAmount,
                                          TicketRequired: TicketRequired)
    }
    
    func setValueToDefault(){
        EmpName = ""
        JoinDate = ""
        StartDate = ""
        ManagerName = ""
        JobDesc = ""
        SubJobDesc = ""
        Department = ""
        Nationality = ""
        NumberofDays = ""
        LeaveStartDate = ""
        ReturnDate = ""
        RequestDate = ""
        VacationType = ""
        ExitReEntry = ""
        ExitReEntryDays = ""
        City = ""
        VacTypeAdmin = ""
        VacationDays_Details = ""
        Used_Details = ""
        Requested = ""
        Remaining_Detail = ""
        Total_SettlementAmount = ""
        companionsDetailsArray = [CompanionsDetails]()
        TicketRequired = ""
    }
    
}
















