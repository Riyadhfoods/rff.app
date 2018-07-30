//
//  TrackingService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class TrackingService{
    static let shared = TrackingService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/ios.asmx"
    private var Host: String = "82.118.166.164"
    
    private func ListTypeArrValues(data: Data) -> [ListTypeModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue: [ListTypeModul] = [ListTypeModul]()
        
        if elemName == "" {
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = ListTypeModul()
                let xmlResult_Parent1: XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "listtype" { rItem1.listtype =  strVal }
                        else if elemName == "listname" { rItem1.listname =  strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
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
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue: [ListTypeModul] = ListTypeArrValues(data : responseData)
        return returnValue
    }
    
    private func InboxGridArrValues(data: Data) -> [InboxGridModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer? = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue:[InboxGridModul] = [InboxGridModul]()
        
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = InboxGridModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = ""
                    if elem1?.children.first is TextElement {
                        for elem in (elem1?.children)!{
                            if let elemText: TextElement = elem as? TextElement{
                                strVal += elemText.text
                            }
                        }
                    }
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "pid" { rItem1.pid =  strVal }
                        else if elemName == "empname" { rItem1.empname =  strVal }
                        else if elemName == "empid" { rItem1.empid =  strVal }
                        else if elemName == "date" { rItem1.date =  strVal }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
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
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue: [InboxGridModul] = InboxGridArrValues(data : responseData)
        return returnValue
    }
    
}
