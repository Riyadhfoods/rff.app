//
//  SalesCollectionApprovalService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 29/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesCollectionApprovalService{
    static let instance = SalesCollectionApprovalService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentIP)/\(current_host)/sales.asmx"
    
    func Get_Emps_Details(pid: String, fid: String, lang: String) -> CreatorAndCollectionDetailsModul{
        var returnValueArray = CreatorAndCollectionDetailsModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_Emps_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<fid>"
        soapReqXML += fid
        soapReqXML += "</fid>"
        soapReqXML += "<lang>"
        soapReqXML += lang
        soapReqXML += "</lang>"
        soapReqXML += "</Get_Emps_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Get_Emps_Details"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.Values(data: responseData, reSet: { returnValueArray = CreatorAndCollectionDetailsModul() }, getValue: { (elemName, strVal) -> AnyObject in
            let rItem1 = returnValueArray
            if elemName == "emp_name" { rItem1.emp_name =  strVal }
            else if elemName == "mgr_name" { rItem1.mgr_name =  strVal }
            else if elemName == "dept_name" { rItem1.dept_name =  strVal }
            else if elemName == "nationality" { rItem1.nationality =  strVal }
            else if elemName == "join_date" { rItem1.join_date =  strVal }
            else if elemName == "start_date" { rItem1.start_date =  strVal }
            else if elemName == "job_desc" { rItem1.job_desc =  strVal }
            else if elemName == "sub_job_desc" { rItem1.sub_job_desc =  strVal }
            else if elemName == "comp" { rItem1.comp =  strVal }
            else if elemName == "basic_salary" { rItem1.basic_salary =  strVal }
            else if elemName == "package" { rItem1.package =  strVal }
            else if elemName == "CustomerName" { rItem1.customer_name =  strVal }
            else if elemName == "salesPerson" { rItem1.sales_person =  strVal }
            else if elemName == "coll_type" { rItem1.coll_type =  strVal }
            else if elemName == "Territory" { rItem1.territory =  strVal }
            else if elemName == "InvoiceDate" { rItem1.invoice_date =  strVal }
            else if elemName == "InvoiceNo" { rItem1.invoice_no =  strVal }
            else if elemName == "amount" { rItem1.amount =  strVal }
            else if elemName == "CheckBookNo" { rItem1.check_book_no =  strVal }
            else if elemName == "error" { rItem1.error =  strVal }
            return rItem1
        }) as? CreatorAndCollectionDetailsModul{ return returnValue }
        
        return CreatorAndCollectionDetailsModul()
    }
    
    func BindApproversGrid_SC(emp_id: String, formid: Int, pid: String, langid: Int)-> [WorkFlowModul]{
        var returnValueArray = WorkFlowModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindApproversGrid_SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<formid>"
        soapReqXML += String(formid)
        soapReqXML += "</formid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</BindApproversGrid_SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindApproversGrid_SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = WorkFlowModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "ap_empid" { rItem1.WorkFlow_Empid =  strVal }
            else if elemName == "ap_empname" { rItem1.WorkFlow_EmpName = strVal }
            else if elemName == "ap_emprole" { rItem1.WorkFlow_EmpRole =  strVal }
            else if elemName == "ap_status" { rItem1.WorkFlow_EmpStatus =  strVal }
            else if elemName == "ap_Transdate" { rItem1.WorkFlow_EmpTransDate =  strVal }
            return rItem1
            
        }) as? [WorkFlowModul]{ return returnValue }
        
        return [WorkFlowModul]()
    }
    
    func Approve_SalesCollection(Emp_ID:String, fid:String, pid:String, comment:String,
                                 buttonType:String, FormId:Int, Comment:String,
                                 grid_empid:String, totalgrd_rows:Int, login_empId:String,
                                 finalApp_EmpId:String, finalApp_Status:String,
                                 gridEmpid_next:String) -> String{
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_SalesCollection xmlns=\"http://tempuri.org/\">"
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
        soapReqXML += "<gridEmpid_next>"
        soapReqXML += gridEmpid_next
        soapReqXML += "</gridEmpid_next>"
        soapReqXML += "</Approve_SalesCollection>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_SalesCollection"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
