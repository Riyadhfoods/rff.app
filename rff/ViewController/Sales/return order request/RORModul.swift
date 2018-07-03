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
    
    func removeAll(){
        company = ""
        companyId = ""
        branch = ""
        branchId = ""
        salesperson = ""
        customer = ""
        supermarket = false
        store = ""
        city = ""
        salespersonstore = ""
        merchandiser = ""
        comment = ""
        invoicesArray = [InvoicesModel]()
    }
}

extension ROR: CustomStringConvertible{
    func getInvoicesArray() -> String {
        var text: String = ""
        for txt in invoicesArray{
            text += "invoiceDate: \(txt.invoiceDate)\n"
            text += "invoice: \(txt.invoice)\n"
            text += "item: \(txt.item)\n"
        }
        return text
    }
    
    public var description: String {
        return """
        emp_id: \(emp_id)
        company: \(company)
        companyId: \(companyId)
        branch: \(branch)
        branchId: \(branchId)
        salesperson: \(salesperson)
        customer: \(customer)
        supermarket: \(supermarket)
        store: \(store)
        city: \(city)
        salespersonstore: \(salespersonstore)
        merchandiser: \(merchandiser)
        comment: \(comment)
        items in array:
        \(getInvoicesArray())
        """
    }
}
