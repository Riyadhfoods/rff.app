//
//  SalesCollectionService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

// TerritoryModul, CollCustomerModul, CollectionTypeModul, BankTypeModul, CollSalesPersonModul

class SalesCollectionService{
    static let instance = SalesCollectionService()
    let commonSalesService = SalesCommonService.instance
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentIP)/\(current_host)/sales.asmx"
    
    func GetCollectionType_SC(lang: String)-> [CollectionTypeModul]{
        var returnValueArray = CollectionTypeModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetCollectionType_SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<lang>"
        soapReqXML += lang
        soapReqXML += "</lang>"
        soapReqXML += "</GetCollectionType_SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/GetCollectionType_SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CollectionTypeModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Desc" { rItem1.Desc =  strVal }
            else if elemName == "Id" { rItem1.Id =  strVal }
            return rItem1
            
        }) as? [CollectionTypeModul]{ return returnValue }
        
        return [CollectionTypeModul]()
    }
    
    func GetSlsPerson_SC()-> [CollSalesPersonModul]{
        var returnValueArray = CollSalesPersonModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetSlsPerson_SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</GetSlsPerson_SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/GetSlsPerson_SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CollSalesPersonModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "SLPRSNID" { rItem1.SalesPersonId =  strVal }
            else if elemName == "SalespersonId" { rItem1.SalespersonName =  strVal }
            return rItem1
            
        }) as? [CollSalesPersonModul]{ return returnValue }
        
        return [CollSalesPersonModul]()
    }
    
    func GetCustomer_SC(SalesPerson_id: String)-> [CollCustomerModul]{
        var returnValueArray = CollCustomerModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetCustomer_SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<SalesPerson_id>"
        soapReqXML += SalesPerson_id
        soapReqXML += "</SalesPerson_id>"
        soapReqXML += "</GetCustomer_SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/GetCustomer_SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CollCustomerModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "CustNumber" { rItem1.CustomerId =  strVal }
            else if elemName == "Customer" { rItem1.CustomerName =  strVal }
            return rItem1
            
        }) as? [CollCustomerModul]{ return returnValue }
        
        return [CollCustomerModul]()
    }
    
    func GetTerritory_SC(salesperson_id:String)-> [TerritoryModul]{
        var returnValueArray = TerritoryModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetTerritory_SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salesperson_id>"
        soapReqXML += salesperson_id
        soapReqXML += "</salesperson_id>"
        soapReqXML += "</GetTerritory_SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/GetTerritory_SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = TerritoryModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "salesterr" { rItem1.territoryId =  strVal }
            else if elemName == "sales_dsc" { rItem1.territoryName =  strVal }
            return rItem1
            
        }) as? [TerritoryModul]{ return returnValue }
        
        return [TerritoryModul]()
    }
    
    func GetBank_SC(login_empid:String, lang:String)-> [BankTypeModul]{
        var returnValueArray = BankTypeModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetBank_SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<login_empid>"
        soapReqXML += login_empid
        soapReqXML += "</login_empid>"
        soapReqXML += "<lang>"
        soapReqXML += lang
        soapReqXML += "</lang>"
        soapReqXML += "</GetBank_SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetBank_SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = BankTypeModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Id" { rItem1.Id =  strVal }
            else if elemName == "Name" { rItem1.Name =  strVal }
            return rItem1
            
        }) as? [BankTypeModul]{ return returnValue }
        
        return [BankTypeModul]()
    }
    
    func SaveData__SC(emp_id: String, coll_type: Int, SalesPerson: String, customer: String,
                      InvoiceDate: String, InvoiceNo: String, Territory: String, amount: Double,
                      CheckBookNo: String, comment: String, bank: Int, CheckDueDate: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SaveData__SC xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<coll_type>"
        soapReqXML += "\(coll_type)"
        soapReqXML += "</coll_type>"
        soapReqXML += "<SalesPerson>"
        soapReqXML += SalesPerson
        soapReqXML += "</SalesPerson>"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "<InvoiceDate>"
        soapReqXML += InvoiceDate
        soapReqXML += "</InvoiceDate>"
        soapReqXML += "<InvoiceNo>"
        soapReqXML += InvoiceNo
        soapReqXML += "</InvoiceNo>"
        soapReqXML += "<Territory>"
        soapReqXML += Territory
        soapReqXML += "</Territory>"
        soapReqXML += "<amount>"
        soapReqXML += "\(amount)"
        soapReqXML += "</amount>"
        soapReqXML += "<CheckBookNo>"
        soapReqXML += CheckBookNo
        soapReqXML += "</CheckBookNo>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<bank>"
        soapReqXML += "\(bank)"
        soapReqXML += "</bank>"
        soapReqXML += "<CheckDueDate>"
        soapReqXML += CheckDueDate
        soapReqXML += "</CheckDueDate>"
        soapReqXML += "</SaveData__SC>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SaveData__SC"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
