//
//  BusinessTripApprovalService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 16/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class BusinessTripApprovalService{
    static let instance = BusinessTripApprovalService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/approvals/BusinessTrip_App.asmx"
    private var Host: String = "82.118.166.164"
    
    func Bind_business_trip_Details(pid: String, lang: Int) -> [BusinessTrip_AppModel]{
        var returnValueArray = BusinessTrip_AppModel()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_business_trip_Details xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</Bind_business_trip_Details>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Bind_business_trip_Details"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = BusinessTrip_AppModel() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "TransMode" { rItem1.TransMode =  strVal }
            else if elemName == "ExitReEnteryVisa" { rItem1.ExitReEnteryVisa =  (strVal.lowercased() == "true") }
            else if elemName == "StartDate" { rItem1.StartDate =  strVal }
            else if elemName == "EndDate" { rItem1.EndDate =  strVal }
            else if elemName == "Dest" { rItem1.Dest =  strVal }
            else if elemName == "TripAmt" { rItem1.TripAmt =  strVal }
            else if elemName == "AmtDesc" { rItem1.AmtDesc =  strVal }
            else if elemName == "Reason" { rItem1.Reason =  strVal }
            else if elemName == "MeetAndAssistance" { rItem1.MeetAndAssistance =  strVal }
            else if elemName == "Luggage" { rItem1.Luggage =  strVal }
            else if elemName == "AirLines" { rItem1.AirLines =  strVal }
            else if elemName == "Membership" { rItem1.Membership =  strVal }
            else if elemName == "Othersvl" { rItem1.Othersvl =  strVal }
            return rItem1
            
        }) as? [BusinessTrip_AppModel]{ return returnValue }
        
        return [BusinessTrip_AppModel]()
    }
    
    func Bind_travel_details_grid(pid: String, lang: Int) -> [BusinessTrip_AppTravelModel]{
        var returnValueArray = BusinessTrip_AppTravelModel()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_travel_details_grid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</Bind_travel_details_grid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Bind_travel_details_grid"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = BusinessTrip_AppTravelModel() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "AirLineGrid" { rItem1.AirLineGrid =  strVal }
            else if elemName == "VisaGrid" { rItem1.VisaGrid =  (strVal.lowercased() == "true") }
            else if elemName == "ToLocGrid" { rItem1.ToLocGrid =  strVal }
            else if elemName == "FromLocGrid" { rItem1.FromLocGrid =  strVal }
            else if elemName == "ToDateGrid" { rItem1.ToDateGrid =  strVal }
            else if elemName == "FromDateGrid" { rItem1.FromDateGrid =  strVal }
            return rItem1
            
        }) as? [BusinessTrip_AppTravelModel]{ return returnValue }
        
        return [BusinessTrip_AppTravelModel]()
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
    
    func BindCommentGrid(pid: String, fid: Int, gvApp_RowCount: Int) -> [CommentModul]{
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
    
    func Approve_BusinessTrip(Emp_ID: String, pid: String, buttonType: String, FormId: Int, Comment: String, grid_empid: String, totalgrd_rows: Int, login_empId: String, finalApp_EmpId: String, finalApp_Status: String, gridEmpid_next: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Approve_BusinessTrip xmlns=\"http://tempuri.org/\">"
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
        soapReqXML += "</Approve_BusinessTrip>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Approve_BusinessTrip"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
















