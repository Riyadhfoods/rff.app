//
//  SalesOrderSearchTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol UpdateSalesOrderInfoDelegate {
    func updateLocCode(newLocCode: String)
    func updateSalesparson(newSalesperson: String)
    func updateCustomer(newCustomer: String)
    func updateitem(newItem: String)
}

class SalesOrderSearchTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let searchFeature = SearchFeature.instance
    let cellId = "cell_salesOrderSearch"
    
    var LocCodes = [LocCodeModul]()
    var salesPersons = [SalesPersonModul]()
    var customers = [CustomerModul]()
    var items = [ItemSalesModel]()
    
    var filteredLocCodes = [LocCodeModul]()
    var filteredsalesPersons = [SalesPersonModul]()
    var filteredcustomers = [CustomerModul]()
    var filtereditems = [ItemSalesModel]()
    
    
    var delegate: UpdateSalesOrderInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let delegate = delegate{delegate.updateitem(newItem: "")}
        setSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setSearchBar(){
        searchFeature.setSearchController(Target: self, tableView: tableView, searchController: searchController, searchText: "Search employees")
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if !LocCodes.isEmpty{
            filteredLocCodes = LocCodes.filter({( locCode : LocCodeModul) -> Bool in
                return locCode.LocationCode.lowercased().contains(searchText.lowercased())
            })
        } else if !salesPersons.isEmpty{
            filteredsalesPersons = salesPersons.filter({( salesPerson : SalesPersonModul) -> Bool in
                return salesPerson.SalesPerson.lowercased().contains(searchText.lowercased())
            })
        } else if !customers.isEmpty{
            filteredcustomers = customers.filter({( customer : CustomerModul) -> Bool in
                return customer.CustomerName.lowercased().contains(searchText.lowercased())
            })
        } else if !items.isEmpty{
            filtereditems = items.filter({( item : ItemSalesModel) -> Bool in
                return item.DrpItems.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
}

    // MARK: - Table view data source

extension SalesOrderSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !LocCodes.isEmpty{
            if searchFeature.isFiltering() { return filteredLocCodes.count }
            return LocCodes.count
        } else if !salesPersons.isEmpty{
            if searchFeature.isFiltering() { return filteredsalesPersons.count }
            return salesPersons.count
        } else if !customers.isEmpty{
            if searchFeature.isFiltering() { return filteredcustomers.count }
            return customers.count
        } else if !items.isEmpty{
            if searchFeature.isFiltering() { return filtereditems.count }
            return items.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let textContent: String
        if !LocCodes.isEmpty{
            textContent = searchFeature.isFiltering() ?
                filteredLocCodes[indexPath.row].LocationCode :
                LocCodes[indexPath.row].LocationCode
        } else if !salesPersons.isEmpty{
            textContent = searchFeature.isFiltering() ?
                filteredsalesPersons[indexPath.row].SalesPerson :
                salesPersons[indexPath.row].SalesPerson
        } else if !customers.isEmpty{
            textContent = searchFeature.isFiltering() ? filteredcustomers[indexPath.row].CustomerName : customers[indexPath.row].CustomerName
        } else {
            textContent = searchFeature.isFiltering() ? filtereditems[indexPath.row].DrpItems : items[indexPath.row].DrpItems
        }
        
        cell.textLabel?.text = textContent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let isFiltering = searchFeature.isFiltering()
        
        if !LocCodes.isEmpty{
            
            let locCodeSelected = isFiltering ?
                filteredLocCodes[row].LocationCode :
                LocCodes[row].LocationCode
            if let delegate = delegate{delegate.updateLocCode(newLocCode: locCodeSelected)}
            
        } else if !salesPersons.isEmpty{
            
            let salesPersonSelected = isFiltering ?
                filteredsalesPersons[row].SalesPerson :
                salesPersons[row].SalesPerson
            if let delegate = delegate{delegate.updateSalesparson(newSalesperson: salesPersonSelected)}
            
        } else if !customers.isEmpty{
            
            let customerSelected = isFiltering ?
                filteredcustomers[row].CustomerName :
                customers[row].CustomerName
            if let delegate = delegate{delegate.updateCustomer(newCustomer: customerSelected)}
            
        } else if !items.isEmpty{
            
            let itemSelected = isFiltering ?
                filtereditems[row].DrpItems :
                items[row].DrpItems
            if let delegate = delegate{delegate.updateitem(newItem: itemSelected)}
            
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension SalesOrderSearchTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
        }
    }
}














