//
//  JannatStyleTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnStyleTableViewController: UITableViewController {
    
    // -- MARK: Variables
    
    let cellId = "cell_returnStyle"
    let cellId_page = "cell_pageReturn"
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
        setCustomNav(navItem: navigationItem, title: "RFC Return List")
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        currentUserId = AuthServices.currentUserId
        
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
    
    func getPageNumber() -> String{
        var txt = ""
        let lastPage = (totalRow).quotientAndRemainder(dividingBy: 10).quotient
        
        let currentPage = currentRows.split(separator: "-")[0]
        
        if totalRow < 10 {
            txt = "\(currentPage)-\(salesArray.count) " + "out of".localize() + " \(totalRow)"
        } else if currentIndex == lastPage {
            txt = "\(currentPage)-\(totalRow) " + "out of".localize() + " \(totalRow)"
        } else {  txt = "\(currentRows) " + "out of".localize() + " \(totalRow)" }
        
        return txt
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == salesArray.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId_page, for: indexPath) as? ReturnPagesCell{
                cell.firstPage.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
                cell.previousPage.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                cell.nextPage.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
                cell.lastPage.addTarget(self, action: #selector(lastButtonTapped), for: .touchUpInside)
                
                cell.pageNum.text = getPageNumber()
                    //"\(currentRows) " + "out of".localize() + " \(totalRow)"
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ReturnStyleCell{
                
                let id = "\(salesArray[indexPath.row].ID)"
                let empCreated = salesArray[indexPath.row].EmpCreated
                let items = salesArray[indexPath.row].Items
                let reqDate = salesArray[indexPath.row].RequestDate
                let rtnDate = salesArray[indexPath.row].ReturnDate
                let status = salesArray[indexPath.row].Status
                let pendingBy = salesArray[indexPath.row].PendingBy
                let comment = salesArray[indexPath.row].Comment
                
                cell.idLabel.text = id
                cell.empCreatedLabel.text = empCreated
                cell.itemsLabel.text = items
                cell.requestDateLabel.text = reqDate
                cell.returnDateLabel.text = rtnDate
                cell.statusLabel.text = status
                cell.pendingByLabel.text = pendingBy
                cell.commentLabel.text = comment == "" ? AppDelegate.noComment : comment
                
                cell.viewOutlet.addTarget(self, action: #selector(viewButtonTapped(sender:)), for: .touchUpInside)
                cell.viewOutlet.tag = indexPath.row
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc function
 
    @objc func viewButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showDetails", sender: nil)
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
        if segue.identifier == "showDetails"{
            if let vc = segue.destination as? SalesDetailsViewController{
                vc.empId = salesArray[rowIndexSelected].EmpCreated
                vc.returnId = "\(salesArray[rowIndexSelected].ID)"
                vc.barTitle = "Sales Return Order"
            }
        }
    }
}
