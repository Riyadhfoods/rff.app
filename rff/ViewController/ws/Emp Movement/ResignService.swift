//
//  ResignService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 29/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class ResignService{
    static let instance = ResignService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/Resign.asmx"
    private var Host: String = "82.118.166.164"
    
    func Bind_ddlReason(lang: Int) -> [ReasonModul]{
        var returnValueArray = ReasonModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_ddlReason xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</Bind_ddlReason>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Bind_ddlReason"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ReasonModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "ID" { rItem1.ID =  strVal }
            else if elemName == "Reason" { rItem1.Reason =  strVal }
            return rItem1
            
        }) as? [ReasonModul]{ return returnValue }
        
        return [ReasonModul]()
    }
    
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = Emp_InfoModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Emp_Id" { rItem1.Emp_Id =  strVal }
            else if elemName == "Emp_Name" { rItem1.Emp_Name =  strVal }
            return rItem1
            
        }) as? [Emp_InfoModul]{ return returnValue }
        
        return [Emp_InfoModul]()
    }
    
    private func getElementValueForGet_Emp_Details(elemName: String, strVal: String, returnValueArray: ResignEmpDetailsModul) -> ResignEmpDetailsModul{
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
    }
    
    func Get_Emp_Details(lang:Int, emp_id:String) -> [ResignEmpDetailsModul]{
        var returnValueArray = ResignEmpDetailsModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
        
        let soapAction: String = "http://tempuri.org/Get_Emp_Details"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ResignEmpDetailsModul() }, getValue: {elemName, strVal in
            self.getElementValueForGet_Emp_Details(elemName: elemName, strVal: strVal, returnValueArray: returnValueArray)
        }) as? [ResignEmpDetailsModul]{ return returnValue }
        
        return [ResignEmpDetailsModul]()
    }
    
    func Get_Inc_Desc_Details(lang: Int, emp_id: String) -> [Inc_DecrDetailsModul]{
        var returnValueArray = Inc_DecrDetailsModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_Inc_Desc_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "</Get_Inc_Desc_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Get_Inc_Desc_Details"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = Inc_DecrDetailsModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Inc_Decr_Date" { rItem1.Date =  strVal }
            else if elemName == "Old_Basic" { rItem1.Old_Basic =  strVal }
            if elemName == "New_Basic" { rItem1.New_Basic =  strVal }
            else if elemName == "Inc_Decr" { rItem1.Inc_Decr =  strVal }
            return rItem1
            
        }) as? [Inc_DecrDetailsModul]{ return returnValue }
        
        return [Inc_DecrDetailsModul]()
    }
    
    func Get_Eva_Details(lang: Int, emp_id: String) -> [EvaDetailsModul]{
        var returnValueArray = EvaDetailsModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_Eva_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "</Get_Eva_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Get_Eva_Details"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = EvaDetailsModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Eva_Date" { rItem1.Date =  strVal }
            else if elemName == "Eva_Total" { rItem1.Total =  strVal }
            if elemName == "Eva_Result" { rItem1.Result =  strVal }
            else if elemName == "Eva_MGr_Remark" { rItem1.MGr_Remark =  strVal }
            return rItem1
            
        }) as? [EvaDetailsModul]{ return returnValue }
        
        return [EvaDetailsModul]()
    }
    
    func Submit_Resign_Request(resignType_value: String, empId_selectedValue: String, reason: String, workHrs: String, absentDays: String, formId: String, login_empId: String, company: String, comment: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Submit_Resign_Request xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<resignType_value>"
        soapReqXML += resignType_value
        soapReqXML += "</resignType_value>"
        soapReqXML += "<empId_selectedValue>"
        soapReqXML += empId_selectedValue
        soapReqXML += "</empId_selectedValue>"
        soapReqXML += "<reason>"
        soapReqXML += reason
        soapReqXML += "</reason>"
        soapReqXML += "<workHrs>"
        soapReqXML += workHrs
        soapReqXML += "</workHrs>"
        soapReqXML += "<absentDays>"
        soapReqXML += absentDays
        soapReqXML += "</absentDays>"
        soapReqXML += "<formId>"
        soapReqXML += formId
        soapReqXML += "</formId>"
        soapReqXML += "<login_empId>"
        soapReqXML += login_empId
        soapReqXML += "</login_empId>"
        soapReqXML += "<company>"
        soapReqXML += company
        soapReqXML += "</company>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</Submit_Resign_Request>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Submit_Resign_Request"
        
        let responseData:Data = SoapHttpClient.callWS(Host :self.Host ,WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    func Get_Saved_Res_Details(lang:Int, pid:String, formId:String) -> [ResignEmpDetailsModul]{
        var returnValueArray = ResignEmpDetailsModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Get_Saved_Res_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<formId>"
        soapReqXML += formId
        soapReqXML += "</formId>"
        soapReqXML += "</Get_Saved_Res_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Get_Saved_Res_Details"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ResignEmpDetailsModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Err" { rItem1.Error =  strVal }
            else if elemName == "Resign_type" { rItem1.Resign_type =  strVal }
            else if elemName == "Work_Hrs" { rItem1.Work_Hrs =  strVal }
            else if elemName == "Absent_Days" { rItem1.Absent_Days =  strVal }
            return rItem1
            
        }) as? [ResignEmpDetailsModul]{ return returnValue }
        
        return [ResignEmpDetailsModul]()
    }
    
    func BindApproversGrid(emp_id: String, formid: Int, pid: String, lang: Int) -> [WorkFlowModul]{
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
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
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
    
    public func BindCommentGrid(pid: String, fid: Int, gvApp_RowCount: Int) -> [CommentModul]{
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
        
        let soapAction: String = "http://tempuri.org/BindCommentGrid"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CommentModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Cmt_Name" { rItem1.Name =  strVal }
            else if elemName == "Cmt_Comment" { rItem1.Comment =  strVal }
            else if elemName == "Cmt_Id" { rItem1.Id =  strVal }
            return rItem1
            
        }) as? [CommentModul]{ return returnValue }
        
        return [CommentModul]()
    }
    
    public func Approve_EOS(Emp_ID:String, pid:String, buttonType:String, FormId:Int, Comment:String, grid_empid:String, totalgrd_rows:Int, login_empId:String, finalApp_EmpId:String, finalApp_Status:String, gridEmpid_next:String)-> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_EOS xmlns=\"http://tempuri.org/\">"
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
        soapReqXML += "</Approve_EOS>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_EOS"
        
        let responseData:Data = SoapHttpClient.callWS(Host :self.Host ,WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}





















