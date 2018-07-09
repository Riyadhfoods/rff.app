//
//  RORModul.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 01/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
class ROR {
    var emp_id: String = ""
    var company: String = ""
    var companyId: String = ""
    var returnDate: String = ""
    var branch: String = ""
    var branchId: String = ""
    var salesperson: String = ""
    var salespersonId: String = ""
    var customer: String = ""
    var customerId: String = ""
    var supermarket: Bool = false
    var store: String = ""
    var city: String = ""
    var salespersonstore: String = ""
    var merchandiser: String = ""
    var comment: String = ""
    var invoicesArray = [InvoicesModel]()
    var itemsarrayFromWS = [InvoiceItemModel]()
    
    var isSendReturnSalesRequestCompleted = false
    var isStoreArrayNotEmptyAndStoreSelectionEmpty: Bool = false
    
    func setDefaultValues(){
        company = ""
        companyId = ""
        returnDate = ""
        branch = ""
        branchId = ""
        salesperson = ""
        salespersonId = ""
        customer = ""
        customerId = ""
        supermarket = false
        store = ""
        city = ""
        salespersonstore = ""
        merchandiser = ""
        comment = ""
        invoicesArray = [InvoicesModel]()
        itemsarrayFromWS = [InvoiceItemModel]()
        isStoreArrayNotEmptyAndStoreSelectionEmpty = false
    }
    
    func setStoreDefaultValues(){
        store = ""
        city = ""
        salespersonstore = ""
        merchandiser = ""
    }
    
    func removeItemAndInveDetails(at row: Int){
        invoicesArray.remove(at: row)
        itemsarrayFromWS.remove(at: row)
    }
}

extension ROR: CustomStringConvertible{
    func getInvoicesArray() -> String {
        var text: String = "\n"
        for txt in invoicesArray{
            text += "serialNumber: \(txt.serialNumber)\n"
            text += "invoiceDate: \(txt.invoiceDate)\n"
            text += "invoice: \(txt.invoice)\n"
            text += "item: \(txt.item)\n"
        }
        return text
    }
    
    func getInvoiceItemsArray() -> String {
        var text: String = "\n"
        for txt in itemsarrayFromWS{
            text += "serialNumber: \(txt.serialNumberFromWS)\n"
            text += "itemNumber: \(txt.itemNumberFromWS)\n"
            text += "invoiceNumber: \(txt.invoiceNumberFromWS)\n"
            text += "desc: \(txt.desc)\n"
            text += "unof: \(txt.uofm)\n"
            text += "qty: \(txt.qty)\n"
            text += "avgPrice: \(txt.avgPrice)\n"
            text += "totalPrice: \(txt.totalPrice)\n"
            text += "expiredDate: \(txt.expiredDate)\n"
            text += "expiredDate: \(txt.invoiceDateFromWS)\n"
            text += "returnType: \(txt.returnType)\n\n"
        }
        return text
    }
    
    public var description: String {
        return """
        emp_id: \(emp_id)
        company: \(company)
        companyId: \(companyId)
        returnDate: \(returnDate)
        branch: \(branch)
        branchId: \(branchId)
        salesperson: \(salesperson)
        salespersonId: \(salespersonId)
        customer: \(customer)
        customerId: \(customerId)
        supermarket: \(supermarket)
        store: \(store)
        city: \(city)
        salespersonstore: \(salespersonstore)
        merchandiser: \(merchandiser)
        comment: \(comment)
        items in array:
        \(getInvoicesArray())
        \(getInvoiceItemsArray())
        """
    }
}
