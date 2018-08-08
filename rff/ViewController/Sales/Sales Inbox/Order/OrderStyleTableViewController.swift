//
//  OrderStyleTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class OrderStyleTableViewController: UITableViewController {
    
    // -- MARK: Variables
    
    let cellId = "cell_orderStyle"
    let cellId_pages = "cell_pages"
    var listIndexSelected: Int = 0
    var searchMessage: String = ""
    let salesWebservice = SalesInboxService.instance
    let commonFunction = CommonFunctionsForSales.instance
    
    var salesArray: [SalesInboxModul] = [SalesInboxModul]()
    
    var urlString: [String] = [String]()
    var rowIndexSelected = 0
    
    var currentIndex: Int = 0
    var previousIndex: Int = 0
    var totalRow = 0
    var currentRows = "0"
    var isSalesArrayEmpty = true
    
    var lastIndex: Int = 0
    var reminder: Int = 0
    var currentUserId = ""
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        setCustomNav(navItem: navigationItem, title: "RFC Order List")
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        if salesArray.count != 0 {
            isSalesArrayEmpty = false
            totalRow = salesArray[0].totalrows
            currentRows = salesArray[0].currentrows
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // -- MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: tableView, isEmpty: isSalesArrayEmpty)
        if isSalesArrayEmpty{
            return 0
        }
        return salesArray.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == salesArray.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId_pages, for: indexPath) as? OrderPagesCell{
                cell.firstPage.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
                cell.previousPage.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                cell.nextPage.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
                cell.lastPage.addTarget(self, action: #selector(lastButtonTapped), for: .touchUpInside)
                
                cell.pageNum.text = "\(currentRows) " + "out of".localize() + " \(totalRow)"
                return cell
            }
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? OrderStyleCell{
            print(indexPath.row)
            let id = "\(salesArray[indexPath.row].ID)"
            let empCreated = salesArray[indexPath.row].EmpCreated
            let date = salesArray[indexPath.row].Date
            let items = salesArray[indexPath.row].Items
            let status = salesArray[indexPath.row].Status
            let pendingBy = salesArray[indexPath.row].PendingBy
            let comment = salesArray[indexPath.row].Comment
            let customerName = salesArray[indexPath.row].CustomerName
            
            cell.idLabel.text = id
            cell.empCreatedLabel.text = empCreated
            cell.custNameLabel.text = customerName
            cell.dateLabel.text = date
            cell.itemsLabel.text = items
            cell.statusLabel.text = status
            cell.pendingByLabel.text = pendingBy
            cell.commentLabel.text = comment == "" ? AppDelegate.noComment : comment
            
            cell.viewOutlet.addTarget(self, action: #selector(viewButtonTapped(sender:)), for: .touchUpInside)
            cell.viewOutlet.tag = indexPath.row
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc function
    
    @objc func viewButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showOrderDetails", sender: nil)
    }
    
    @objc func firstButtonTapped(){
        if currentIndex != 0{
            currentIndex = 0
            updateTableView(currentIndex: currentIndex)
        }
    }
    
    @objc func backButtonTapped(){
        if currentIndex > 0{
            currentIndex -= 1
            updateTableView(currentIndex: currentIndex)
        }
    }
    
    @objc func forwardButtonTapped(){
        currentIndex += 1
        updateTableView(currentIndex: currentIndex)
    }
    
    @objc func lastButtonTapped(){
        (lastIndex, reminder) = (salesArray[0].totalrows).quotientAndRemainder(dividingBy: 10)
        currentIndex = lastIndex
        
        updateTableView(currentIndex: currentIndex)
    }
    
    func updateTableView(currentIndex: Int){
        let preSalesArray = salesArray
        commonFunction.getNewArray(id: listIndexSelected, search: searchMessage, index: currentIndex)
        commonFunction.receivedNewArray = {(newArray) in
            self.salesArray = newArray
            self.currentRows = newArray[0].currentrows
            self.commonFunction.updatingTableViewForInboxSales(tableView: self.tableView)
        }
        commonFunction.noNewArray = {() in
            self.salesArray = preSalesArray
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderDetails"{
            if let vc = segue.destination as? SalesOrderDetailsViewController{
                vc.orderId = "\(salesArray[rowIndexSelected].ID)"
            }
        }
    }
}












