//
//  LoanService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 31/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class LoanService{
    static let instance = LoanService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/loan.asmx"
    private var Host: String = "82.118.166.164"
    
    private var returnValueForBindEmployees = EmpInfoModul_2()
    private func getElementValueForBindEmployees(elemName: String, strVal: String) -> EmpInfoModul_2{
        let rItem1 = returnValueForBindEmployees
        if elemName == "Emp_ID" { rItem1.Emp_ID = strVal }
        else if elemName == "Emp_Name" { rItem1.Emp_Name = strVal }
        return rItem1
    }
    
    func BindEmployees(emp_number: String, lang: Int)-> [EmpInfoModul_2]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindEmployees xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "<lang>"
        soapReqXML += String(lang)
        soapReqXML += "</lang>"
        soapReqXML += "</BindEmployees>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindEmployees"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host ,WebServiceUrl :self.Url, SoapAction: soapAction, SoapMessage :soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindEmployees = EmpInfoModul_2() }, getValue: {elementName, value in
            self.getElementValueForBindEmployees(elemName: elementName, strVal: value)
        }) as? [EmpInfoModul_2]{ return returnValue }
        
        return [EmpInfoModul_2]()
    }
    
    private var returnValueForSubmitEmpLoan = SubmitModul()
    private func getElementValueForSubmitEmpLoan(elemName: String, strVal: String) -> SubmitModul{
        let rItem1 = returnValueForSubmitEmpLoan
        if elemName == "error" { rItem1.error = strVal }
        return rItem1
    }
    
    public func SubmitEmpLoan(login_emp_number:String, guarantor:String, loan_empnumber:String, loantype:String, paymentperiod:String, Amt_Required:String, comment:String)-> [SubmitModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SubmitEmpLoan xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<login_emp_number>"
        soapReqXML += login_emp_number
        soapReqXML += "</login_emp_number>"
        soapReqXML += "<guarantor>"
        soapReqXML += guarantor
        soapReqXML += "</guarantor>"
        soapReqXML += "<loan_empnumber>"
        soapReqXML += loan_empnumber
        soapReqXML += "</loan_empnumber>"
        soapReqXML += "<loantype>"
        soapReqXML += loantype
        soapReqXML += "</loantype>"
        soapReqXML += "<paymentperiod>"
        soapReqXML += paymentperiod
        soapReqXML += "</paymentperiod>"
        soapReqXML += "<Amt_Required>"
        soapReqXML += Amt_Required
        soapReqXML += "</Amt_Required>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</SubmitEmpLoan>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SubmitEmpLoan"
        
        let responseData: Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForSubmitEmpLoan = SubmitModul() }, getValue: {elementName, value in
            self.getElementValueForSubmitEmpLoan(elemName: elementName, strVal: value)
        }) as? [SubmitModul]{ return returnValue }
        
        return [SubmitModul]()
    }
}
