//
//  VacactionApprovalService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class VacactionApprovalService{
    static let shared = VacactionApprovalService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/approvals/vac_app.asmx"
    private var Host: String = "82.118.166.164"
    
    private func Vac_AppArrValues(data: Data) -> [VacationApprovalModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [VacationApprovalModul] = [VacationApprovalModul]()
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = VacationApprovalModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "NumberofDays" { rItem1.NumberofDays =  strVal }
                        else if elemName == "LeaveStartDate" { rItem1.LeaveStartDate =  strVal }
                        else if elemName == "ReturnDate" { rItem1.ReturnDate =  strVal }
                        else if elemName == "RequestDate" { rItem1.RequestDate =  strVal }
                        else if elemName == "VacationType" { rItem1.VacationType =  strVal }
                        else if elemName == "ExitReEntry" { rItem1.ExitReEntry =  strVal }
                        else if elemName == "ExitReEntryDays" { rItem1.ExitReEntryDays =  strVal }
                        else if elemName == "VacTypeAdmin" { rItem1.VacTypeAdmin =  strVal }
                        else if elemName == "TicketRequired" { rItem1.TicketRequired =  strVal }
                        else if elemName == "Vacation_Number" { rItem1.Vacation_Number =  strVal }
                        else if elemName == "Requested" { rItem1.Requested =  strVal }
                        else if elemName == "Total_SettlementAmount" { rItem1.Total_SettlementAmount =  strVal }
                        else if elemName == "EmpName" { rItem1.EmpName =  strVal }
                        else if elemName == "JoinDate" { rItem1.JoinDate =  strVal }
                        else if elemName == "StartDate" { rItem1.StartDate =  strVal }
                        else if elemName == "ManagerName" { rItem1.ManagerName =  strVal }
                        else if elemName == "JobDesc" { rItem1.JobDesc =  strVal }
                        else if elemName == "SubJobDesc" { rItem1.SubJobDesc =  strVal }
                        else if elemName == "Department" { rItem1.Department =  strVal }
                        else if elemName == "Nationality" { rItem1.Nationality =  strVal }
                        else if elemName == "City" { rItem1.City =  strVal }
                        else if elemName == "VacationDays_Details" { rItem1.VacationDays_Details =  strVal }
                        else if elemName == "Used_Details" { rItem1.Used_Details =  strVal }
                        else if elemName == "Remaining_Detail" { rItem1.Remaining_Detail =  strVal }
                        else if elemName == "Name_Companion" { rItem1.Name_Companion =  strVal }
                        else if elemName == "City_Companion" { rItem1.City_Companion =  strVal }
                        else if elemName == "DOB_Companion" { rItem1.DOB_Companion =  strVal }
                        else if elemName == "VisaRequest_Companion" { rItem1.VisaRequest_Companion =  strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    func GetData(langid:Int, pid:String, emp_number:String) -> [VacationApprovalModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetData xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "</GetData>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetData"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[VacationApprovalModul] = Vac_AppArrValues(data : responseData)
        return returnValue
    }
    
    private func Vac_AppApproversValues(data: Data) -> [WorkFlowModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [WorkFlowModul] = [WorkFlowModul]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = WorkFlowModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "WorkFlow_Empid" { rItem1.WorkFlow_Empid =  strVal }
                        else if elemName == "WorkFlow_EmpName" { rItem1.WorkFlow_EmpName =  strVal }
                        else if elemName == "WorkFlow_EmpRole" { rItem1.WorkFlow_EmpRole =  strVal }
                        else if elemName == "WorkFlow_EmpStatus" { rItem1.WorkFlow_EmpStatus =  strVal }
                        else if elemName == "WorkFlow_EmpTransDate" { rItem1.WorkFlow_EmpTransDate =  strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    func BindApproversGrid(formid:Int, pid:String, langid: Int)-> [WorkFlowModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindApproversGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<formid>"
        soapReqXML += String(formid)
        soapReqXML += "</formid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</BindApproversGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindApproversGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue: [WorkFlowModul] = Vac_AppApproversValues(data : responseData)
        return returnValue
    }
    
    private func Vac_AppCommentValues(data: Data) -> [CommentModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [CommentModul] = [CommentModul]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = CommentModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "Cmt_Name" { rItem1.Cmt_Name =  strVal }
                        else if elemName == "Cmt_Comment" { rItem1.Cmt_Comment =  strVal }
                        else if elemName == "Cmt_Id" { rItem1.Cmt_Id =  strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    func BindCommentGrid(pid:String, fid:Int, gvApp_RowCount:Int) -> [CommentModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCommentGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<fid>"
        soapReqXML += String(fid)
        soapReqXML += "</fid>"
        soapReqXML += "<gvApp_RowCount>"
        soapReqXML += String(gvApp_RowCount)
        soapReqXML += "</gvApp_RowCount>"
        soapReqXML += "</BindCommentGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindCommentGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue: [CommentModul] = Vac_AppCommentValues(data : responseData)
        return returnValue
    }
    
    func Approve_Vacation(vac_number:String, Emp_ID:String, fid:String, pid:String, comment:String, buttonType:String, FormId:Int, Comment:String, grid_empid:String, totalgrd_rows:Int?, login_empId:String, finalApp_EmpId:String, finalApp_Status:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_Vacation xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<vac_number>"
        soapReqXML += vac_number
        soapReqXML += "</vac_number>"
        soapReqXML += "<Emp_ID>"
        soapReqXML += Emp_ID
        soapReqXML += "</Emp_ID>"
        soapReqXML += "<fid>"
        soapReqXML += fid
        soapReqXML += "</fid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<buttonType>"
        soapReqXML += buttonType
        soapReqXML += "</buttonType>"
        soapReqXML += "<FormId>"
        soapReqXML += String(FormId)
        soapReqXML += "</FormId>"
        soapReqXML += "<Comment>"
        soapReqXML += Comment
        soapReqXML += "</Comment>"
        soapReqXML += "<grid_empid>"
        soapReqXML += grid_empid
        soapReqXML += "</grid_empid>"
        soapReqXML += "<totalgrd_rows"
        
        if totalgrd_rows == nil {
            soapReqXML += "xsi:nil=\"true\" />"
        }
        else {
            soapReqXML += ">"
            soapReqXML += (totalgrd_rows == nil ?"":String( totalgrd_rows! ) )
            soapReqXML += "</totalgrd_rows>"
        }
        
        soapReqXML += "<login_empId>"
        soapReqXML += login_empId
        soapReqXML += "</login_empId>"
        soapReqXML += "<finalApp_EmpId>"
        soapReqXML += finalApp_EmpId
        soapReqXML += "</finalApp_EmpId>"
        soapReqXML += "<finalApp_Status>"
        soapReqXML += finalApp_Status
        soapReqXML += "</finalApp_Status>"
        soapReqXML += "</Approve_Vacation>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_Vacation"
        
        let responseData: Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData)
        
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
