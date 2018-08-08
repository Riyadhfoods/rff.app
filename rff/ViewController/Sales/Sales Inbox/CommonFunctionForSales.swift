//
//  CommonFunctionForSales.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 01/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
struct updateArrayValues{
    var currentArray: [SalesInboxModul]
    var currentRows: String
}

class CommonFunctionsForSales{
    static let instance = CommonFunctionsForSales()
    let salesWebservice = SalesInboxService.instance
    
    var receivedNewArray: (([SalesInboxModul]) -> ())?
    var noNewArray: (() -> ())?
    
    func getNewArray(id: Int, search: String, index: Int){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let newSalesArray = self.salesWebservice.GetSalesInbox(id: id, emp_id: AuthServices.currentUserId, searchtext: search, index: index)
            self.updateArray(newArray: newSalesArray)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func updateArray(newArray: [SalesInboxModul]){
        if newArray.count != 0{
            self.receivedNewArray?(newArray)
        } else {
            self.noNewArray?()
            return
        }
    }
    
    func updatingTableViewForInboxSales(tableView: UITableView){
        tableView.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
