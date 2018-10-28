//
//  TrackingService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class TrackingService{
    static let instance = TrackingService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentHost)/ios_hrms/ios.asmx"
    
    private var returnValueForddlReqType = ListTypeModul()
    private func getElementValueForddlReqType(elemName: String, strVal: String) -> ListTypeModul{
        let rItem1 = returnValueForddlReqType
        if elemName == "listtype" { rItem1.listtype =  strVal }
        else if elemName == "listname" { rItem1.listname =  strVal }
        return rItem1
    }
    
    func Bind_ddlReqType(langid:Int)-> [ListTypeModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_ddlReqType xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</Bind_ddlReqType>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Bind_ddlReqType"
        
        let responseData:Data = SoapHttpClient.callWS(WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForddlReqType = ListTypeModul() }, getValue: {elementName, value in
            self.getElementValueForddlReqType(elemName: elementName, strVal: value)
        }) as? [ListTypeModul]{ return returnValue }
        
        return [ListTypeModul]()
    }
    
    private var returnValueForSearchInbox = InboxGridModul()
    private func getElementValueForSearchInbox(elemName: String, strVal: String) -> InboxGridModul{
        let rItem1 = returnValueForSearchInbox
        if elemName == "pid" { rItem1.pid =  strVal }
        else if elemName == "empname" { rItem1.empname =  strVal }
        else if elemName == "empid" { rItem1.empid =  strVal }
        else if elemName == "date" { rItem1.date =  strVal }
        return rItem1
    }
    
    func SearchInbox(empid:Int, formid:String, drpdwnvalue:String, search:String, langid:Int)-> [InboxGridModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SearchInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empid>"
        soapReqXML += String(empid)
        soapReqXML += "</empid>"
        soapReqXML += "<formid>"
        soapReqXML += formid
        soapReqXML += "</formid>"
        soapReqXML += "<drpdwnvalue>"
        soapReqXML += drpdwnvalue
        soapReqXML += "</drpdwnvalue>"
        soapReqXML += "<search>"
        soapReqXML += search
        soapReqXML += "</search>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</SearchInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SearchInbox"
        
        let responseData:Data = SoapHttpClient.callWS(WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForSearchInbox = InboxGridModul() }, getValue: {elementName, value in
            self.getElementValueForSearchInbox(elemName: elementName, strVal: value)
        }) as? [InboxGridModul]{ return returnValue }
        
        return [InboxGridModul]()
    }
    
}
