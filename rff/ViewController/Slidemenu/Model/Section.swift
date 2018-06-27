//
//  Section.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 22/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

struct Section {
    var name: String!
    var items: [String]!
    var isExpanded: Bool!
    
    init(name: String, items: [String], isExpanded: Bool = false) {
        self.name = name
        self.items = items
        self.isExpanded = isExpanded
    }
}
