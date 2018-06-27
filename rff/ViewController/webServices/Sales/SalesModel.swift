//
//  SalesModel.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
public class SalesModel{
    public var totalrows : Int = 0
    public var currentrows : String = ""
    public var OrderID : String = ""
    public var ReqDate : String = ""
    public var DeliveryDate : String = ""
    public var SO_EmpCreated: String = ""
    public var SO_Comment : String = ""
    public var SO_CustomerName : String = ""
    public var SO_Items : String = ""
    public var SO_Status : String = ""
    public var SO_Url: String = ""
    public var ID : Int = 0
    public var EmpCreated : String = ""
    public var CustomerId : String = ""
    public var CustomerName : String = ""
    public var Items : String = ""
    public var date: String = ""
    public var Status : String = ""
    public var PendingBy : String = ""
    public var Comment : String = ""
    public var URL : String = ""
    public var RequestDate: String = ""
    public var ReturnDate: String = ""
    public var ItemId : String = ""
    public var Description : String = ""
    public var PCS_CRTN : String = ""
    public var Quantity : String = ""
    public var UnitPrice: String = ""
    public var TotalPrice : String = ""
    public var UnitofMeasure : String = ""
    public var CreditLimit : String = ""
    public var ToTalDue : String = ""
    public var ZEROTO31days: String = ""
    public var ThirtyOneTo60Days : String = ""
    public var SIXTYOneTo90Days : String = ""
    public var NINETYOneTo120Days : String = ""
    public var Above120DAYS: String = ""
    public var CustomerAgying_Status : String = ""
    public var DrpItems : String = ""
    public var Customers : String = ""
    public var SalesPersonId : String = ""
    public var SalesPerson : String = ""
    public var LocationCode: String = ""
    public var Comp_ID: String = ""
    public var EName : String = ""
    public var Branch: String = ""
    public var AccountEmp: String = ""
    public var grid_error : String = ""
    public var Merchandiser : String = ""
    public var SalesPersonStore : String = ""
    public var City: String = ""
    public var StoreID : String = ""
    public var StoreName : String = ""
    public var DrpItemId: String = ""
    public var Date: String = ""
    
    public var Flag : String = ""
    public var SOA_SERIALNUMBER: String = ""
    public var SOA_EMPID : String = ""
    public var SOA_NAME: String = ""
    public var SOA_EMPROLE: String = ""
    public var SOA_WORKFLOWSTATUS : String = ""
    public var SOA_TRANSACTIONDATE : String = ""
    public var SOA_EMPNAME : String = ""
    public var SOA_COMMENT : String = ""
    public var SOA_CUSTOMERID: String = ""
    public var SOA_CUSTOMERNAME : String = ""
    public var SOA_CREDITLIMIT : String = ""
    public var SOA_TOTALDUE : String = ""
    public var SOA_ZEROTOTHIRYONEDAYS : String = ""
    public var SOA_THIRYONETOSIXTYDAYS: String = ""
    public var SOA_SIXTYONETONINETYDAYS : String = ""
    public var SOA_NINETYONETOHUNDREDTWENTYDAYS : String = ""
    public var SOA_ABOVE120DAYS : String = ""
    public var SOA_OrderId: String = ""
    public var SOA_STATUS : String = ""
    public var SOA_ITEMNUMBER : String = ""
    public var SOA_ITEMDESC : String = ""
    public var SOA_CHANGEDPRICE : String = ""
    public var SOA_ORIGINALPRICE : String = ""
    public var SOA_QTY: String = ""
    public var SOA_UNITOFMEASUREMENT: String = ""
    public var SOA_LASTYEARORDERQTY : String = ""
    public var SOA_YEARTODATEORDERQTY: String = ""
    public var SOA_TOTAL: String = ""
    public var SOA_REQUESTDATE : String = ""
    public var SOA_DELIVERYDATE : String = ""
    
    public var SalesPersonInFull: String = ""
    public var CustomerInFull: String = ""
    
    public var ItemsAdded: [ItemAddedModel] = [ItemAddedModel]()
}

extension SalesModel: CustomStringConvertible{
    
    public var description: String{
        func getItemAdded() -> String{
            var text: String = ""
            for txt in ItemsAdded{
                text += "\(txt)\n"
            }
            return text
        }
        
        return """
        totalrows = \(totalrows)
        currentrows = \(currentrows)
        OrderID = \(OrderID)
        ReqDate = \(ReqDate)
        DeliveryDate = \(DeliveryDate)
        SO_EmpCreated = \(SO_EmpCreated)
        SO_Comment = \(SO_Comment)
        SO_CustomerName = \(SO_CustomerName)
        SO_Items = \(SO_Items)
        SO_Status = \(SO_Status)
        SO_Url = \(SO_Url)
        ID = \(ID)
        EmpCreated = \(EmpCreated)
        CustomerId = \(CustomerId)
        CustomerName = \(CustomerName)
        Items = \(Items)
        date = \(date)
        Status = \(Status)
        PendingBy = \(PendingBy)
        Comment = \(Comment)
        URL = \(URL)
        RequestDate = \(RequestDate)
        ReturnDate = \(ReturnDate)\n
        ItemId = \(ItemId)
        Description = \(Description)
        PCS_CRTN = \(PCS_CRTN)
        Quantity = \(Quantity)
        UnitPrice = \(UnitPrice)
        TotalPrice = \(TotalPrice)
        UnitofMeasure = \(UnitofMeasure)
        CreditLimit = \(CreditLimit)
        ToTalDue = \(ToTalDue)
        ZEROTO31days = \(ZEROTO31days)
        ThirtyOneTo60Days = \(ThirtyOneTo60Days)
        SIXTYOneTo90Days = \(SIXTYOneTo90Days)
        NINETYOneTo120Days = \(NINETYOneTo120Days)
        Above120DAYS = \(Above120DAYS)
        CustomerAgying_Status = \(CustomerAgying_Status)
        DrpItems = \(DrpItems)
        Customers = \(Customers)
        SalesPersonId = \(SalesPersonId)
        SalesPerson = \(SalesPerson)
        LocationCode = \(LocationCode)
        Comp_ID = \(Comp_ID)
        EName = \(EName)
        Branch = \(Branch)
        AccountEmp = \(AccountEmp)
        SalesPersonInFull = \(SalesPersonInFull)
        CustomerInFull = \(CustomerInFull)
        \(ItemsAdded)
        """
    }
}
