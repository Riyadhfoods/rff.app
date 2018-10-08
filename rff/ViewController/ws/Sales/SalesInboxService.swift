//
//  SalesService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 01/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesInboxService{
    static let instance = SalesInboxService()
    let commonSalesService = SalesCommonService.instance
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/sales.asmx"
    private var Host: String = "82.118.166.164"
    
    private var returnValueForSalesInbox = SalesInboxModul()
    private func getElementValueForSalesInbox(elementName: String, value: String) -> SalesInboxModul{
        if elementName == "totalrows" {
            if let valueInt = value.toInt(){ returnValueForSalesInbox.totalrows =  valueInt }
        }
        else if elementName == "currentrows" { returnValueForSalesInbox.currentrows =  value }
        else if elementName == "Flag" { returnValueForSalesInbox.Flag =  value.lowercased() == "true" }
        else if elementName == "ID" { returnValueForSalesInbox.ID =  value }
        else if elementName == "EmpCreated" { returnValueForSalesInbox.EmpCreated = value }
        else if elementName == "CustomerName" { returnValueForSalesInbox.CustomerName =  value }
        else if elementName == "Date" { returnValueForSalesInbox.Date =  value }
        else if elementName == "RequestDate" { returnValueForSalesInbox.RequestDate = value }
        else if elementName == "ReturnDate" { returnValueForSalesInbox.ReturnDate =  value }
        else if elementName == "Items" { returnValueForSalesInbox.Items =  value }
        else if elementName == "Status" { returnValueForSalesInbox.Status = value }
        else if elementName == "PendingBy" { returnValueForSalesInbox.PendingBy =  value }
        else if elementName == "Comment" { returnValueForSalesInbox.Comment =  value }
        return returnValueForSalesInbox
    }
    
    func GetSalesInbox(id: Int, emp_id: String, searchtext: String, index:Int)-> [SalesInboxModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetSalesInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<id>"
        soapReqXML += String(id)
        soapReqXML += "</id>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<searchtext>"
        soapReqXML += searchtext
        soapReqXML += "</searchtext>"
        soapReqXML += "<index>"
        soapReqXML += String(index)
        soapReqXML += "</index>"
        soapReqXML += "</GetSalesInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"

        let soapAction: String = "http://tempuri.org/GetSalesInbox"

        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForSalesInbox = SalesInboxModul() }, getValue: {elementName, value in
            self.getElementValueForSalesInbox(elementName: elementName, value: value)
        }) as? [SalesInboxModul]{ return returnValue }
        
        return [SalesInboxModul]()
    }
    
    private var returnValueForBindItemGrid = SalesItemInboxModul()
    private func getElementValueForBindItemGrid(elementName: String, value: String) -> SalesItemInboxModul{
        if elementName == "SRA_SerialNumber" { returnValueForBindItemGrid.Return_SerialNumber =  value }
        else if elementName == "SRA_InvoiceNumber" { returnValueForBindItemGrid.Return_InvoiceNumber =  value }
        else if elementName == "SRA_CustomerName" { returnValueForBindItemGrid.Return_CustomerName =  value }
        else if elementName == "SRA_SLSPersonName" { returnValueForBindItemGrid.Return_SLSPersonName = value }
        else if elementName == "SRA_ReqDate" { returnValueForBindItemGrid.Return_ReqDate =  value }
        else if elementName == "SRA_ReturnDate" { returnValueForBindItemGrid.Return_ReturnDate = value }
        else if elementName == "SRA_CustomerName" { returnValueForBindItemGrid.Return_Comment =  value }
        else if elementName == "SRA_LotNumber" { returnValueForBindItemGrid.Return_LotNumber =  value }
        else if elementName == "SRA_ItemNumber" { returnValueForBindItemGrid.Return_ItemNumber = value }
        else if elementName == "SRA_ItemDesc" { returnValueForBindItemGrid.Return_ItemDesc =  value }
        else if elementName == "SRA_Unitprice" { returnValueForBindItemGrid.Return_Unitprice =  value }
        else if elementName == "SRA_ExtPrice" { returnValueForBindItemGrid.Return_ExtPrice = value }
        else if elementName == "SRA_Qty" { returnValueForBindItemGrid.Return_Qty =  value }
        else if elementName == "SRA_UOFM" { returnValueForBindItemGrid.Return_UOFM =  value }
        else if elementName == "SRA_InvoiceDate" { returnValueForBindItemGrid.Return_InvoiceDate =  value }
        else if elementName == "SRA_ReturnType" { returnValueForBindItemGrid.Return_ReturnType =  value }
            
        else if elementName == "SOI_ORDERID" { returnValueForBindItemGrid.Order_ORDERID =  value }
        else if elementName == "SOI_EMPCREATED" { returnValueForBindItemGrid.Order_EMPCREATED = value }
        else if elementName == "SOI_SLSPERSONID" { returnValueForBindItemGrid.Order_SLSPERSONID =  value }
        else if elementName == "SOI_CUSTNAME" { returnValueForBindItemGrid.Order_CUSTNAME =  value }
        else if elementName == "SOI_SERIALNUMBER" { returnValueForBindItemGrid.Order_SERIALNUMBER = value }
        else if elementName == "SOI_ITEMID" { returnValueForBindItemGrid.Order_ITEMID =  value }
        else if elementName == "SOI_ITEMDESC" { returnValueForBindItemGrid.Order_ITEMDESC =  value }
        else if elementName == "SOI_UNITCOST" { returnValueForBindItemGrid.Order_UNITCOST =  value }
        else if elementName == "SOI_EXTCOST" { returnValueForBindItemGrid.Order_EXTCOST =  value }
        else if elementName == "SOI_QTY" { returnValueForBindItemGrid.Order_QTY =  value }
        else if elementName == "SOI_UOFM" { returnValueForBindItemGrid.Order_UOFM = value }
        else if elementName == "SOI_LASTYEAR" { returnValueForBindItemGrid.Order_LASTYEAR =  value }
        else if elementName == "SOI_YEARTODATE" { returnValueForBindItemGrid.Order_YEARTODATE =  value }
        else if elementName == "SOI_REQDATE" { returnValueForBindItemGrid.Order_REQDATE = value }
        else if elementName == "SOI_DELIVERYDATE" { returnValueForBindItemGrid.Order_DELIVERYDATE =  value }
        else if elementName == "SOI_COMMENT" { returnValueForBindItemGrid.Order_COMMENT =  value }
        return returnValueForBindItemGrid
    }
    
    func SRI_BindItemGrid(returnid: String, querytype: String) -> [SalesItemInboxModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRI_BindItemGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<querytype>"
        soapReqXML += querytype
        soapReqXML += "</querytype>"
        soapReqXML += "</SRI_BindItemGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRI_BindItemGrid"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindItemGrid = SalesItemInboxModul() }, getValue: {elementName, value in
            self.getElementValueForBindItemGrid(elementName: elementName, value: value)
        }) as? [SalesItemInboxModul]{ return returnValue }
        
        return [SalesItemInboxModul]()
    }
    
    private var returnValueForBindCustomerCreditLimit = SalesCreditLimmitInboxModul()
    private func getElementValueForBindCustomerCreditLimit(elementName: String, value: String) -> SalesCreditLimmitInboxModul{
        if elementName == "SRI_CustomerID" { returnValueForBindCustomerCreditLimit.CustomerID =  value }
        else if elementName == "SRI_CustomerName" { returnValueForBindCustomerCreditLimit.CustomerName =  value }
        else if elementName == "SRI_CreditLimit" { returnValueForBindCustomerCreditLimit.CreditLimit =  value }
        else if elementName == "SRI_TotalDue" { returnValueForBindCustomerCreditLimit.TotalDue = value }
        else if elementName == "SRI_Status" { returnValueForBindCustomerCreditLimit.Status =  value }
        return returnValueForBindCustomerCreditLimit
    }
    
    public func SRI_BindCustomerCreditLimit(returnid: String, company: String) -> [SalesCreditLimmitInboxModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRI_BindCustomerCreditLimit xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<company>"
        soapReqXML += company
        soapReqXML += "</company>"
        soapReqXML += "</SRI_BindCustomerCreditLimit>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRI_BindCustomerCreditLimit"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindCustomerCreditLimit = SalesCreditLimmitInboxModul() }, getValue: {elementName, value in
            self.getElementValueForBindCustomerCreditLimit(elementName: elementName, value: value)
        }) as? [SalesCreditLimmitInboxModul]{ return returnValue }
        
        return [SalesCreditLimmitInboxModul]()
    }
}




















