//
//  SORModul.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class SOR {
    var emp_id: String = ""
    var orderId: String = ""
    var company: String = ""
    var companyId: String = ""
    var branch: String = ""
    var branchId: String = ""
    var docid: String = ""
    var loccode: String = ""
    var salesperson: String = ""
    var customer: String = ""
    var deliverydate: String = ""
    var offer: Bool = false
    var supermarket: Bool = false
    var store: String = ""
    var city: String = ""
    var salespersonstore: String = ""
    var merchandiser: String = ""
    var purchasegrid: String = ""
    var comment: String = ""
    var table: Bool = false
    var flag: Bool = false
    var itemsArray = [ItemsModul]()
    
    func removeAll(){
        orderId = ""
        company = ""
        companyId = ""
        branch = ""
        branchId = ""
        docid = ""
        loccode = ""
        salesperson = ""
        customer = ""
        deliverydate = ""
        offer = false
        supermarket = false
        store = ""
        city = ""
        salespersonstore = ""
        merchandiser = ""
        purchasegrid = ""
        comment = ""
        table = false
        flag = false
        itemsArray = [ItemsModul]()
    }
}

extension SOR: CustomStringConvertible{
    func getItemsArray() -> String {
        var text: String = ""
        for txt in itemsArray{
            text += "Grid_ItemId: \(txt.Grid_ItemId.prefix(4))\n"
            text += "Grid_Desc: \(txt.Grid_Desc)\n"
            text += "Grid_UOM: \(txt.Grid_UOM)\n"
            text += "Grid_Qty: \(txt.Grid_Qty)\n"
            text += "Grid_UnitPrice: \(txt.Grid_UnitPrice)\n"
            text += "Grid_TotalPrice: \(txt.Grid_TotalPrice)\n"
            text += "grid_error: \(txt.grid_error)\n"
        }
        return text
    }
    
    public var description: String {
        return """
        emp_id: \(emp_id)
        orderId: \(orderId)
        company: \(company)
        companyId: \(companyId)
        branch: \(branch)
        branchId: \(branchId)
        docid: \(docid)
        loccode: \(loccode)
        salesperson: \(salesperson)
        customer: \(customer)
        deliverydate: \(deliverydate)
        offer: \(offer)
        supermarket: \(supermarket)
        store: \(store)
        city: \(city)
        salespersonstore: \(salespersonstore)
        merchandiser: \(merchandiser)
        purchasegrid: \(purchasegrid)
        comment: \(comment)
        table: \(table)
        flag: \(flag)
        items in array:
        \(getItemsArray())
        """
    }
}
