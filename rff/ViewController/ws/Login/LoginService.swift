//
//  LoginService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class LoginService{
    static let instance = LoginService()
    
    private var Url:String = "http://\(currentHost)/ios_hrms/ios.asmx"
    
    func CheckLogin(username:String, password:String, error:String, langid:Int)-> [String?]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckLogin xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<username>"
        soapReqXML += username
        soapReqXML += "</username>"
        soapReqXML += "<password>"
        soapReqXML += password
        soapReqXML += "</password>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</CheckLogin>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CheckLogin"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVals: [String?] = CommonFunction.shared.stringArrFromXML(data: responseData)
       
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
    
    func ChangePassword(emp_id: String, oldpassword: String, newpassword: String, error: String) -> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<ChangePassword xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<oldpassword>"
        soapReqXML += oldpassword
        soapReqXML += "</oldpassword>"
        soapReqXML += "<newpassword>"
        soapReqXML += newpassword
        soapReqXML += "</newpassword>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</ChangePassword>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/ChangePassword"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal: String? = CommonFunction.shared.stringFromXML(data: responseData)
        
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
