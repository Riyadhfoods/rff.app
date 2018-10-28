//
//  InOutDeductionService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 05/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class InOutDeductionService{
    static let instance = InOutDeductionService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentHost)/ios_hrms/In_Out_deduction.asmx"
    
    func Bind_dllEmp(lang: Int, emp_id: String, formid: Int) -> [Emp_InfoModul]{
        var returnValueArray = Emp_InfoModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_dllEmp xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<formid>"
        soapReqXML += String(formid)
        soapReqXML += "</formid>"
        soapReqXML += "</Bind_dllEmp>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Bind_dllEmp"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = Emp_InfoModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Emp_Id" { rItem1.Emp_Id =  strVal }
            else if elemName == "Emp_Name" { rItem1.Emp_Name =  strVal }
            return rItem1
            
        }) as? [Emp_InfoModul]{ return returnValue }
        return [Emp_InfoModul]()
    }
    
    func save_data(comp: Int, emp_id_selected: String, formId: String, date: String, fromtime: String, totime: String, total_mins: String, creator_emp_id: String, comment: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<save_data xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<comp>"
        soapReqXML += String(comp)
        soapReqXML += "</comp>"
        soapReqXML += "<emp_id_selected>"
        soapReqXML += emp_id_selected
        soapReqXML += "</emp_id_selected>"
        soapReqXML += "<formId>"
        soapReqXML += formId
        soapReqXML += "</formId>"
        soapReqXML += "<date>"
        soapReqXML += date
        soapReqXML += "</date>"
        soapReqXML += "<fromtime>"
        soapReqXML += fromtime
        soapReqXML += "</fromtime>"
        soapReqXML += "<totime>"
        soapReqXML += totime
        soapReqXML += "</totime>"
        soapReqXML += "<total_mins>"
        soapReqXML += total_mins
        soapReqXML += "</total_mins>"
        soapReqXML += "<creator_emp_id>"
        soapReqXML += creator_emp_id
        soapReqXML += "</creator_emp_id>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</save_data>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/save_data"
        
        let responseData:Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    func Get_In_Out_Deduction_Data(lang: Int, pid: String)-> [In_Ou_Deduction_Modul]{
        var returnValueArray = In_Ou_Deduction_Modul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_In_Out_Deduction_Data xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "</Get_In_Out_Deduction_Data>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Get_In_Out_Deduction_Data"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = In_Ou_Deduction_Modul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Date" { rItem1.Date =  strVal }
            else if elemName == "From_Time" { rItem1.FromTime =  strVal }
            else if elemName == "To_Time" { rItem1.ToTime =  strVal }
            else if elemName == "Total_Min" { rItem1.TotalMin =  strVal }
            return rItem1
            
        }) as? [In_Ou_Deduction_Modul]{ return returnValue }
        return [In_Ou_Deduction_Modul]()
    }
    
    func Get_Emp_Details(lang:Int, emp_id:String)-> [Emp_Details_Modul]{
        var returnValueArray = Emp_Details_Modul()
        
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_Emp_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "</Get_Emp_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Get_Emp_Details"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = Emp_Details_Modul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Employee_Name" { rItem1.Employee_Name =  strVal }
            else if elemName == "Join_Date" { rItem1.Join_Date =  strVal }
            else if elemName == "Start_Date" { rItem1.Start_Date =  strVal }
            else if elemName == "Compnay" { rItem1.Compnay =  strVal }
            else if elemName == "MGR_Name" { rItem1.MGR_Name =  strVal }
            else if elemName == "Job_Desc" { rItem1.Job_Desc =  strVal }
            else if elemName == "Sub_Job_Desc" { rItem1.Sub_Job_Desc =  strVal }
            else if elemName == "Dept_Name" { rItem1.Dept_Name =  strVal }
            else if elemName == "Nationality" { rItem1.Nationality =  strVal }
            else if elemName == "Work_Hrs" { rItem1.Work_Hrs =  strVal }
            else if elemName == "Basic_Salary" { rItem1.Basic_Salary =  strVal }
            else if elemName == "Package" { rItem1.Package =  strVal }
            else if elemName == "Absent_Days" { rItem1.Absent_Days =  strVal }
            return rItem1
            
        }) as? [Emp_Details_Modul]{ return returnValue }
        return [Emp_Details_Modul]()
    }
    
    func BindApproversGrid(emp_id: String, formid: Int, pid: String, lang: Int)-> [WorkFlowModul]{
        var returnValueArray = WorkFlowModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindApproversGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<formid>"
        soapReqXML += String(formid)
        soapReqXML += "</formid>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</BindApproversGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindApproversGrid"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = WorkFlowModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "WorkFlow_Empid" { rItem1.WorkFlow_Empid =  strVal }
            else if elemName == "WorkFlow_EmpName" { rItem1.WorkFlow_EmpName =  strVal }
            else if elemName == "WorkFlow_EmpRole" { rItem1.WorkFlow_EmpRole =  strVal }
            else if elemName == "WorkFlow_EmpStatus" { rItem1.WorkFlow_EmpStatus =  strVal }
            else if elemName == "WorkFlow_EmpTransDate" { rItem1.WorkFlow_EmpTransDate =  strVal }
            return rItem1
            
        }) as? [WorkFlowModul]{ return returnValue }
        return [WorkFlowModul]()
    }
    
    func BindCommentGrid(pid:String, fid:Int, gvApp_RowCount:Int)-> [CommentModul]{
        var returnValueArray = CommentModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CommentModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Cmt_Name" { rItem1.Name =  strVal }
            else if elemName == "Cmt_Comment" { rItem1.Comment =  strVal }
            else if elemName == "Cmt_Id" { rItem1.Id =  strVal }
            return rItem1
            
        }) as? [CommentModul]{ return returnValue }
        return [CommentModul]()
    }
    
    func Approve_IOD(Emp_ID: String, pid: String, buttonType: String, FormId: Int, Comment: String, grid_empid: String, totalgrd_rows: Int, login_empId: String, finalApp_EmpId: String, finalApp_Status: String, gridEmpid_next: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_IOD xmlns=\"http://tempuri.org/\">"
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
        soapReqXML += "<gridEmpid_next>"
        soapReqXML += gridEmpid_next
        soapReqXML += "</gridEmpid_next>"
        soapReqXML += "</Approve_IOD>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_IOD"
        
        let responseData:Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
}















