//
//  SalesCommonService.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class SalesCommonService{
    static let instance = SalesCommonService()
    let commonFunction = CommonFunction.shared
    
    private var Url: String = "http://\(currentHost)/ios_hrms/sales.asmx"
    
    private var returnValueForBindUserComment = CommentModul()
    private func getElementValueForBindUserComment(elementName: String, value: String) -> CommentModul{
        if elementName == "SOA_EMPNAME" { returnValueForBindUserComment.Name =  value }
        else if elementName == "SOA_COMMENT" { returnValueForBindUserComment.Comment =  value }
        return returnValueForBindUserComment
    }
    
    func BindUserComment_SalesApprovalForm(orderid: String)-> [CommentModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindUserComment_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "</BindUserComment_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindUserComment_SalesApprovalForm"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindUserComment = CommentModul() },
            getValue: {elementName, value in
                self.getElementValueForBindUserComment(elementName: elementName, value: value)
        }) as? [CommentModul]{
            return returnValue
        }
        
        return [CommentModul]()
    }
    
    private var returnValueForBindApprovalGrid = WorkFlowModul()
    private func getElementValueForBindApprovalGrid(elementName: String, value: String) -> WorkFlowModul{
        if elementName == "SOA_EMPID" { returnValueForBindApprovalGrid.WorkFlow_Empid =  value }
        else if elementName == "SOA_NAME" { returnValueForBindApprovalGrid.WorkFlow_EmpName =  value }
        else if elementName == "SOA_EMPROLE" { returnValueForBindApprovalGrid.WorkFlow_EmpRole =  value }
        else if elementName == "SOA_STATUS" { returnValueForBindApprovalGrid.WorkFlow_EmpStatus =  value }
        else if elementName == "SOA_TRANSACTIONDATE" { returnValueForBindApprovalGrid.WorkFlow_EmpTransDate =  value }
        return returnValueForBindApprovalGrid
    }
    
    func BindApprovalGrid_SalesApprovalForm(orderid: String) -> [WorkFlowModul]{
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindApprovalGrid_SalesApprovalForm xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<orderid>"
        soapReqXML += orderid
        soapReqXML += "</orderid>"
        soapReqXML += "</BindApprovalGrid_SalesApprovalForm>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/BindApprovalGrid_SalesApprovalForm"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindApprovalGrid = WorkFlowModul() },
            getValue: {elementName, value in
                self.getElementValueForBindApprovalGrid(elementName: elementName, value: value)
        }) as? [WorkFlowModul]{
            return returnValue
        }
        
        return [WorkFlowModul]()
    }
    
    private var returnValueForBindUserGrid = CommentModul()
    private func getElementValueForBindUserGrid(elementName: String, value: String) -> CommentModul{
        if elementName == "SRA_User_EmpName" { returnValueForBindUserGrid.Name =  value }
        else if elementName == "SRA_User_EmpComment" { returnValueForBindUserGrid.Comment =  value }
        return returnValueForBindUserGrid
    }
    
    func SRA_BindUserGrid(empno: String, returnid: String)-> [CommentModul]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindUserGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindUserGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction: String = "http://tempuri.org/SRA_BindUserGrid"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(
            data: responseData,
            reSet: { returnValueForBindUserGrid = CommentModul() },
            getValue: {elementName, value in
                self.getElementValueForBindUserGrid(elementName: elementName, value: value)
        }) as? [CommentModul]{
            return returnValue
        }
        
        return [CommentModul]()
    }
    
    private var returnValueForBindApproverGridSRA = WorkFlowModul()
    private func getElementValueForBindApproverGridSRA (elementName: String, value: String) -> WorkFlowModul{
        if elementName == "SRA_EMP_ID" { returnValueForBindApproverGridSRA.WorkFlow_Empid =  value }
        else if elementName == "SRA_Name" { returnValueForBindApproverGridSRA.WorkFlow_EmpName =  value }
        else if elementName == "SRA_EmpRole" { returnValueForBindApproverGridSRA.WorkFlow_EmpRole =  value }
        else if elementName == "SRA_Status" { returnValueForBindApproverGridSRA.WorkFlow_EmpStatus =  value }
        else if elementName == "SRA_TransDate" { returnValueForBindApproverGridSRA.WorkFlow_EmpTransDate =  value }
        return returnValueForBindApproverGridSRA
    }
    
    func SRA_BindApproverGrid(empno:String, returnid:String)-> [WorkFlowModul]{
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SRA_BindApproverGrid xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += empno
        soapReqXML += "</empno>"
        soapReqXML += "<returnid>"
        soapReqXML += returnid
        soapReqXML += "</returnid>"
        soapReqXML += "</SRA_BindApproverGrid>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/SRA_BindApproverGrid"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueForBindApproverGridSRA = WorkFlowModul() }, getValue: {elementName, value in
                self.getElementValueForBindApproverGridSRA(elementName: elementName, value: value)
        }) as? [WorkFlowModul]{ return returnValue }
        
        return [WorkFlowModul]()
    }
    
    func BindSalesOrderCompany() -> [CompanyModul]{
        var returnValueArray = CompanyModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderCompany xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderCompany>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesOrderCompany"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = CompanyModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Comp_ID" { rItem1.Comp_ID =  strVal }
            else if elemName == "EName" { rItem1.EName =  strVal }
            return rItem1
            
        }) as? [CompanyModul]{ return returnValue }
        
        return [CompanyModul]()
    }
    
    func BindSalesOrderBranches() -> [BranchModul]{
        var returnValueArray = BranchModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesOrderBranches xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</BindSalesOrderBranches>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesOrderBranches"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = BranchModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Branch" { rItem1.Branch =  strVal }
            else if elemName == "AccountEmp" { rItem1.AccountEmp = strVal }
            return rItem1
            
        }) as? [BranchModul]{ return returnValue }
        
        return [BranchModul]()
    }
    
    func BindDdlStore(customerid: String) -> [StoreModul]{
        var returnValueArray = StoreModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindDdlStore xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customerid>"
        soapReqXML += customerid
        soapReqXML += "</customerid>"
        soapReqXML += "</BindDdlStore>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindDdlStore"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = StoreModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "StoreID" { rItem1.StoreID =  strVal }
            else if elemName == "StoreName" { rItem1.StoreName =  strVal }
            return rItem1
            
        }) as? [StoreModul]{ return returnValue }
        
        return [StoreModul]()
    }
    
    func BindCity(storevalue: String, customer: String) -> [StoreModul]{
        var returnValueArray = StoreModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindCity xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<storevalue>"
        soapReqXML += storevalue
        soapReqXML += "</storevalue>"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "</BindCity>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindCity"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = StoreModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "City" { rItem1.City =  strVal }
            return rItem1
            
        }) as? [StoreModul]{ return returnValue }
        
        return [StoreModul]()
    }
    
    func BindSalesPersonforStore(customer: String, city: String, store: String) -> [StoreModul]{
        var returnValueArray = StoreModul()
        
        var soapReqXML: String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindSalesPersonforStore xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "<city>"
        soapReqXML += city
        soapReqXML += "</city>"
        soapReqXML += "<store>"
        soapReqXML += store
        soapReqXML += "</store>"
        soapReqXML += "</BindSalesPersonforStore>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindSalesPersonforStore"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = StoreModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "SalesPersonStore" { rItem1.SalesPersonStore =  strVal }
            return rItem1
            
        }) as? [StoreModul]{ return returnValue }
        
        return [StoreModul]()
    }
    
    func BindMerchandiser(customer: String, city: String, store: String, salesperson: String) -> [StoreModul]{
        var returnValueArray = StoreModul()
        
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        soapReqXML += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<BindMerchandiser xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<customer>"
        soapReqXML += customer
        soapReqXML += "</customer>"
        soapReqXML += "<city>"
        soapReqXML += city
        soapReqXML += "</city>"
        soapReqXML += "<store>"
        soapReqXML += store
        soapReqXML += "</store>"
        soapReqXML += "<salesperson>"
        soapReqXML += salesperson
        soapReqXML += "</salesperson>"
        soapReqXML += "</BindMerchandiser>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        let soapAction: String = "http://tempuri.org/BindMerchandiser"
        
        let responseData: Data = SoapHttpClient.callWS(WebServiceUrl: self.Url, SoapAction: soapAction, SoapMessage: soapReqXML)
        
        if let returnValue = commonFunction.ArrValues(data: responseData, reSet: { returnValueArray = StoreModul() }, getValue: {elemName, strVal in
            
            let rItem1 = returnValueArray
            if elemName == "Merchandiser" { rItem1.Merchandiser =  strVal }
            return rItem1
            
        }) as? [StoreModul]{ return returnValue }
        
        return [StoreModul]()
    }
    
}
