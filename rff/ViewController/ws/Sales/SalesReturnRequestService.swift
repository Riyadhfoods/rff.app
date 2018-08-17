//
//  SalesReturnRequestService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 08/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesReturnRequestService{
    static let instance = SalesReturnRequestService()
    let commonSalesService = SalesCommonService.instance
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/sales.asmx"
    private var Host: String = "82.118.166.164"
    
    func BindSalesReturnSalesPerson() -> [SalesPersonModul]{
        var returnValueArray = SalesPersonModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesReturnSalesPerson xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesReturnSalesPerson>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindSalesReturnSalesPerson"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = SalesPersonModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "SalesPersonId" { rItem1.SalesPersonId =  strVal }
            else if elemName == "SalesPerson" { rItem1.SalesPerson =  strVal }
            return rItem1
            
        }) as? [SalesPersonModul]{ return returnValue }
        
        return [SalesPersonModul]()
    }
    
    func BindSalesReturnCustomers(salesperson:String)-> [CustomerModul]{
        var returnValueArray = CustomerModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesReturnCustomers xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salespersonid>"
        soapReqXML += salesperson
        soapReqXML += "</salespersonid>"
        soapReqXML += "</BindSalesReturnCustomers>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesReturnCustomers"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CustomerModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "CustomerId" { rItem1.CustomerId =  strVal }
            else if elemName == "CustomerName" { rItem1.CustomerName =  strVal }
            return rItem1
            
        }) as? [CustomerModul]{ return returnValue }
        
        return [CustomerModul]()
    }
    
    private func getElementValueForSRR_BindCustomerAging(elemName: String, strVal: String, returnValueArray: CreditLimitModul) -> CreditLimitModul{
        let rItem1 = returnValueArray
        if elemName == "CreditLimit" { rItem1.CreditLimit =  strVal }
        else if elemName == "TotalDue" { rItem1.ToTalDue =  strVal }
        else if elemName == "ZeroTo31Days" { rItem1.ZEROTO31days =  strVal }
        else if elemName == "ThirtyOneto60Days" { rItem1.ThirtyOneTo60Days =  strVal }
        else if elemName == "SixtyOneTo90Days" { rItem1.SIXTYOneTo90Days =  strVal }
        else if elemName == "Nineoneto120Days" { rItem1.NINETYOneTo120Days =  strVal }
        else if elemName == "Above120Days" { rItem1.Above120DAYS =  strVal }
        else if elemName == "Status" { rItem1.CustomerAgying_Status =  strVal }
        return rItem1
    }
    
    func SRR_BindCustomerAging(customer_no: String) -> [CreditLimitModul]{
        var returnValueArray = CreditLimitModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BindCustomerAging xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customer_no>"
        soapReqXML += customer_no
        soapReqXML += "</customer_no>"
        soapReqXML += "</SRR_BindCustomerAging>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SRR_BindCustomerAging"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CreditLimitModul() }, getValue: {elemName, strVal in
            self.getElementValueForSRR_BindCustomerAging(elemName: elemName, strVal: strVal, returnValueArray: returnValueArray)
        }) as? [CreditLimitModul]{ return returnValue }
        
        return [CreditLimitModul]()
    }
    
    func SRR_BindInvoice(salesperson_id:String, customernumber:String, invoice_date:String)-> [InvoiceAndItemModul]{
        var returnValueArray = InvoiceAndItemModul()
        
        var soapReqXML :String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BindInvoice xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salesperson_id>"
        soapReqXML += salesperson_id
        soapReqXML += "</salesperson_id>"
        soapReqXML += "<customernumber>"
        soapReqXML += customernumber
        soapReqXML += "</customernumber>"
        soapReqXML += "<invoice_date>"
        soapReqXML += invoice_date
        soapReqXML += "</invoice_date>"
        soapReqXML += "</SRR_BindInvoice>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SRR_BindInvoice"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = InvoiceAndItemModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Sop_Number" { rItem1.Sop_Number =  strVal }
            return rItem1
            
        }) as? [InvoiceAndItemModul]{ return returnValue }
        
        return [InvoiceAndItemModul]()
    }
    
    func SRR_BindItemsonChangeofInvoice(invoicenumber:String)-> [InvoiceAndItemModul]{
        var returnValueArray = InvoiceAndItemModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BindItemsonChangeofInvoice xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<invoicenumber>"
        soapReqXML += invoicenumber
        soapReqXML += "</invoicenumber>"
        soapReqXML += "</SRR_BindItemsonChangeofInvoice>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction :String = "http://tempuri.org/SRR_BindItemsonChangeofInvoice"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = InvoiceAndItemModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Items" { rItem1.Items =  strVal }
            return rItem1
            
        }) as? [InvoiceAndItemModul]{ return returnValue }
        
        return [InvoiceAndItemModul]()
    }
    
    private func getElementValueForSRR_AddItem(elemName: String, strVal: String, returnValueArray: ReturnItemSendModel) -> ReturnItemSendModel{
        let rItem1 = returnValueArray
        if elemName == "SRR_ITEMGRID_COLUMN1" { rItem1.SRR_ITEMGRID_COLUMN1 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN2" { rItem1.SRR_ITEMGRID_COLUMN2 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN3" { rItem1.SRR_ITEMGRID_COLUMN3 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN4" { rItem1.SRR_ITEMGRID_COLUMN4 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN5" { rItem1.SRR_ITEMGRID_COLUMN5 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN6" { rItem1.SRR_ITEMGRID_COLUMN6 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN7" { rItem1.SRR_ITEMGRID_COLUMN7 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN8" { rItem1.SRR_ITEMGRID_COLUMN8 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN9" { rItem1.SRR_ITEMGRID_COLUMN9 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN10" { rItem1.SRR_ITEMGRID_COLUMN10 =  strVal }
        else if elemName == "SRR_ITEMGRID_COLUMN11" { rItem1.SRR_ITEMGRID_COLUMN11 =  strVal }
        return rItem1
    }
    
    func SRR_AddItem(rownumber: Int, returnid: String, empno: String, qty: String, invoicenumber: String, item:String, table:String) -> [ReturnItemSendModel]{
        var returnValueArray = ReturnItemSendModel()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_AddItem xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<rownumber>"
        soapReqXML += String(rownumber)
        soapReqXML += "</rownumber>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<qty>"
        soapReqXML += qty
        soapReqXML += "</qty>"
        soapReqXML += "<invoicenumber>"
        soapReqXML += invoicenumber
        soapReqXML += "</invoicenumber>"
        soapReqXML += "<item>"
        soapReqXML += item
        soapReqXML += "</item>"
        soapReqXML += "<table>"
        soapReqXML += table
        soapReqXML += "</table>"
        soapReqXML += "</SRR_AddItem>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SRR_AddItem"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ReturnItemSendModel() }, getValue: {elemName, strVal in
            self.getElementValueForSRR_AddItem(elemName: elemName, strVal: strVal, returnValueArray: returnValueArray)
        }) as? [ReturnItemSendModel]{ return returnValue }
        
        return [ReturnItemSendModel]()
    }
    
    func SRR_BEFORESEND_SRR(itemid: String, invoicenumber: String, quantity: String, returnid: String, rownumber: Int, Item_Desc: String, unitofmeasure: String, totalcost: String, unitprice: String, lotnumber:String, invoicedate: String, returntype_grid: String) -> [String?]{
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_BEFORESEND_SRR xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<itemid>"
        soapReqXML += itemid
        soapReqXML += "</itemid>"
        soapReqXML += "<invoicenumber>"
        soapReqXML += invoicenumber
        soapReqXML += "</invoicenumber>"
        soapReqXML += "<quantity>"
        soapReqXML += quantity
        soapReqXML += "</quantity>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<rownumber>"
        soapReqXML += String(rownumber)
        soapReqXML += "</rownumber>"
        soapReqXML += "<Item_Desc>"
        soapReqXML += Item_Desc
        soapReqXML += "</Item_Desc>"
        soapReqXML += "<unitofmeasure>"
        soapReqXML += unitofmeasure
        soapReqXML += "</unitofmeasure>"
        soapReqXML += "<totalcost>"
        soapReqXML += totalcost
        soapReqXML += "</totalcost>"
        soapReqXML += "<unitprice>"
        soapReqXML += unitprice
        soapReqXML += "</unitprice>"
        soapReqXML += "<lotnumber>"
        soapReqXML += lotnumber
        soapReqXML += "</lotnumber>"
        soapReqXML += "<invoicedate>"
        soapReqXML += invoicedate
        soapReqXML += "</invoicedate>"
        soapReqXML += "<returntype_grid>"
        soapReqXML += returntype_grid
        soapReqXML += "</returntype_grid>"
        soapReqXML += "</SRR_BEFORESEND_SRR>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SRR_BEFORESEND_SRR"
        
        let responseData:Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        let strVals: [String?] = commonFunction.stringArrFromXML(data : responseData)
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
    
    func SRR_SEND_SRR(supermarket: Bool, itemtable: Bool, returnid: String, customervalue: String, customertext: String, salespersonvalue: String, salespersontext: String, returndate: String, emp_no: String, comment: String, branchtext: String, companyid: String, branchvalue: String, storevalue: String, cityvalue: String, storesalespersonvalue: String, merchandiser: String, rtvNo:String) -> [String?]{
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRR_SEND_SRR xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<supermarket>"
        soapReqXML += String(supermarket)
        soapReqXML += "</supermarket>"
        soapReqXML += "<itemtable>"
        soapReqXML += String(itemtable)
        soapReqXML += "</itemtable>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<customervalue>"
        soapReqXML += customervalue
        soapReqXML += "</customervalue>"
        soapReqXML += "<customertext>"
        soapReqXML += customertext
        soapReqXML += "</customertext>"
        soapReqXML += "<salespersonvalue>"
        soapReqXML += salespersonvalue
        soapReqXML += "</salespersonvalue>"
        soapReqXML += "<salespersontext>"
        soapReqXML += salespersontext
        soapReqXML += "</salespersontext>"
        soapReqXML += "<returndate>"
        soapReqXML += returndate
        soapReqXML += "</returndate>"
        soapReqXML += "<emp_no>"
        soapReqXML += emp_no
        soapReqXML += "</emp_no>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<branchtext>"
        soapReqXML += branchtext
        soapReqXML += "</branchtext>"
        soapReqXML += "<companyid>"
        soapReqXML += companyid
        soapReqXML += "</companyid>"
        soapReqXML += "<branchvalue>"
        soapReqXML += branchvalue
        soapReqXML += "</branchvalue>"
        soapReqXML += "<storevalue>"
        soapReqXML += storevalue
        soapReqXML += "</storevalue>"
        soapReqXML += "<cityvalue>"
        soapReqXML += cityvalue
        soapReqXML += "</cityvalue>"
        soapReqXML += "<storesalespersonvalue>"
        soapReqXML += storesalespersonvalue
        soapReqXML += "</storesalespersonvalue>"
        soapReqXML += "<merchandiser>"
        soapReqXML += merchandiser
        soapReqXML += "</merchandiser>"
        soapReqXML += "<rtvNo>"
        soapReqXML += rtvNo
        soapReqXML += "</rtvNo>"
        soapReqXML += "</SRR_SEND_SRR>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SRR_SEND_SRR"
        
        let responseData:Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        let strVals: [String?] = commonFunction.stringArrFromXML(data : responseData)
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
}














