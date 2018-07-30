//
//  HomeService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class HomeService{
    static let shared = HomeService()
    let commonFunction = CommonFunction.shared
    
    private var Url:String = "http://82.118.166.164/ios_hrms/ios.asmx"
    private var Host:String = "82.118.166.164"
    
    private func Task_InboxArrValues(data: Data) -> [Task_InboxModul] {
        let xmlToParse = String.init(data: data, encoding: String.Encoding.utf8)!
        let xmlResult0: XMLIndexer?  = commonFunction.getResult0(xmlToParse: xmlToParse)
        var strVal = ""
        var elemName = ""
        var returnValue:[Task_InboxModul] = [Task_InboxModul]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = Task_InboxModul()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = commonFunction.getStrValue(elem1: elem1)
                    if let element = elem1{
                        elemName = element.name
                        if elemName == "FormId" { rItem1.FormId =  strVal }
                        else if elemName == "EnglishDes" { rItem1.EnglishDes =  strVal }
                        else if elemName == "ArabicDesc" { rItem1.ArabicDesc =  strVal }
                        else if elemName == "PageName" { rItem1.PageName =  strVal }
                        else if elemName == "Count" { rItem1.Count = strVal.toInt()! }
                    }
                }
                returnValue.append(rItem1)
            }
        }
        return returnValue
    }
    
    func Task_Inbox(langid:Int, emp_id:String) -> [Task_InboxModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
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
        
        let returnValue: [Task_InboxModul] = Task_InboxArrValues(data : responseData)
        return returnValue
    }
}
