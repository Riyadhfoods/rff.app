//
//  VacationServices.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 29/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class VacationService{
    static let instance = VacationService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentHost)/ios_hrms/ios.asmx"
    
    private var returnValueForBindEmpsVacationsDropDown = EmpInfoModul()
    private func getElementValueForBindEmpsVacationsDropDown(elemName: String, strVal: String) -> EmpInfoModul{
        let rItem1 = returnValueForBindEmpsVacationsDropDown
        if elemName == "Emp_Id" {
            if let strValInt = Int(strVal){ rItem1.Emp_Id = strValInt }
        }
        else if elemName == "Emp_Ename" { rItem1.Emp_Ename = strVal }
        return rItem1
    }
    
    func BindEmpsVacationsDropDown(langid: Int, Emp_no: String)-> [EmpInfoModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindEmpsVacationsDropDown xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<Emp_no>"
        soapReqXML += Emp_no
        soapReqXML += "</Emp_no>"
        soapReqXML += "</BindEmpsVacationsDropDown>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindEmpsVacationsDropDown"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindEmpsVacationsDropDown = EmpInfoModul() }, getValue: {elementName, value in
            self.getElementValueForBindEmpsVacationsDropDown(elemName: elementName, strVal: value)
        }) as? [EmpInfoModul]{ return returnValue }
        
        return [EmpInfoModul]()
    }
    
    func BindDelegateVacationsDropDown(langid: Int, Emp_no: String)-> [EmpInfoModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindDelegateVacationsDropDown xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<Emp_no>"
        soapReqXML += Emp_no
        soapReqXML += "</Emp_no>"
        soapReqXML += "</BindDelegateVacationsDropDown>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindDelegateVacationsDropDown"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindEmpsVacationsDropDown = EmpInfoModul() }, getValue: {elementName, value in
            self.getElementValueForBindEmpsVacationsDropDown(elemName: elementName, strVal: value)
        }) as? [EmpInfoModul]{ return returnValue }
        
        return [EmpInfoModul]()
    }
    
    private var returnValueForBindVacationType_DDL = VacTypeInfoModul()
    private func getElementValueForBindVacationType_DDL(elemName: String, strVal: String) -> VacTypeInfoModul{
        let rItem1 = returnValueForBindVacationType_DDL
        if elemName == "Vac_Type" { rItem1.Vac_Type = strVal }
        else if elemName == "Vac_Desc" { rItem1.Vac_Desc = strVal }
        return rItem1
    }
    
    func BindVacationType_DDL(langid: Int) -> [VacTypeInfoModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindVacationType_DDL xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</BindVacationType_DDL>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindVacationType_DDL"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindVacationType_DDL = VacTypeInfoModul() }, getValue: {elementName, value in
            self.getElementValueForBindVacationType_DDL(elemName: elementName, strVal: value)
        }) as? [VacTypeInfoModul]{ return returnValue }
        
        return [VacTypeInfoModul]()
    }
    
    private var returnValueForGetEmpVacationTickets = EmpDepVacTicketInfoModul()
    private func getElementValueForGetEmpVacationTickets(elemName: String, strVal: String) -> EmpDepVacTicketInfoModul{
        let rItem1 = returnValueForGetEmpVacationTickets
        if elemName == "RequireVisa" {
            if let strValInt = Int(strVal){ rItem1.RequireVisa = strValInt }
        }
        else if elemName == "Ticket" { rItem1.Ticket =  strVal }
        else if elemName == "DependentName" { rItem1.DependentName =  strVal }
        else if elemName == "BirthDate" { rItem1.BirthDate =  strVal }
        else if elemName == "Age" { rItem1.Age =  strVal }
        return rItem1
    }
    
    func GetEmpVacationTickets(emp_id: String, langId: Int) -> [EmpDepVacTicketInfoModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetEmpVacationTickets xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<langId>"
        soapReqXML += String(langId)
        soapReqXML += "</langId>"
        soapReqXML += "</GetEmpVacationTickets>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetEmpVacationTickets"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForGetEmpVacationTickets = EmpDepVacTicketInfoModul() }, getValue: {elementName, value in
            self.getElementValueForGetEmpVacationTickets(elemName: elementName, strVal: value)
        }) as? [EmpDepVacTicketInfoModul]{ return returnValue }
        
        return [EmpDepVacTicketInfoModul]()
    }
    
    private var returnValueForGetEmpVacationDetails = EmpVacationDetailsModul()
    private func getElementValueForGetEmpVacationDetails(elemName: String, strVal: String) -> EmpVacationDetailsModul{
        let returnValue = returnValueForGetEmpVacationDetails
        if elemName == "exitrentry" { returnValue.exitrentry = strVal }
        else if elemName == "extradays" { returnValue.extradays = strVal }
        else if elemName == "Job_Num" { returnValue.Job_Num = strVal }
        else if elemName == "Job_English" { returnValue.Job_English = strVal }
        else if elemName == "Sub_Job_Num" { returnValue.Sub_Job_Num = strVal }
        else if elemName == "Sub_Job_English" { returnValue.Sub_Job_English = strVal }
        else if elemName == "Nationality_Num" { returnValue.Nationality_Num = strVal }
        else if elemName == "Nationality_English" { returnValue.Nationality_English = strVal }
        else if elemName == "Manager_Id" { returnValue.Manager_Id = strVal }
        else if elemName == "Manager_English" { returnValue.Manager_English = strVal }
        else if elemName == "Department_Num" { returnValue.Department_Num = strVal }
        else if elemName == "Department_English" { returnValue.Department_English = strVal }
        else if elemName == "JoinDate" { returnValue.JoinDate = strVal }
        else if elemName == "StartDate" { returnValue.StartDate = strVal }
        else if elemName == "Leave_Start_Dt" { returnValue.Leave_Start_Dt = strVal }
        else if elemName == "Leave_Return_Dt" { returnValue.Leave_Return_Dt = strVal }
        else if elemName == "Balance_Vacation" { returnValue.Balance_Vacation = strVal }
        else if elemName == "Number_Days" { returnValue.Number_Days = strVal }
        else if elemName == "ExitReEntry" { returnValue.ExitReEntry = strVal }
        else if elemName == "ExtraDays" { returnValue.ExtraDays = strVal }
        else if elemName == "SettlementAmount" { returnValue.SettlementAmount = strVal }
        else if elemName == "Dependent_Ticket" { returnValue.Dependent_Ticket = strVal }
        else if elemName == "RequireVisa" { returnValue.RequireVisa = strVal }
        return returnValue
    }
    
    public func GetEmpVacationDetails(langid: Int, Emp_no: String) -> EmpVacationDetailsModul{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetEmpVacationDetails xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<Emp_no>"
        soapReqXML += Emp_no
        soapReqXML += "</Emp_no>"
        soapReqXML += "</GetEmpVacationDetails>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetEmpVacationDetails"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.Values(data: responseData, reSet: { returnValueForGetEmpVacationDetails = EmpVacationDetailsModul() }, getValue: { (elementName, value) -> AnyObject in
            self.getElementValueForGetEmpVacationDetails(elemName: elementName, strVal: value)
        }) as? EmpVacationDetailsModul{ return returnValue }
        
        return EmpVacationDetailsModul()
    }
    
    private var returnValueForcalculateActualVacatioDays = UpdateVacationDetailsInfoModul()
    private func getElementValueForcalculateActualVacatioDays(elemName: String, strVal: String) -> UpdateVacationDetailsInfoModul{
        let returnValue = returnValueForcalculateActualVacatioDays
        if elemName == "exitrentry" { returnValue.exitrentry =  strVal }
        else if elemName == "Emp_Id" { returnValue.Emp_Id =  strVal }
        else if elemName == "Balance_Vacation" { returnValue.Balance_Vacation =  strVal }
        else if elemName == "Number_Days" { returnValue.Number_Days =  strVal }
        else if elemName == "ExitReEntry" { returnValue.ExitReEntry =  strVal }
        else if elemName == "RequireVisa" { returnValue.RequireVisa =  strVal }
        return returnValue
    }
    
    func calculateActualVacatioDays(employee_id: Int, startdate: String, leavedate: String) -> UpdateVacationDetailsInfoModul{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<calculateActualVacatioDays xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<employee_id>"
        soapReqXML += String(employee_id)
        soapReqXML += "</employee_id>"
        soapReqXML += "<startdate>"
        soapReqXML += startdate
        soapReqXML += "</startdate>"
        soapReqXML += "<leavedate>"
        soapReqXML += leavedate
        soapReqXML += "</leavedate>"
        soapReqXML += "</calculateActualVacatioDays>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/calculateActualVacatioDays"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.Values(data: responseData, reSet: { returnValueForcalculateActualVacatioDays = UpdateVacationDetailsInfoModul() }, getValue: { (elementName, value) -> AnyObject in
            self.getElementValueForcalculateActualVacatioDays(elemName: elementName, strVal: value)
        }) as? UpdateVacationDetailsInfoModul{ return returnValue }
        
        return UpdateVacationDetailsInfoModul()
    }
    
    private var returnValueForget_settlement_details = settlmentDetailsModul()
    private func getElementValueForget_settlement_details(elemName: String, strVal: String) -> settlmentDetailsModul{
        let returnValue = returnValueForget_settlement_details
        if elemName == "TotalSettlementAmount" { returnValue.TotalSettlementAmount = strVal }
        else if elemName == "DiffTicketAmount" { returnValue.DiffTicketAmount = strVal }
        else if elemName == "NetTicketPrice" { returnValue.NetTicketPrice = strVal }
        else if elemName == "TicketPercent" { returnValue.TicketPercent = strVal }
        else if elemName == "TicketAmount" { returnValue.TicketAmount = strVal }
        else if elemName == "TicketPrice" { returnValue.TicketPrice = strVal }
        else if elemName == "VNet" { returnValue.VNet = strVal }
        else if elemName == "VAllowances" { returnValue.VAllowances = strVal }
        else if elemName == "VTotal" { returnValue.VTotal = strVal }
        else if elemName == "VBasic" { returnValue.VBasic = strVal }
        else if elemName == "SNet" { returnValue.SNet = strVal }
        else if elemName == "STotal" { returnValue.STotal = strVal }
        else if elemName == "SAllowances" { returnValue.SAllowances = strVal }
        else if elemName == "SBasic" { returnValue.SBasic = strVal }
        else if elemName == "SDeduction" { returnValue.SDeduction = strVal }
        return returnValue
    }
    
    func get_settlement_details(vacationtype: String, langid: Int, emp_no: String, startdate: String, ticket: Int)-> settlmentDetailsModul{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<get_settlement_details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<vacationtype>"
        soapReqXML += vacationtype
        soapReqXML += "</vacationtype>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<emp_no>"
        soapReqXML += emp_no
        soapReqXML += "</emp_no>"
        soapReqXML += "<startdate>"
        soapReqXML += startdate
        soapReqXML += "</startdate>"
        soapReqXML += "<ticket>"
        soapReqXML += String(ticket)
        soapReqXML += "</ticket>"
        soapReqXML += "</get_settlement_details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/get_settlement_details"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.Values(data: responseData, reSet: { returnValueForget_settlement_details = settlmentDetailsModul() }, getValue: { (elementName, value) -> AnyObject in
            self.getElementValueForget_settlement_details(elemName: elementName, strVal: value)
        }) as? settlmentDetailsModul{ return returnValue }
        
        return settlmentDetailsModul()
    }
    
    private var returnValueForSubmitEmpVacation = submitModul()
    private func getElementValueForSubmitEmpVacation(elemName: String, strVal: String) -> submitModul{
        let returnValue = returnValueForSubmitEmpVacation
        if elemName == "Error" { returnValue.Error =  strVal }
        else if elemName == "PID" { returnValue.PID =  strVal }
        return returnValue
    }
    
    func SubmitEmpVacation(emp_no:String, delegateid:String, vacationtype:String, tickekreq:Int, settlementamt:Double, leavestartdate:String, leavertndate:String, numberofdays:String, dependenttck:String, exitreentry:Int, comment:String, error:String) -> submitModul{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SubmitEmpVacation xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_no>"
        soapReqXML += emp_no
        soapReqXML += "</emp_no>"
        soapReqXML += "<delegateid>"
        soapReqXML += delegateid
        soapReqXML += "</delegateid>"
        soapReqXML += "<vacationtype>"
        soapReqXML += vacationtype
        soapReqXML += "</vacationtype>"
        soapReqXML += "<tickekreq>"
        soapReqXML += String(tickekreq)
        soapReqXML += "</tickekreq>"
        soapReqXML += "<settlementamt>"
        soapReqXML += String(settlementamt)
        soapReqXML += "</settlementamt>"
        soapReqXML += "<leavestartdate>"
        soapReqXML += leavestartdate
        soapReqXML += "</leavestartdate>"
        soapReqXML += "<leavertndate>"
        soapReqXML += leavertndate
        soapReqXML += "</leavertndate>"
        soapReqXML += "<numberofdays>"
        soapReqXML += numberofdays
        soapReqXML += "</numberofdays>"
        soapReqXML += "<dependenttck>"
        soapReqXML += dependenttck
        soapReqXML += "</dependenttck>"
        soapReqXML += "<exitreentry>"
        soapReqXML += String(exitreentry)
        soapReqXML += "</exitreentry>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</SubmitEmpVacation>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SubmitEmpVacation"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.Values(data: responseData, reSet: { returnValueForSubmitEmpVacation = submitModul() }, getValue: { (elementName, value) -> AnyObject in
            self.getElementValueForSubmitEmpVacation(elemName: elementName, strVal: value)
        }) as? submitModul{ return returnValue }
        
        return submitModul()
    }
    
    func save_settlement(emp_id: String, pid: String, sbasic: String, sallowances: String, stotal: String, snet: String, vbasic: String, vallowances: String, vtotal: String, vnet: String, ticketprice: String, ticketamount: String, ticketpercent: String, diffticketamount: String, netticketp: String, error: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<save_settlement xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<sbasic>"
        soapReqXML += sbasic
        soapReqXML += "</sbasic>"
        soapReqXML += "<sallowances>"
        soapReqXML += sallowances
        soapReqXML += "</sallowances>"
        soapReqXML += "<stotal>"
        soapReqXML += stotal
        soapReqXML += "</stotal>"
        soapReqXML += "<snet>"
        soapReqXML += snet
        soapReqXML += "</snet>"
        soapReqXML += "<vbasic>"
        soapReqXML += vbasic
        soapReqXML += "</vbasic>"
        soapReqXML += "<vallowances>"
        soapReqXML += vallowances
        soapReqXML += "</vallowances>"
        soapReqXML += "<vtotal>"
        soapReqXML += vtotal
        soapReqXML += "</vtotal>"
        soapReqXML += "<vnet>"
        soapReqXML += vnet
        soapReqXML += "</vnet>"
        soapReqXML += "<ticketprice>"
        soapReqXML += ticketprice
        soapReqXML += "</ticketprice>"
        soapReqXML += "<ticketamount>"
        soapReqXML += ticketamount
        soapReqXML += "</ticketamount>"
        soapReqXML += "<ticketpercent>"
        soapReqXML += ticketpercent
        soapReqXML += "</ticketpercent>"
        soapReqXML += "<diffticketamount>"
        soapReqXML += diffticketamount
        soapReqXML += "</diffticketamount>"
        soapReqXML += "<netticketp>"
        soapReqXML += netticketp
        soapReqXML += "</netticketp>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</save_settlement>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/save_settlement"
        
        let _: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        return ""
    }
    
    func UpdateVisaReq(emp_id: String, dep_name: String, value: Int, error: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<UpdateVisaReq xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<dep_name>"
        soapReqXML += dep_name
        soapReqXML += "</dep_name>"
        soapReqXML += "<value>"
        soapReqXML += String(value)
        soapReqXML += "</value>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</UpdateVisaReq>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/UpdateVisaReq"
        
        let _: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        return ""
    }
}
