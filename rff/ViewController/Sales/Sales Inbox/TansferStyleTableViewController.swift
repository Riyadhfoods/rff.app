//
//  TansferStyleTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class TansferStyleTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_transferStyle"
    let cellId_page = "cell_pageTransfer"
    var listIndexSelected: Int = 0
    var searchMessage: String = ""
    let salesWebservice: Sales = Sales()
    
    var salesArray: [SalesModel] = [SalesModel]()
    var newSalesArray: [SalesModel] = [SalesModel]()
    var preSalesArray: [SalesModel] = [SalesModel]()
    
    var urlString: [String] = [String]()
    var rowIndexSelected = 0
    
    let languageChosen = LoginViewController.languageChosen
    
    var currentIndex: Int = 0
    var previousIndex: Int = 0
    var totalRow = 0
    var currentRow = "0"
    var isSalesArrayEmpty = true
    
    var lastIndex: Int = 0
    var reminder: Int = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        setCustomNav(navItem: navigationItem, title: "Transfer List")
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        preSalesArray = salesArray
        
        if salesArray.count != 0 {
            isSalesArrayEmpty = false
            totalRow = salesArray[0].totalrows
            currentRow = salesArray[0].currentrows
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // -- MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isSalesArrayEmpty{
            emptyMessage(message: "No Data".localize(), viewController: self, tableView: tableView)
            return salesArray.count
        }
        return salesArray.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == salesArray.count {
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId_page, for: indexPath) as? TransferPagesCell{
                if isSalesArrayEmpty{
                    return UITableViewCell()
                }
                cell.firstPage.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
                cell.previousPage.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
                cell.nextPage.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
                cell.lastPage.addTarget(self, action: #selector(lastButtonTapped), for: .touchUpInside)
                
                cell.pageNum.text = "\(currentRow) " + "out of".localize() + " \(totalRow)"
                
                return cell
            }
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TransferStyleCell{
            
            let id = "\(salesArray[indexPath.row].ID)"
            let empCreated = salesArray[indexPath.row].EmpCreated
            let date = salesArray[indexPath.row].date
            let items = salesArray[indexPath.row].Items
            let status = salesArray[indexPath.row].Status
            let pendingBy = salesArray[indexPath.row].PendingBy
            let comment = salesArray[indexPath.row].Comment
            
            cell.idLabel.text = id
            cell.empCreatedLabel.text = empCreated
            cell.dateLabel.text = date
            cell.itemsLabel.text = items
            cell.statusLabel.text = status
            cell.pendingByLabel.text = pendingBy
            cell.commentLabel.text = comment
            
            cell.selectOutlet.addTarget(self, action: #selector(selectButtonTapped(sender:)), for: .touchUpInside)
            cell.selectOutlet.tag = indexPath.row
            
            urlString.append(salesArray[indexPath.row].URL)
            
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc function
    
    @objc func selectButtonTapped(sender: UIButton){
        rowIndexSelected = sender.tag
        performSegue(withIdentifier: "showTransferWeb", sender: nil)
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
        if let userId = AuthServices.currentUserId{
            newSalesArray = salesWebservice.GetSalesInbox(id: listIndexSelected, emp_id: userId, searchtext: searchMessage, index: currentIndex)
            if newSalesArray.count != 0{
                currentRow = newSalesArray[0].currentrows
                salesArray = newSalesArray
                tableView.reloadData()
                
                let indexPath = IndexPath(row: 0, section: 0)
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            } else {
                salesArray = preSalesArray
                return
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SalesInboxWebPageViewController{
            vc.urlString = self.urlString[rowIndexSelected]
        }
    }

}
