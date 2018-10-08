//
//  SalesReturnSearchTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol UpdateSalesReturnInfoDelegate {
    func updateSalesparson(newSalesperson: String, newSalespersonId: String)
    func updateCustomer(newCustomer: String, newCustomerId: String)
}

class SalesReturnSearchTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let searchFeature = SearchFeature.instance
    let cellId = "cell_salesReturnSearch"
    
    var salesPersons = [SalesPersonModul]()
    var customers = [CustomerModul]()
    var filteredsalesPersons = [SalesPersonModul]()
    var filteredcustomers = [CustomerModul]()
    
    var delegate: UpdateSalesReturnInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if !salesPersons.isEmpty{
            filteredsalesPersons = salesPersons.filter({( salesPerson : SalesPersonModul) -> Bool in
                return salesPerson.SalesPerson.lowercased().contains(searchText.lowercased())
            })
        } else if !customers.isEmpty{
            filteredcustomers = customers.filter({( customer : CustomerModul) -> Bool in
                return customer.CustomerName.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension SalesReturnSearchTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !salesPersons.isEmpty{
            if searchFeature.isFiltering() { return filteredsalesPersons.count }
            return salesPersons.count
        } else if !customers.isEmpty{
            if searchFeature.isFiltering() { return filteredcustomers.count }
            return customers.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let textContent: String
        if !salesPersons.isEmpty{
            textContent = searchFeature.isFiltering() ?
                filteredsalesPersons[indexPath.row].SalesPerson :
                salesPersons[indexPath.row].SalesPerson
        } else {
            textContent = searchFeature.isFiltering() ? filteredcustomers[indexPath.row].CustomerName : customers[indexPath.row].CustomerName
        }
        
        cell.textLabel?.text = textContent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let isFiltering = searchFeature.isFiltering()
        
        if !salesPersons.isEmpty{
            
            let salesPersonNameSelected = isFiltering ?
                filteredsalesPersons[row].SalesPerson :
                salesPersons[row].SalesPerson
            let salesPersonIdSelected = isFiltering ?
                filteredsalesPersons[row].SalesPersonId :
                salesPersons[row].SalesPersonId
            if let delegate = delegate{delegate.updateSalesparson(newSalesperson: salesPersonNameSelected, newSalespersonId: salesPersonIdSelected)}
            
        } else if !customers.isEmpty{
            
            let customerNameSelected = isFiltering ?
                filteredcustomers[row].CustomerName :
                
                customers[row].CustomerName
            let customerIdSelected = isFiltering ?
                filteredcustomers[row].CustomerId :
                customers[row].CustomerId
            if let delegate = delegate{delegate.updateCustomer(newCustomer: customerNameSelected, newCustomerId: customerIdSelected)}
            
        }
        
        navigationController?.popViewController(animated: true)
    }

}

extension SalesReturnSearchTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
        }
    }
}
