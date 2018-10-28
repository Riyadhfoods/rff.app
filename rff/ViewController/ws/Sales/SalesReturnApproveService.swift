//
//  SalesReturnApproveService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesReturnApproveService{
    static let instance = SalesReturnApproveService()
    let commonSalesService = SalesCommonService.instance
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentHost)/ios_hrms/sales.asmx"
    
    private var returnValueForBindOrder = SalesReturnApproveModul()
    private func getElementValueForBindOrder(elementName: String, value: String) -> SalesReturnApproveModul{
        if elementName == "ReturnID" { returnValueForBindOrder.ReturnID =  value }
        else if elementName == "EmpCreated" { returnValueForBindOrder.EmpCreated =  value }
        else if elementName == "Items" { returnValueForBindOrder.Items =  value }
        else if elementName == "ReqDate" { returnValueForBindOrder.ReqDate = value }
        else if elementName == "RetDate" { returnValueForBindOrder.RetDate =  value }
        else if elementName == "Comment" { returnValueForBindOrder.Comment =  value }
        return returnValueForBindOrder
    }
    
    func SRO_BindOrder(empno: String)-> [SalesReturnApproveModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRO_BindOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "</SRO_BindOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRO_BindOrder"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindOrder = SalesReturnApproveModul() },
            getValue: {elementName, value in
                self.getElementValueForBindOrder(elementName: elementName, value: value)
        }) as? [SalesReturnApproveModul]{
            return returnValue
        }
        
        return [SalesReturnApproveModul]()
    }
    
    private var returnValueForBindItemGrid = ReturnApproveItemModel()
    private func getElementValueForBindItemGrid(elementName: String, value: String) -> ReturnApproveItemModel{
        if elementName == "SRA_SerialNumber" { returnValueForBindItemGrid.SerialNumber =  value }
        else if elementName == "SRA_EmpCreated" { returnValueForBindItemGrid.EmpCreated =  value }
        else if elementName == "SRA_CustomerName" { returnValueForBindItemGrid.CustomerName =  value }
        else if elementName == "SRA_SalesPerson" { returnValueForBindItemGrid.SalesPerson = value }
        else if elementName == "SRA_ReqDate" { returnValueForBindItemGrid.ReqDate =  value }
        else if elementName == "SRA_ReturnDate" { returnValueForBindItemGrid.ReturnDate =  value }
        else if elementName == "SRA_InvoiceNumber" { returnValueForBindItemGrid.InvoiceNumber =  value }
        else if elementName == "SRA_LotNumber" { returnValueForBindItemGrid.LotNumber =  value }
        else if elementName == "SRA_ItemNumber" { returnValueForBindItemGrid.ItemNumber = value }
        else if elementName == "SRA_Description" { returnValueForBindItemGrid.Description =  value }
        else if elementName == "SRA_Unitprice" { returnValueForBindItemGrid.Unitprice =  value }
        else if elementName == "SRA_TotalCost" { returnValueForBindItemGrid.TotalCost =  value }
        else if elementName == "SRA_Qty" { returnValueForBindItemGrid.Qty =  value }
        else if elementName == "SRA_UOFM" { returnValueForBindItemGrid.UOFM = value }
        else if elementName == "SRA_ReturnType" { returnValueForBindItemGrid.ReturnType =  value }
        return returnValueForBindItemGrid
    }
    
    func SRA_BindItemGrid(empno: String, returnid: String)-> [ReturnApproveItemModel]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindItemGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindItemGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_BindItemGrid"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindItemGrid = ReturnApproveItemModel() },
            getValue: {elementName, value in
                self.getElementValueForBindItemGrid(elementName: elementName, value: value)
        }) as? [ReturnApproveItemModel]{
            return returnValue
        }
        
        return [ReturnApproveItemModel]()
    }
    
    private var returnValueForBindCustomerAging = ReturnApproveCreditModul()
    private func getElementValueForBindCustomerAging(elementName: String, value: String) -> ReturnApproveCreditModul{
        if elementName == "CreditLimit" { returnValueForBindCustomerAging.CreditLimit =  value }
        else if elementName == "TotalDue" { returnValueForBindCustomerAging.TotalDue =  value }
        else if elementName == "ZeroTo31Days" { returnValueForBindCustomerAging.ZeroTo31Days =  value }
        else if elementName == "ThirtyOneto60Days" { returnValueForBindCustomerAging.ThirtyOneto60Days = value }
        else if elementName == "SixtyOneTo90Days" { returnValueForBindCustomerAging.SixtyOneTo90Days =  value }
        else if elementName == "Nineoneto120Days" { returnValueForBindCustomerAging.Nineoneto120Days =  value }
        else if elementName == "Above120Days" { returnValueForBindCustomerAging.Above120Days =  value }
        else if elementName == "Status" { returnValueForBindCustomerAging.Status =  value }
        return returnValueForBindCustomerAging
    }
    
    func SRR_BindCustomerAging(customer_no: String) -> [ReturnApproveCreditModul]{
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
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindCustomerAging = ReturnApproveCreditModul() },
            getValue: {elementName, value in
                self.getElementValueForBindCustomerAging(elementName: elementName, value: value)
        }) as? [ReturnApproveCreditModul]{
            return returnValue
        }
        
        return [ReturnApproveCreditModul]()
    }
    
    private var returnValueForONLOADCOMPLETE = OnLoandModul()
    private func getElementValueForONLOADCOMPLETE(elementName: String, value: String) -> OnLoandModul{
        if elementName == "SRA_APPROVER" { returnValueForONLOADCOMPLETE.Approver =  value }
        else if elementName == "SRA_APPROVE_BTN" { returnValueForONLOADCOMPLETE.APPROVE_BTN =  (value.lowercased() == "true") }
        else if elementName == "SRA_REJECT_BTN" { returnValueForONLOADCOMPLETE.REJECT_BTN =  (value.lowercased() == "true") }
        else if elementName == "SRR_CustomerDDL" { returnValueForONLOADCOMPLETE.CustomerDDL = (value.lowercased() == "true") }
        else if elementName == "SRR_SalesPersonDDL" { returnValueForONLOADCOMPLETE.SalesPersonDDL =  (value.lowercased() == "true") }
        return returnValueForONLOADCOMPLETE
    }
    
    func SRA_ONLOADCOMPLETE(empnumber: String, returnid: String, comment: String) -> [OnLoandModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_ONLOADCOMPLETE xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</SRA_ONLOADCOMPLETE>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_ONLOADCOMPLETE"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForONLOADCOMPLETE = OnLoandModul() },
            getValue: {elementName, value in
                self.getElementValueForONLOADCOMPLETE(elementName: elementName, value: value)
        }) as? [OnLoandModul]{
            return returnValue
        }
        
        return [OnLoandModul]()
    }
    
    private var returnValueForBindAttachmentGrid = ReturnApproveAttachment()
    private func getElementValueForBindAttachmentGrid(elementName: String, value: String) -> ReturnApproveAttachment{
        if elementName == "INDEX" { returnValueForBindAttachmentGrid.INDEX =  value }
        else if elementName == "FILENAME" { returnValueForBindAttachmentGrid.FILENAME =  value }
        else if elementName == "FILETYPE" { returnValueForBindAttachmentGrid.FILETYPE =  value }
        return returnValueForBindAttachmentGrid
    }
    
    func SRA_BindAttachmentGrid(empno: String, returnid: String)-> [ReturnApproveAttachment]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindAttachmentGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindAttachmentGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_BindAttachmentGrid"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindAttachmentGrid = ReturnApproveAttachment() },
            getValue: {elementName, value in
                self.getElementValueForBindAttachmentGrid(elementName: elementName, value: value)
        }) as? [ReturnApproveAttachment]{
            return returnValue
        }
        
        return [ReturnApproveAttachment]()
    }
    
    func SRA_BEFOREAPPROVE(empno: String, returnid: String, gridcheckbox: Bool, serialnumber: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BEFOREAPPROVE xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<gridcheckbox>"
        soapReqXML += String(gridcheckbox)
        soapReqXML += "</gridcheckbox>"
        soapReqXML += "<serialnumber>"
        soapReqXML += serialnumber
        soapReqXML += "</serialnumber>"
        soapReqXML += "</SRA_BEFOREAPPROVE>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_BEFOREAPPROVE"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    func SRA_APPROVE(empnumber: String, returnid: String, approver: String, comment: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_APPROVE xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</SRA_APPROVE>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_APPROVE"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    func SRA_REJECT(returnid: String, empnumber: String, comment: String, approver: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_REJECT xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "</SRA_REJECT>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_REJECT"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
}
