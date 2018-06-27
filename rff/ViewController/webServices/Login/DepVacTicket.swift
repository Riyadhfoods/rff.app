//
//  File.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

public class DepVacTicket{
    public var RequireVisa : Int = 0
    public var Ticket : String = ""
    public var DependentName : String = ""
    public var BirthDate : String = ""
    public var Age : String = ""
}

extension DepVacTicket: CustomStringConvertible{
    public var description: String{
        return """
        RequireVisa = \(RequireVisa)
        Ticket = \(Ticket)
        DependentName = \(DependentName)
        BirthDate = \(BirthDate)
        Age = \(Age)
        """
    }
}
