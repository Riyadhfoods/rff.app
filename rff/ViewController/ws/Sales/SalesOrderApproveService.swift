//
//  SalesOrderApproveService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesOrderApproveService{
    static let instance = SalesOrderApproveService()
    let commonSalesService = SalesCommonService.instance
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://82.118.166.164/ios_hrms/sales.asmx"
    private var Host: String = "82.118.166.164"
    
    private var returnValueForSalesOrderApprove = SalesOrderApproveModul()
    private func getElementValueForSalesOrderApprove(elemName: String, strVal: String) -> SalesOrderApproveModul{
        let rItem1 = returnValueForSalesOrderApprove
        if elemName == "OrderID" { rItem1.OrderID =  strVal }
        else if elemName == "ReqDate" { rItem1.ReqDate =  strVal }
        else if elemName == "DeliveryDate" { rItem1.DeliveryDate =  strVal }
        else if elemName == "SO_EmpCreated" { rItem1.EmpCreated = strVal }
        else if elemName == "SO_Comment" { rItem1.Comment =  strVal }
        else if elemName == "SO_CustomerName" { rItem1.CustomerName =  strVal }
        else if elemName == "SO_Items" { rItem1.Items = strVal }
        else if elemName == "SO_Status" { rItem1.Status =  strVal }
        return rItem1
    }
    
    func SalesOrderApprove(empno: Int) -> [SalesOrderApproveModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SalesOrderApprove xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += String(empno)
        soapReqXML += "</empno>"
        soapReqXML += "</SalesOrderApprove>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SalesOrderApprove"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url , SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForSalesOrderApprove = SalesOrderApproveModul() }, getValue: {elementName, value in
            self.getElementValueForSalesOrderApprove(elemName: elementName, strVal: value)
        }) as? [SalesOrderApproveModul]{ return returnValue }
        
        return [SalesOrderApproveModul]()
    }
    
    private var returnValueForBindOrderItemGrid = OrderApproveItem()
    private func getElementValueForBindOrderItemGrid(elemName: String, strVal: String) -> OrderApproveItem{
        let rItem1 = returnValueForBindOrderItemGrid
        if elemName == "SOA_SERIALNUMBER" { rItem1.SERIALNUMBER =  strVal }
        else if elemName == "SOA_ITEMNUMBER" { rItem1.ITEMNUMBER =  strVal }
        else if elemName == "SOA_ITEMDESC" { rItem1.ITEMDESC =  strVal }
        else if elemName == "SOA_CHANGEDPRICE" { rItem1.CHANGEDPRICE = strVal }
        else if elemName == "SOA_ORIGINALPRICE" { rItem1.ORIGINALPRICE =  strVal }
        else if elemName == "SOA_QTY" { rItem1.QTY =  strVal }
        else if elemName == "SOA_UNITOFMEASUREMENT" { rItem1.UNITOFMEASUREMENT = strVal }
        else if elemName == "SOA_LASTYEARORDERQTY" { rItem1.LASTYEARORDERQTY =  strVal }
        else if elemName == "SOA_YEARTODATEORDERQTY" { rItem1.YEARTODATEORDERQTY =  strVal }
        else if elemName == "SOA_TOTAL" { rItem1.TOTAL =  strVal }
        else if elemName == "SOA_REQUESTDATE" { rItem1.REQUESTDATE = strVal }
        else if elemName == "SOA_DELIVERYDATE" { rItem1.DELIVERYDATE =  strVal }
        else if elemName == "OrderID" { rItem1.DELIVERYDATE =  strVal }
        return rItem1
    }
    
    func BindOrderItemGridFor_SalesApprovalForm(emp_id: String, ordernumber: String) -> [OrderApproveItem]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindOrderItemGridFor_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "</BindOrderItemGridFor_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindOrderItemGridFor_SalesApprovalForm"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url , SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindOrderItemGrid = OrderApproveItem() }, getValue: {elementName, value in
            self.getElementValueForBindOrderItemGrid(elemName: elementName, strVal: value)
        }) as? [OrderApproveItem]{ return returnValue }
        
        return [OrderApproveItem]()
    }
    
    private var returnValueForBindCustomerCreditGridView = OrderApproveCreditModul()
    private func getElementValueForBindCustomerCreditGridView(elemName: String, strVal: String) -> OrderApproveCreditModul{
        let rItem1 = returnValueForBindCustomerCreditGridView
        if elemName == "SOA_CUSTOMERID" { rItem1.CUSTOMERID =  strVal }
        else if elemName == "SOA_CUSTOMERNAME" { rItem1.CUSTOMERNAME =  strVal }
        else if elemName == "SOA_CREDITLIMIT" { rItem1.CREDITLIMIT =  strVal }
        else if elemName == "SOA_TOTALDUE" { rItem1.TOTALDUE = strVal }
        else if elemName == "SOA_ZEROTOTHIRYONEDAYS" { rItem1.ZEROTOTHIRYONEDAYS =  strVal }
        else if elemName == "SOA_THIRYONETOSIXTYDAYS" { rItem1.THIRYONETOSIXTYDAYS =  strVal }
        else if elemName == "SOA_SIXTYONETONINETYDAYS" { rItem1.SIXTYONETONINETYDAYS = strVal }
        else if elemName == "SOA_NINETYONETOHUNDREDTWENTYDAYS" { rItem1.NINETYONETOHUNDREDTWENTYDAYS =  strVal }
        else if elemName == "SOA_ABOVE120DAYS" { rItem1.ABOVE120DAYS =  strVal }
        else if elemName == "SOA_STATUS" { rItem1.STATUS =  strVal }
        return rItem1
    }
    
    func BindCustomerCreditGridView_SalesApprovalForm(ordernumber: String) -> [OrderApproveCreditModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCustomerCreditGridView_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "</BindCustomerCreditGridView_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindCustomerCreditGridView_SalesApprovalForm"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url , SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindCustomerCreditGridView = OrderApproveCreditModul() }, getValue: {elementName, value in
            self.getElementValueForBindCustomerCreditGridView(elemName: elementName, strVal: value)
        }) as? [OrderApproveCreditModul]{ return returnValue }
        
        return [OrderApproveCreditModul]()
    }
    
    private var returnValueForBindCombobox = ComBoxMudel()
    private func getElementValueForBindCombobox(elemName: String, strVal: String) -> ComBoxMudel{
        let rItem1 = returnValueForBindCombobox
        if elemName == "DocumentId" { rItem1.DocumentId =  strVal }
        else if elemName == "LocationCode" { rItem1.LocationCode =  strVal }
        return rItem1
    }
    
    func BindCombobox(ordernumber: String)-> [ComBoxMudel]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCombobox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "</BindCombobox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindCombobox"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url , SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindCombobox = ComBoxMudel() }, getValue: {elementName, value in
            self.getElementValueForBindCombobox(elemName: elementName, strVal: value)
        }) as? [ComBoxMudel]{ return returnValue }
        
        return [ComBoxMudel]()
    }
    
    private var returnValueForCheckSalesApproval = SalesOrderButtonVisibiltyMudel()
    private func getElementValueForCheckSalesApproval(elemName: String, strVal: String) -> SalesOrderButtonVisibiltyMudel{
        let rItem1 = returnValueForCheckSalesApproval
        if elemName == "ApproveandEnterManually_btn" { rItem1.ApproveandEnterManually_btn =  (strVal.lowercased() == "true") }
        else if elemName == "U_Comment" { rItem1.U_Comment =  (strVal.lowercased() == "true") }
        else if elemName == "App_btn_vis" { rItem1.App_btn_vis =  (strVal.lowercased() == "true") }
        else if elemName == "Rej_btn_vis" { rItem1.Rej_btn_vis =  (strVal.lowercased() == "true") }
        else if elemName == "Report_btn_vis" { rItem1.Report_btn_vis =  (strVal.lowercased() == "true") }
        else if elemName == "Savetogp_btn_vis" { rItem1.Savetogp_btn_vis =  (strVal.lowercased() == "true") }
        else if elemName == "Loc_control_vis" { rItem1.Loc_control_vis =  (strVal.lowercased() == "true") }
        else if elemName == "DocId_control_vis" { rItem1.DocId_control_vis =  (strVal.lowercased() == "true") }
        else if elemName == "Flag" { rItem1.Flag =  (strVal.lowercased() == "true") }
        else if elemName == "Approver" { rItem1.Approver =  strVal }
        else if elemName == "Approver1" { rItem1.Approver1 =  strVal }
        else if elemName == "App_Market" { rItem1.App_Market =  strVal }
        else if elemName == "App_Retail" { rItem1.App_Retail =  strVal }
        else if elemName == "App_Export" { rItem1.App_Export =  strVal }
        else if elemName == "App_Diary" { rItem1.App_Diary =  strVal }
        return rItem1
    }
    
    func CheckSalesApproval(emp_number: String, order_number: String, comment: String) -> [SalesOrderButtonVisibiltyMudel]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckSalesApproval xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_number>"
        soapReqXML += emp_number
        soapReqXML += "</emp_number>"
        soapReqXML += "<order_number>"
        soapReqXML += order_number
        soapReqXML += "</order_number>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</CheckSalesApproval>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/CheckSalesApproval"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url , SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForCheckSalesApproval = SalesOrderButtonVisibiltyMudel() }, getValue: {elementName, value in
            self.getElementValueForCheckSalesApproval(elemName: elementName, strVal: value)
        }) as? [SalesOrderButtonVisibiltyMudel]{ return returnValue }
        
        return [SalesOrderButtonVisibiltyMudel]()
    }
    
    func BeforeApproveFinalOrder(serialnumber: String, ordernumber: String, checkbox: Bool){
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BeforeApproveFinalOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<serialnumber>"
        soapReqXML += serialnumber
        soapReqXML += "</serialnumber>"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "<checkbox>"
        soapReqXML += String(checkbox)
        soapReqXML += "</checkbox>"
        soapReqXML += "</BeforeApproveFinalOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BeforeApproveFinalOrder"
        
        let _ = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
    }
    
    func ApproveFinalOrder(orderno: String, approver: String, empno: String, comment: String) -> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<ApproveFinalOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderno>"
        soapReqXML += orderno
        soapReqXML += "</orderno>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</ApproveFinalOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/ApproveFinalOrder"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    func Reject_SalesOrderApproval(ordernumber:String, empnumber:String, app_diary:String, app_retail:String, app_market:String, export:String, approval1:String, approver:String, comment:String)-> String{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Reject_SalesOrderApproval xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<ordernumber>"
        soapReqXML += ordernumber
        soapReqXML += "</ordernumber>"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "<app_diary>"
        soapReqXML += app_diary
        soapReqXML += "</app_diary>"
        soapReqXML += "<app_retail>"
        soapReqXML += app_retail
        soapReqXML += "</app_retail>"
        soapReqXML += "<app_market>"
        soapReqXML += app_market
        soapReqXML += "</app_market>"
        soapReqXML += "<export>"
        soapReqXML += export
        soapReqXML += "</export>"
        soapReqXML += "<approval1>"
        soapReqXML += approval1
        soapReqXML += "</approval1>"
        soapReqXML += "<approver>"
        soapReqXML += approver
        soapReqXML += "</approver>"
        soapReqXML += "<comment>"
        soapReqXML += comment
        soapReqXML += "</comment>"
        soapReqXML += "</Reject_SalesOrderApproval>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/Reject_SalesOrderApproval"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        let strVal: String? = commonFunction.stringFromXML(data: responseData);
        if let strVal = strVal{
            let returnValue: String = strVal
            return returnValue
        }
        return  ""
    }
    
    private var returnValueForSaveToGp = SaveToGpMudel()
    private func getElementValueForSaveToGp(elemName: String, strVal: String) -> SaveToGpMudel{
        let rItem1 = returnValueForSaveToGp
        if elemName == "GP_Save" { rItem1.GP_Save =  strVal }
        else if elemName == "GP_Error" { rItem1.GP_Error =  strVal }
        else if elemName == "Savetogp_btn_vis" { rItem1.Savetogp_btn_vis =  (strVal.lowercased() == "true") }
        else if elemName == "ApproveandEnterManually_btn" { rItem1.ApproveandEnterManually_btn =  (strVal.lowercased() == "true") }
        return rItem1
    }
    
    func SaveToGp(orderno: String, combo_loc_code: String, combo_doc_id: String, empnumber: String) -> [SaveToGpMudel]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SaveToGp xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderno>"
        soapReqXML += orderno
        soapReqXML += "</orderno>"
        soapReqXML += "<combo_loc_code>"
        soapReqXML += combo_loc_code
        soapReqXML += "</combo_loc_code>"
        soapReqXML += "<combo_doc_id>"
        soapReqXML += combo_doc_id
        soapReqXML += "</combo_doc_id>"
        soapReqXML += "<empnumber>"
        soapReqXML += empnumber
        soapReqXML += "</empnumber>"
        soapReqXML += "</SaveToGp>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SaveToGp"
        
        let responseData: Data = SoapHttpClient.callWS(Host: self.Host, WebServiceUrl: self.Url , SoapAction: soapAction, SoapMessage: soapReqXML)
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForSaveToGp = SaveToGpMudel() }, getValue: {elementName, value in
            self.getElementValueForSaveToGp(elemName: elementName, strVal: value)
        }) as? [SaveToGpMudel]{ return returnValue }
        
        return [SaveToGpMudel]()
    }
}

























