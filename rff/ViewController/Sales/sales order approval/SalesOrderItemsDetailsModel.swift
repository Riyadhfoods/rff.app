//
//  SalesOrderItemsDetailsModel.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 30/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class SalesOrderItemsDetailsModel {
    var approveAndEnterManButtonVisibility: Bool = false
    var commentButtonVisibility: Bool = false
    var approveButtonVisibility: Bool = false
    var rejectButtonVisibility: Bool = false
    var reportButtonVisibility: Bool = false
    var saveToGBButtonVisibility: Bool = false
    var locCodeButtonVisibility: Bool = false
    var docIdButtonVisibility: Bool = false
    var flag: Bool = false
    var serialNumber: String = ""
    var itemNumber: String = ""
    var itemDesc: String = ""
    var changePrice: String = ""
    var originalPrice: String = ""
    var qty: String = ""
    var unitOfMeasurement: String = ""
    var lastYearOrderQty: String = ""
    var yearToDateOrderQty: String = ""
    var total: String = ""
    var requestDate: String = ""
    var deliveryDate: String = ""
    var orderId: String = ""
    var isItemChecked: Bool = true
    
    
    init(orderId: String, serialNumber: String, itemNumber: String, itemDesc: String, changePrice: String, originalPrice: String, qty: String, unitOfMeasurement: String, lastYearOrderQty: String, yearToDateOrderQty: String, total: String, requestDate: String, deliveryDate: String) {

        self.serialNumber = serialNumber
        self.itemNumber = itemNumber
        self.itemDesc = itemDesc
        self.changePrice = changePrice
        self.originalPrice  = originalPrice
        self.qty = qty
        self.unitOfMeasurement = unitOfMeasurement
        self.lastYearOrderQty = lastYearOrderQty
        self.yearToDateOrderQty = yearToDateOrderQty
        self.total = total
        self.requestDate = requestDate
        self.deliveryDate = deliveryDate
        self.orderId = orderId
    }
    
    init(isItemChecked: Bool) {
        self.isItemChecked = isItemChecked
    }
}

extension SalesOrderItemsDetailsModel: CustomStringConvertible{
    
    public var description: String{
        return """
        -----------------------------------------------
        serialNumber = \(serialNumber)
        itemNumber = \(itemNumber)
        itemDesc = \(itemDesc)
        changePrice = \(changePrice)
        originalPrice = \(originalPrice)
        qty = \(qty)
        unitOfMeasurement = \(unitOfMeasurement)
        lastYearOrderQty = \(lastYearOrderQty)
        yearToDateOrderQty = \(yearToDateOrderQty)
        total = \(total)
        requestDate = \(requestDate)
        deliveryDate = \(deliveryDate)
        orderId = \(orderId)
        isItemChecked = \(isItemChecked)
        -----------------------------------------------
        """
    }
}






