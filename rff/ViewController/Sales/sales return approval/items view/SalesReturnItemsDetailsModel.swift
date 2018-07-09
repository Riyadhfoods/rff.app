//
//  SalesReturnItemsDetailsModel.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class SalesReturnItemsDetailsModel{
    var serialNumber: String = ""
    var InvoiceNumber: String = ""
    var LOTNumber: String = ""
    var ItemNumber: String = ""
    var desc: String = ""
    var unitPrice: String = ""
    var totalCast: String = ""
    var qty: String = ""
    var uofm: String = ""
    var returnType: String = ""
    var isItemChecked: Bool = true
    
    init(serialNumber: String, InvoiceNumber: String, LOTNumber: String, ItemNumber: String, desc: String, unitPrice: String, totalCast: String, qty: String, uofm: String, returnType: String){
        
        self.serialNumber = serialNumber
        self.InvoiceNumber = InvoiceNumber
        self.LOTNumber = LOTNumber
        self.ItemNumber = ItemNumber
        self.desc = desc
        self.unitPrice = unitPrice
        self.totalCast = totalCast
        self.qty = qty
        self.uofm = uofm
        self.returnType = returnType
    }
    
    init(isItemChecked: Bool) {
        self.isItemChecked = isItemChecked
    }
}

extension SalesReturnItemsDetailsModel: CustomStringConvertible{
    
    public var description: String{
        return """
        -----------------------------------------------
        serialNumber = \(serialNumber)
        InvoiceNumber = \(InvoiceNumber)
        LOTNumber = \(LOTNumber)
        ItemNumber = \(ItemNumber)
        desc = \(desc)
        unitPrice = \(unitPrice)
        totalCast = \(totalCast)
        qty = \(qty)
        uofm = \(uofm)
        returnType = \(returnType)
        isItemChecked = \(isItemChecked)
        -----------------------------------------------
        """
    }
}



