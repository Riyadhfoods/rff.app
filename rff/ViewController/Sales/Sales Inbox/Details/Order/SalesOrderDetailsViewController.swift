//
//  SalesOrderDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesOrderDetailsViewController: UIViewController {

    // -- MARK: Outlets
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var salesPerson: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let cellId = ""
    let cellTitleArray = [
        "Item(s) Details".localize(),
        "Cutomer Credit Details".localize(),
        "User Comment".localize(),
        "Work Flow".localize()]
    
    var checkSalesApprovalArray: [SalesModel] = [SalesModel]()
    var itemsDetailsArray = [SalesModel]()
    var customerCreditDetailsArray = [SalesModel]()
    var userCommentArray = [SalesModel]()
    var workFlowArray = [SalesModel]()
    
    var orderId = ""
    var userId = ""
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SalesOrderDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesOrderDetails", for: indexPath) as? SalesOrderDetailsCell{
            
            cell.textLabel?.text = cellTitleArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}









