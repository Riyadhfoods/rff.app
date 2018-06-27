//
//  SalesRequest.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 10/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

public struct SalesRequest{
    public var company: String = ""
    public var branch: String = ""
    public var docId: String = ""
    public var locCode: String = ""
    public var salesperson: String = ""
    public var customer: String = ""
    public var deliveryDate: String = ""
    
    // 0 --> No, 1 --> Yes
    public var isSuperMartket: Int = 0
    public var isOffer: Int = 0
    
    public var store: String = ""
    public var city: String = ""
    public var salesPerson: String = ""
    public var merchandiser: String = ""
    public var creditLimit: String = ""
    public var TotalDue: String = ""
    public var upTo31: String = ""
    public var upTo60: String = ""
    public var upTo90: String = ""
    public var upTo120: String = ""
    public var above120: String = ""
    public var status: String = ""
    public var item: String = ""
    public var unoitOfMeasure: String = ""
    public var qty: String = ""
    
    public var itemsArray: [String] = [String]()
}
