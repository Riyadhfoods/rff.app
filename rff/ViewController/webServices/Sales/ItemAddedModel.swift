//
//  ItemAddedModel.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 21/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

public class ItemAddedModel{
    public var Grid_ItemId : String = ""
    public var Grid_Desc : String = ""
    public var Grid_UOM : String = ""
    public var Grid_Qty : String = ""
    public var Grid_UnitPrice : String = ""
    public var Grid_TotalPrice : String = ""
    public var grid_error : String = ""
}

extension ItemAddedModel: CustomStringConvertible{
    public var description: String{
        return """
        Grid_ItemId = \(Grid_ItemId)
        Grid_Desc = \(Grid_Desc)
        Grid_UOM = \(Grid_UOM)
        Grid_Qty = \(Grid_Qty)
        Grid_UnitPrice = \(Grid_UnitPrice)
        Grid_TotalPrice = \(Grid_TotalPrice)
        Grid_TotalPrice = \(grid_error)
        \n
        """
    }
}

