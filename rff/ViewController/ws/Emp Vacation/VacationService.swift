//
//  VacationServices.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 29/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class VacationService{
    static let shared = VacationService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/ios.asmx"
    private var Host: String = "82.118.166.164"
    
    private func EmployeeInfoArrayValues(data: Data) -> [EmpInfoModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [EmpInfoModul] = [EmpInfoModul]()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = EmpInfoModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "Emp_Id" {
                            if let strValInt = Int(strVal){ rItem1.Emp_Id = strValInt }
                        }
                        else if elemName == "Emp_Ename" { rItem1.Emp_Ename = strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: [EmpInfoModul] = EmployeeInfoArrayValues(data: responseData)
        return returnValue
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: [EmpInfoModul] = EmployeeInfoArrayValues(data: responseData)
        return returnValue
    }
    
    private func VacInfoArrayValues(data: Data) -> [VacTypeInfoModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [VacTypeInfoModul] = [VacTypeInfoModul]()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = VacTypeInfoModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "Vac_Type" { rItem1.Vac_Type = strVal }
                        else if elemName == "Vac_Desc" { rItem1.Vac_Desc = strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: [VacTypeInfoModul] = VacInfoArrayValues(data: responseData)
        return returnValue
    }
    
    private func empDepVacTicketInfoArrayValues(data: Data) -> [EmpDepVacTicketInfoModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [EmpDepVacTicketInfoModul] = [EmpDepVacTicketInfoModul]()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = EmpDepVacTicketInfoModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    elemName = elem1!.name
                    if elemName == "RequireVisa" {
                        if let strValInt = Int(strVal){ rItem1.RequireVisa = strValInt }
                    }
                    else if elemName == "Ticket" { rItem1.Ticket =  strVal }
                    else if elemName == "DependentName" { rItem1.DependentName =  strVal }
                    else if elemName == "BirthDate" { rItem1.BirthDate =  strVal }
                    else if elemName == "Age" { rItem1.Age =  strVal }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue:[EmpDepVacTicketInfoModul] = empDepVacTicketInfoArrayValues(data: responseData)
        return returnValue
    }
    
    private func VacDetailsArrayValues(data: Data) -> EmpVacationDetailsModul {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        let returnValue: EmpVacationDetailsModul = EmpVacationDetailsModul()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let xmlResult1: XMLIndexer? =  xmlResult0?.children[i1]
                let elem1: XMLElement? =  xmlResult1?.element
                
                strVal = commonFunction.getStrValue(elem1: elem1)
                if let element = elem1{
                    elemName = element.name
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
                }
            }
        }
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: EmpVacationDetailsModul = VacDetailsArrayValues(data: responseData)
        return returnValue
    }
    
    private func UpdateVacDetailsArrayValues(data: Data) -> UpdateVacationDetailsInfoModul {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        let returnValue: UpdateVacationDetailsInfoModul = UpdateVacationDetailsInfoModul()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let xmlResult1: XMLIndexer? =  xmlResult0?.children[i1]
                let elem1: XMLElement? =  xmlResult1?.element
                
                strVal = commonFunction.getStrValue(elem1: elem1)
                if let element = elem1{
                    elemName = element.name
                    if elemName == "exitrentry" { returnValue.exitrentry =  strVal }
                    else if elemName == "Emp_Id" { returnValue.Emp_Id =  strVal }
                    else if elemName == "Balance_Vacation" { returnValue.Balance_Vacation =  strVal }
                    else if elemName == "Number_Days" { returnValue.Number_Days =  strVal }
                    else if elemName == "ExitReEntry" { returnValue.ExitReEntry =  strVal }
                    else if elemName == "RequireVisa" { returnValue.RequireVisa =  strVal }
                }
            }
        }
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: UpdateVacationDetailsInfoModul = UpdateVacDetailsArrayValues(data: responseData)
        return returnValue
    }
    
    private func settlementDetailsArrayValues(data: Data) -> settlmentDetailsModul {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        let returnValue: settlmentDetailsModul = settlmentDetailsModul()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let xmlResult1: XMLIndexer? =  xmlResult0?.children[i1]
                let elem1: XMLElement? =  xmlResult1?.element
                
                strVal = commonFunction.getStrValue(elem1: elem1)
                if let element = elem1{
                    elemName = element.name
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
                }
            }
        }
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: settlmentDetailsModul = settlementDetailsArrayValues(data: responseData)
        return returnValue
    }
    
    private func sumbitArrayValues(data: Data) -> submitModul {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        let returnValue: submitModul = submitModul()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let xmlResult1: XMLIndexer? =  xmlResult0?.children[i1]
                let elem1: XMLElement? =  xmlResult1?.element
                
                strVal = commonFunction.getStrValue(elem1: elem1)
                if let element = elem1{
                    elemName = element.name
                    if elemName == "Error" { returnValue.Error =  strVal }
                    else if elemName == "PID" { returnValue.PID =  strVal }
                }
            }
        }
        return returnValue
    }
    
    func SubmitEmpVacation(emp_no:String, delegateid:String, vacationtype:String, tickekreq:Int, settlementamt:Double, leavestartdate:String, leavertndate:String, numberofdays:String, dependenttck:String, exitreentry:Int, comment:String, error:String) -> submitModul{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let returnValue: submitModul = sumbitArrayValues(data : responseData)
        return returnValue
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
        
        let _: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
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
        
        let _: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        return ""
    }
}
