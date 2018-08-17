//
//  SalesOrderRequestService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 08/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesOrderRequestService{
    static let instance = SalesOrderRequestService()
    let commonSalesService = SalesCommonService.instance
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/sales.asmx"
    private var Host: String = "82.118.166.164"
    
    func BindSalesOrderLocCode() -> [LocCodeModul]{
        var returnValueArray = LocCodeModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderLocCode xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderLocCode>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesOrderLocCode"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = LocCodeModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "LocationCode" { rItem1.LocationCode =  strVal }
            return rItem1
            
        }) as? [LocCodeModul]{ return returnValue }
        
        return [LocCodeModul]()
    }
    
    func BindSalesOrderSalesPerson()-> [SalesPersonModul]{
        var returnValueArray = SalesPersonModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderSalesPerson xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderSalesPerson>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesOrderSalesPerson"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = SalesPersonModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "SalesPersonId" { rItem1.SalesPersonId =  strVal }
            else if elemName == "SalesPerson" { rItem1.SalesPerson =  strVal }
            return rItem1
            
        }) as? [SalesPersonModul]{ return returnValue }
        
        return [SalesPersonModul]()
    }
    
    func BindSalesOrderCustomers(salesperson: String) -> [CustomerModul]{
        var returnValueArray = CustomerModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderCustomers xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<salesperson>"
        soapReqXML += salesperson
        soapReqXML += "</salesperson>"
        soapReqXML += "</BindSalesOrderCustomers>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction :String = "http://tempuri.org/BindSalesOrderCustomers"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CustomerModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "CustomerId" { rItem1.CustomerId =  strVal }
            else if elemName == "CustomerName" { rItem1.CustomerName =  strVal }
            return rItem1
            
        }) as? [CustomerModul]{ return returnValue }
        
        return [CustomerModul]()
    }
    
    private func getElementValueForBindCustomerAgingGV(elemName: String, strVal: String, returnValueArray: CreditLimitModul) -> CreditLimitModul{
        let rItem1 = returnValueArray
        if elemName == "CreditLimit" { rItem1.CreditLimit =  strVal }
        else if elemName == "ToTalDue" { rItem1.ToTalDue =  strVal }
        else if elemName == "ZEROTO31days" { rItem1.ZEROTO31days =  strVal }
        else if elemName == "ThirtyOneTo60Days" { rItem1.ThirtyOneTo60Days =  strVal }
        else if elemName == "SIXTYOneTo90Days" { rItem1.SIXTYOneTo90Days =  strVal }
        else if elemName == "NINETYOneTo120Days" { rItem1.NINETYOneTo120Days =  strVal }
        else if elemName == "Above120DAYS" { rItem1.Above120DAYS =  strVal }
        else if elemName == "CustomerAgying_Status" { rItem1.CustomerAgying_Status =  strVal }
        return rItem1
    }
    
    func BindCustomerAgingGV(cutomerid: String)-> [CreditLimitModul]{
        var returnValueArray = CreditLimitModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCustomerAgingGV xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<cutomerid>"
        soapReqXML += cutomerid
        soapReqXML += "</cutomerid>"
        soapReqXML += "</BindCustomerAgingGV>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindCustomerAgingGV"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CreditLimitModul() }, getValue: {elementName, value in
            self.getElementValueForBindCustomerAgingGV(elemName: elementName, strVal: value, returnValueArray: returnValueArray)
        }) as? [CreditLimitModul]{ return returnValue }
        
        return [CreditLimitModul]()
    }
    
    func BindSalesOrderItems(customerid: String)-> [ItemSalesModel]{
        var returnValueArray = ItemSalesModel()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderItems xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "</BindSalesOrderItems>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesOrderItems"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ItemSalesModel() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "DRP_ITEMNUMER" { rItem1.DRP_ITEMNUMER =  strVal }
            else if elemName == "DrpItemId" { rItem1.DrpItemId =  strVal }
            else if elemName == "DrpItems" { rItem1.DrpItems =  strVal }
            return rItem1
            
        }) as? [ItemSalesModel]{ return returnValue }
        
        return [ItemSalesModel]()
    }
    
    private func getElementValueForBindPurchaseGridData(elemName: String, strVal: String, returnValueArray: ItemClassModul) -> ItemClassModul{
        let rItem1 = returnValueArray
        if elemName == "grid_error" { rItem1.grid_error =  strVal }
        else if elemName == "Grid_ItemId" { rItem1.Grid_ItemId =  strVal }
        else if elemName == "Grid_Desc" { rItem1.Grid_Desc =  strVal }
        else if elemName == "Grid_UOM" { rItem1.Grid_UOM =  strVal }
        else if elemName == "Grid_Qty" { rItem1.Grid_Qty =  strVal }
        else if elemName == "Grid_UnitPrice" { rItem1.Grid_UnitPrice =  strVal }
        else if elemName == "Grid_TotalPrice" { rItem1.Grid_TotalPrice =  strVal }
        return rItem1
    }
    
    func BindPurchaseGridData(quantity: String, quantityrequired: Double, ItemId: String, unitofmeasure: String, customerid: String, loccode: String) -> [ItemClassModul]{
        var returnValueArray = ItemClassModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindPurchaseGridData xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<quantity>"
        soapReqXML += quantity
        soapReqXML += "</quantity>"
        soapReqXML += "<quantityrequired>"
        soapReqXML += String(quantityrequired)
        soapReqXML += "</quantityrequired>"
        soapReqXML += "<ItemId>"
        soapReqXML += ItemId
        soapReqXML += "</ItemId>"
        soapReqXML += "<unitofmeasure>"
        soapReqXML += unitofmeasure
        soapReqXML += "</unitofmeasure>"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "<loccode>"
        soapReqXML += loccode
        soapReqXML += "</loccode>"
        soapReqXML += "</BindPurchaseGridData>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindPurchaseGridData"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ItemClassModul() }, getValue: {elementName, value in
            self.getElementValueForBindPurchaseGridData(elemName: elementName, strVal: value, returnValueArray: returnValueArray)
        }) as? [ItemClassModul]{ return returnValue }
        
        return [ItemClassModul]()
    }
    
    func CheckItemQty(itemnumber: String, uofm: String, Locode: String, qty: Double, uofmDdl: String, ItemIdgrid: String, qtygrid: Double) -> Double{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckItemQty xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<itemnumber>"
        soapReqXML += itemnumber
        soapReqXML += "</itemnumber>"
        soapReqXML += "<uofm>"
        soapReqXML += uofm
        soapReqXML += "</uofm>"
        soapReqXML += "<Locode>"
        soapReqXML += Locode
        soapReqXML += "</Locode>"
        soapReqXML += "<qty>"
        soapReqXML += String(qty)
        soapReqXML += "</qty>"
        soapReqXML += "<uofmDdl>"
        soapReqXML += uofmDdl
        soapReqXML += "</uofmDdl>"
        soapReqXML += "<ItemIdgrid>"
        soapReqXML += ItemIdgrid
        soapReqXML += "</ItemIdgrid>"
        soapReqXML += "<qtygrid>"
        soapReqXML += String(qtygrid)
        soapReqXML += "</qtygrid>"
        soapReqXML += "</CheckItemQty>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CheckItemQty"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = commonFunction.stringFromXML(data : responseData);
        if let strVal = strVal{
            if let doubleStrVal = strVal.toDouble(){
                return doubleStrVal
            }
        }
        return 0
    }
    
    func CustomerDDLReset(cutomerid: String) -> Bool{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CustomerDDLReset xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<cutomerid>"
        soapReqXML += cutomerid
        soapReqXML += "</cutomerid>"
        soapReqXML += "</CustomerDDLReset>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CustomerDDLReset"
        
        let responseData:Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal {
            return strVal.lowercased() == "true"
        }
        return false
    }
    
    func qtyChangeInGrid(gpcust: Bool, itemNum: String, gridqty: String, girdUofm: String, gridItemNum: String, uofm: String, locCodeValue: String) -> [ItemClassModul]{
        var returnValueArray = ItemClassModul()
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<qtyChangeInGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<gpcust>"
        soapReqXML += String(gpcust)
        soapReqXML += "</gpcust>"
        soapReqXML += "<itemNum>"
        soapReqXML += itemNum
        soapReqXML += "</itemNum>"
        soapReqXML += "<gridqty>"
        soapReqXML += gridqty
        soapReqXML += "</gridqty>"
        soapReqXML += "<girdUofm>"
        soapReqXML += girdUofm
        soapReqXML += "</girdUofm>"
        soapReqXML += "<gridItemNum>"
        soapReqXML += gridItemNum
        soapReqXML += "</gridItemNum>"
        soapReqXML += "<uofm>"
        soapReqXML += uofm
        soapReqXML += "</uofm>"
        soapReqXML += "<locCodeValue>"
        soapReqXML += locCodeValue
        soapReqXML += "</locCodeValue>"
        soapReqXML += "</qtyChangeInGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/qtyChangeInGrid"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ItemClassModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "grid_error" { rItem1.grid_error =  strVal }
            return rItem1
            
        }) as? [ItemClassModul]{ return returnValue }
        
        return [ItemClassModul]()
    }
    
    func SendItemGrid(orderid: String, serialno: Int, customerid: String, Grid_ItemId: String, Grid_Desc: String, Grid_UnitPrice: String, Grid_Qty: String, Grid_TotalPrice: String, Grid_UOM: String) -> [ItemSendModul]{
        var returnValueArray = ItemSendModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SendItemGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "<serialno>"
        soapReqXML += String(serialno)
        soapReqXML += "</serialno>"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "<Grid_ItemId>"
        soapReqXML += Grid_ItemId
        soapReqXML += "</Grid_ItemId>"
        soapReqXML += "<Grid_Desc>"
        soapReqXML += Grid_Desc
        soapReqXML += "</Grid_Desc>"
        soapReqXML += "<Grid_UnitPrice>"
        soapReqXML += Grid_UnitPrice
        soapReqXML += "</Grid_UnitPrice>"
        soapReqXML += "<Grid_Qty>"
        soapReqXML += Grid_Qty
        soapReqXML += "</Grid_Qty>"
        soapReqXML += "<Grid_TotalPrice>"
        soapReqXML += Grid_TotalPrice
        soapReqXML += "</Grid_TotalPrice>"
        soapReqXML += "<Grid_UOM>"
        soapReqXML += Grid_UOM
        soapReqXML += "</Grid_UOM>"
        soapReqXML += "</SendItemGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SendItemGrid"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ItemSendModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "grid_error" { rItem1.grid_error =  strVal }
            else if elemName == "OrderID" { rItem1.OrderID =  strVal }
            else if elemName == "Flag" { rItem1.Flag =  (strVal.lowercased() == "true") }
            else if elemName == "SO_Status" { rItem1.Status =  strVal }
            return rItem1
            
        }) as? [ItemSendModul]{ return returnValue }
        
        return [ItemSendModul]()
    }
    
    func Senditem(orderid: String, branchid: String, customerid: String, branch: String, table: Bool, salesperson: String, company: String, emp_id: String, comment: String, city: String, store: String, salespersonstore: String, merchandiser: String, offer: Bool, deliverydate: String, loccode: String, docid: String, purchasegrid: String, supermarket: Bool, flag: Bool, orderstatus: Int) -> [ItemSendModul]{
        var returnValueArray = ItemSendModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Senditem xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "<branchid>"
        soapReqXML += branchid
        soapReqXML += "</branchid>"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "<branch>"
        soapReqXML += branch
        soapReqXML += "</branch>"
        soapReqXML += "<table>"
        soapReqXML += String(table)
        soapReqXML += "</table>"
        soapReqXML += "<salesperson>"
        soapReqXML += salesperson
        soapReqXML += "</salesperson>"
        soapReqXML += "<company>"
        soapReqXML += company
        soapReqXML += "</company>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<city>"
        soapReqXML += city
        soapReqXML += "</city>"
        soapReqXML += "<store>"
        soapReqXML += store
        soapReqXML += "</store>"
        soapReqXML += "<salespersonstore>"
        soapReqXML += salespersonstore
        soapReqXML += "</salespersonstore>"
        soapReqXML += "<merchandiser>"
        soapReqXML += merchandiser
        soapReqXML += "</merchandiser>"
        soapReqXML += "<offer>"
        soapReqXML += String(offer)
        soapReqXML += "</offer>"
        soapReqXML += "<deliverydate>"
        soapReqXML += deliverydate
        soapReqXML += "</deliverydate>"
        soapReqXML += "<loccode>"
        soapReqXML += loccode
        soapReqXML += "</loccode>"
        soapReqXML += "<docid>"
        soapReqXML += docid
        soapReqXML += "</docid>"
        soapReqXML += "<purchasegrid>"
        soapReqXML += purchasegrid
        soapReqXML += "</purchasegrid>"
        soapReqXML += "<supermarket>"
        soapReqXML += String(supermarket)
        soapReqXML += "</supermarket>"
        soapReqXML += "<flag>"
        soapReqXML += String(flag)
        soapReqXML += "</flag>"
        soapReqXML += "<orderstatus>"
        soapReqXML += String(orderstatus)
        soapReqXML += "</orderstatus>"
        soapReqXML += "</Senditem>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Senditem"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = ItemSendModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "grid_error" { rItem1.grid_error =  strVal }
            return rItem1
            
        }) as? [ItemSendModul]{ return returnValue }
        
        return [ItemSendModul]()
    }
    
    func BindSalesOrderUnitofMeasure(itemid:String)-> [unitOfMeasurementModel]{
        var returnValueArray = unitOfMeasurementModel()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderUnitofMeasure xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<itemid>"
        soapReqXML += itemid
        soapReqXML += "</itemid>"
        soapReqXML += "</BindSalesOrderUnitofMeasure>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesOrderUnitofMeasure"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = unitOfMeasurementModel() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "UnitofMeasure" { rItem1.UnitofMeasure =  strVal }
            return rItem1
            
        }) as? [unitOfMeasurementModel]{ return returnValue }
        
        return [unitOfMeasurementModel]()
    }
    
    
    
}


















