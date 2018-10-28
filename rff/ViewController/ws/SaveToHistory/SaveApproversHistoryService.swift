//
//  SaveApproversHistoryService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 04/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SaveApproversHistoryService{
    static let instance = SaveApproversHistoryService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentHost)/ios_hrms/saveapphistory.asmx"
    
    func SaveRP2ApproversHistory(pid:String, fid:Int, final_emp_id:String, name:String, emp_role:String, final_status:String, approve_date:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SaveRP2ApproversHistory xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<fid>"
        soapReqXML += String(fid)
        soapReqXML += "</fid>"
        soapReqXML += "<final_emp_id>"
        soapReqXML += final_emp_id
        soapReqXML += "</final_emp_id>"
        soapReqXML += "<name>"
        soapReqXML += name
        soapReqXML += "</name>"
        soapReqXML += "<emp_role>"
        soapReqXML += emp_role
        soapReqXML += "</emp_role>"
        soapReqXML += "<final_status>"
        soapReqXML += final_status
        soapReqXML += "</final_status>"
        soapReqXML += "<approve_date>"
        soapReqXML += approve_date
        soapReqXML += "</approve_date>"
        soapReqXML += "</SaveRP2ApproversHistory>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SaveRP2ApproversHistory"
        
        let responseData:Data = SoapHttpClient.callWS(WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    func SaveApproversHistory(pid:String, fid:Int, emp_id:String, name:String, emp_role:String, status:String, approve_date:String)-> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SaveApproversHistory xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<pid>"
        soapReqXML += pid
        soapReqXML += "</pid>"
        soapReqXML += "<fid>"
        soapReqXML += String(fid)
        soapReqXML += "</fid>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<name>"
        soapReqXML += name
        soapReqXML += "</name>"
        soapReqXML += "<emp_role>"
        soapReqXML += emp_role
        soapReqXML += "</emp_role>"
        soapReqXML += "<status>"
        soapReqXML += status
        soapReqXML += "</status>"
        soapReqXML += "<approve_date>"
        soapReqXML += approve_date
        soapReqXML += "</approve_date>"
        soapReqXML += "</SaveApproversHistory>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SaveApproversHistory"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
