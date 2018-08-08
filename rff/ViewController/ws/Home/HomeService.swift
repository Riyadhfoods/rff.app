//
//  HomeService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class HomeService{
    static let instance = HomeService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/ios.asmx"
    private var Host: String = "82.118.166.164"
    
    private var returnValueForTask_Inbox = Task_InboxModul()
    private func getElementValueForTask_Inbox(elemName: String, strVal: String) -> Task_InboxModul{
        let rItem1 = returnValueForTask_Inbox
        if elemName == "FormId" { rItem1.FormId =  strVal }
        else if elemName == "EnglishDes" { rItem1.EnglishDes =  strVal }
        else if elemName == "ArabicDesc" { rItem1.ArabicDesc =  strVal }
        else if elemName == "PageName" { rItem1.PageName =  strVal }
        else if elemName == "Count" {
            if let strValInt = strVal.toInt(){ rItem1.Count =  strValInt }
        }
        return rItem1
    }
    
    func Task_Inbox(langid:Int, emp_id:String) -> [Task_InboxModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Task_Inbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "</Task_Inbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Task_Inbox"
        
        let responseData: Data = SoapHttpClient.callWS(Host : self.Host ,WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForTask_Inbox = Task_InboxModul() }, getValue: {elementName, value in
                self.getElementValueForTask_Inbox(elemName: elementName, strVal: value)
        }) as? [Task_InboxModul]{ return returnValue }
        
        return [Task_InboxModul]()
    }
}
