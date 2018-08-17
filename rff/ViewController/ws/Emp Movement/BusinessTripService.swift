//
//  BusinessTripService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class BusinessTripService{
    static let instance = BusinessTripService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/BusinessTrip.asmx"
    private var Host: String = "82.118.166.164"
    
    func BindDdlEmps(emp_id:String, lang:Int)-> [BusinessTripClass]{
        var returnValueArray = BusinessTripClass()
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindDdlEmps xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</BindDdlEmps>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindDdlEmps"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = BusinessTripClass() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "EmpNum" { rItem1.EmpNum =  strVal }
            else if elemName == "EmpName" { rItem1.EmpName =  strVal }
            return rItem1
            
        }) as? [BusinessTripClass]{ return returnValue }
        
        return [BusinessTripClass]()
    }
    
    func BindDdlTrans(lang: Int)-> [BusinessTripClass]{
        var returnValueArray = BusinessTripClass()
        
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindDdlTrans xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</BindDdlTrans>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/BindDdlTrans"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = BusinessTripClass() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "TransDesc" { rItem1.TransDesc =  strVal }
            else if elemName == "TransId" { rItem1.TransId =  strVal }
            return rItem1
            
        }) as? [BusinessTripClass]{ return returnValue }
        
        return [BusinessTripClass]()
    }
    
    func SubmitBusinessTrip(emp_id: String, trns_mode: String, exit_Reentry_Visa: Bool, journey_Start_Date: String, journey_End_Date: String, destination: String, business_Trip_Amount: String, amount_Description: String, reason_for_business_Trip: String, airLines1: String, visa1: Bool, to_Location1: String, from_Location1: String, to_Date1: String, from_Date1: String, airLines2: String, visa2: Bool, to_Location2: String, from_Location2: String, to_Date2: String, from_Date2: String, airLines3: String, visa3: Bool, to_Location3: String, from_Location3: String, to_Date3: String, from_Date3: String, meet_Assistance: String, luggage_Cargo: String, air_Lines: String, membership_Card_No: String, others: String, comment: String, creator_id: String, comp_id: String) -> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SubmitBusinessTrip xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<trns_mode>"
        soapReqXML += trns_mode
        soapReqXML += "</trns_mode>"
        soapReqXML += "<exit_Reentry_Visa>"
        soapReqXML += String(exit_Reentry_Visa)
        soapReqXML += "</exit_Reentry_Visa>"
        soapReqXML += "<journey_Start_Date>"
        soapReqXML += journey_Start_Date
        soapReqXML += "</journey_Start_Date>"
        soapReqXML += "<journey_End_Date>"
        soapReqXML += journey_End_Date
        soapReqXML += "</journey_End_Date>"
        soapReqXML += "<destination>"
        soapReqXML += destination
        soapReqXML += "</destination>"
        soapReqXML += "<business_Trip_Amount>"
        soapReqXML += business_Trip_Amount
        soapReqXML += "</business_Trip_Amount>"
        soapReqXML += "<amount_Description>"
        soapReqXML += amount_Description
        soapReqXML += "</amount_Description>"
        soapReqXML += "<reason_for_business_Trip>"
        soapReqXML += reason_for_business_Trip
        soapReqXML += "</reason_for_business_Trip>"
        soapReqXML += "<airLines1>"
        soapReqXML += airLines1
        soapReqXML += "</airLines1>"
        soapReqXML += "<visa1>"
        soapReqXML += String(visa1)
        soapReqXML += "</visa1>"
        soapReqXML += "<to_Location1>"
        soapReqXML += to_Location1
        soapReqXML += "</to_Location1>"
        soapReqXML += "<from_Location1>"
        soapReqXML += from_Location1
        soapReqXML += "</from_Location1>"
        soapReqXML += "<to_Date1>"
        soapReqXML += to_Date1
        soapReqXML += "</to_Date1>"
        soapReqXML += "<from_Date1>"
        soapReqXML += from_Date1
        soapReqXML += "</from_Date1>"
        soapReqXML += "<airLines2>"
        soapReqXML += airLines2
        soapReqXML += "</airLines2>"
        soapReqXML += "<visa2>"
        soapReqXML += String(visa2)
        soapReqXML += "</visa2>"
        soapReqXML += "<to_Location2>"
        soapReqXML += to_Location2
        soapReqXML += "</to_Location2>"
        soapReqXML += "<from_Location2>"
        soapReqXML += from_Location2
        soapReqXML += "</from_Location2>"
        soapReqXML += "<to_Date2>"
        soapReqXML += to_Date2
        soapReqXML += "</to_Date2>"
        soapReqXML += "<from_Date2>"
        soapReqXML += from_Date2
        soapReqXML += "</from_Date2>"
        soapReqXML += "<airLines3>"
        soapReqXML += airLines3
        soapReqXML += "</airLines3>"
        soapReqXML += "<visa3>"
        soapReqXML += String(visa3)
        soapReqXML += "</visa3>"
        soapReqXML += "<to_Location3>"
        soapReqXML += to_Location3
        soapReqXML += "</to_Location3>"
        soapReqXML += "<from_Location3>"
        soapReqXML += from_Location3
        soapReqXML += "</from_Location3>"
        soapReqXML += "<to_Date3>"
        soapReqXML += to_Date3
        soapReqXML += "</to_Date3>"
        soapReqXML += "<from_Date3>"
        soapReqXML += from_Date3
        soapReqXML += "</from_Date3>"
        soapReqXML += "<meet_Assistance>"
        soapReqXML += meet_Assistance
        soapReqXML += "</meet_Assistance>"
        soapReqXML += "<luggage_Cargo>"
        soapReqXML += luggage_Cargo
        soapReqXML += "</luggage_Cargo>"
        soapReqXML += "<air_Lines>"
        soapReqXML += air_Lines
        soapReqXML += "</air_Lines>"
        soapReqXML += "<membership_Card_No>"
        soapReqXML += membership_Card_No
        soapReqXML += "</membership_Card_No>"
        soapReqXML += "<others>"
        soapReqXML += others
        soapReqXML += "</others>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<creator_id>"
        soapReqXML += creator_id
        soapReqXML += "</creator_id>"
        soapReqXML += "<comp_id>"
        soapReqXML += comp_id
        soapReqXML += "</comp_id>"
        soapReqXML += "</SubmitBusinessTrip>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SubmitBusinessTrip"
        
        let responseData:Data = SoapHttpClient.callWS(Host :self.Host ,WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
}
