//
//  LoanApprovalService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class LoanApprovalService{
    static let shared = LoanApprovalService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/approvals/loan_app.asmx"
    private var Host: String = "82.118.166.164"
    
    private func Loan_AppArrFValues(data: Data)-> [LoanApprovalModul] {
        
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue:[LoanApprovalModul] = [LoanApprovalModul]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = LoanApprovalModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    
                    elemName = elem1!.name
                    if elemName == "LoanType" { rItem1.LoanType =  strVal }
                    else if elemName == "Emp_ID" { rItem1.Emp_ID =  strVal }
                    else if elemName == "AmountRequired" { rItem1.AmountRequired =  strVal }
                    else if elemName == "Guarantor_Name" { rItem1.Guarantor_Name =  strVal }
                    else if elemName == "PayPeriod" { rItem1.PayPeriod =  strVal }
                    else if elemName == "Monthly_Pay" { rItem1.Monthly_Pay =  strVal }
                    else if elemName == "CreatedDate" { rItem1.CreatedDate =  strVal }
                    else if elemName == "Emp_Name" { rItem1.Emp_Name =  strVal }
                    else if elemName == "Join_Date" { rItem1.Join_Date =  strVal }
                    else if elemName == "Start_Date" { rItem1.Start_Date =  strVal }
                    else if elemName == "Company" { rItem1.Company =  strVal }
                    else if elemName == "Manager" { rItem1.Manager =  strVal }
                    else if elemName == "Job_Desc" { rItem1.Job_Desc =  strVal }
                    else if elemName == "Sub_JobDesc" { rItem1.Sub_JobDesc =  strVal }
                    else if elemName == "Department" { rItem1.Department =  strVal }
                    else if elemName == "Nationality" { rItem1.Nationality =  strVal }
                    else if elemName == "Basic_Sal" { rItem1.Basic_Sal =  strVal }
                    else if elemName == "Package" { rItem1.Package =  strVal }
                    else if elemName == "L_Date" { rItem1.L_Date =  strVal }
                    else if elemName == "L_StartDate" { rItem1.L_StartDate =  strVal }
                    else if elemName == "L_Guarantor" { rItem1.L_Guarantor =  strVal }
                    else if elemName == "L_LoanType" { rItem1.L_LoanType =  strVal }
                    else if elemName == "L_Amount" { rItem1.L_Amount =  strVal }
                    else if elemName == "L_MonthlyPay" { rItem1.L_MonthlyPay =  strVal }
                    else if elemName == "L_DeductedValue" { rItem1.L_DeductedValue =  strVal }
                    else if elemName == "L_BalAmount" { rItem1.L_BalAmount =  strVal }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    func Get_Emps_Details(langid: Int, emp_id: String, pid: String, fid: String, loanemp_id: String) -> [LoanApprovalModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_Emps_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<fid>"
        soapReqXML += fid
        soapReqXML += "</fid>"
        soapReqXML += "<loanemp_id>"
        soapReqXML += loanemp_id
        soapReqXML += "</loanemp_id>"
        soapReqXML += "</Get_Emps_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Get_Emps_Details"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue: [LoanApprovalModul] = Loan_AppArrFValues(data : responseData)
        return returnValue
    }
    
    private func Loan_AppApproversValues(data: Data) -> [WorkFlowModul] {
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
    
    func BindApproversGrid(formid:Int, pid:String, langid:Int)-> [WorkFlowModul]{
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
        let returnValue: [WorkFlowModul] = Loan_AppApproversValues(data : responseData)
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
    
    func Approve_Loan(Emp_ID:String, pid:String, buttonType:String, FormId:Int, Comment:String, grid_empid:String, totalgrd_rows:Int, login_empId:String, finalApp_EmpId:String, finalApp_Status:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_Loan xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<Emp_ID>"
        soapReqXML += Emp_ID
        soapReqXML += "</Emp_ID>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
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
        soapReqXML += "<totalgrd_rows>"
        soapReqXML += String(totalgrd_rows)
        soapReqXML += "</totalgrd_rows>"
        soapReqXML += "<login_empId>"
        soapReqXML += login_empId
        soapReqXML += "</login_empId>"
        soapReqXML += "<finalApp_EmpId>"
        soapReqXML += finalApp_EmpId
        soapReqXML += "</finalApp_EmpId>"
        soapReqXML += "<finalApp_Status>"
        soapReqXML += finalApp_Status
        soapReqXML += "</finalApp_Status>"
        soapReqXML += "</Approve_Loan>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_Loan"
        
        let responseData: Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData)
        
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
