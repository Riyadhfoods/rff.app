//
//  SearchCollectionViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

protocol UpdateCollectionSlsAndCustomerValueDelegate {
    func updateSalesPerson(name: String, id: String)
    func updateCustomer(name: String, id: String)
}

class SearchCollectionTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let searchFeature = SearchFeature.instance
    let cellId = "cell_salesCollectionSearch"
    
    var salesPersons = [CollSalesPersonModul]()
    var customers = [CollCustomerModul]()
    var filteredsalesPersons = [CollSalesPersonModul]()
    var filteredcustomers = [CollCustomerModul]()
    
    var delegate: UpdateCollectionSlsAndCustomerValueDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchBar()
    }
    
    func setSearchBar(){
        searchFeature.setSearchController(Target: self, tableView: tableView, searchController: searchController, searchText: "Search")
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if !salesPersons.isEmpty{
            filteredsalesPersons = salesPersons.filter({( salesPerson : CollSalesPersonModul) -> Bool in
                return salesPerson.SalespersonName.lowercased().contains(searchText.lowercased())
            })
        } else if !customers.isEmpty{
            filteredcustomers = customers.filter({( customer : CollCustomerModul) -> Bool in
                return customer.CustomerName.lowercased().contains(searchText.lowercased())
            })
        }
        
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension SearchCollectionTableViewController{
    
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
                filteredsalesPersons[indexPath.row].SalespersonName :
                salesPersons[indexPath.row].SalespersonName
        } else {
            textContent = searchFeature.isFiltering() ?
                filteredcustomers[indexPath.row].CustomerName :
                customers[indexPath.row].CustomerName
        }

        cell.textLabel?.text = textContent
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let isFiltering = searchFeature.isFiltering()
        
        if !salesPersons.isEmpty{

            let salesPersonNameSelected = isFiltering ?
                filteredsalesPersons[row].SalespersonName :
                salesPersons[row].SalespersonName
            let salesPersonIdSelected = isFiltering ?
                filteredsalesPersons[row].SalesPersonId :
                salesPersons[row].SalesPersonId
            if let delegate = delegate{delegate.updateSalesPerson(name: salesPersonNameSelected, id: salesPersonIdSelected)}

        } else if !customers.isEmpty{

            let customerNameSelected = isFiltering ?
                filteredcustomers[row].CustomerName :
                customers[row].CustomerName
            let customerIdSelected = isFiltering ?
                filteredcustomers[row].CustomerId :
                customers[row].CustomerId
            if let delegate = delegate{delegate.updateCustomer(name: customerNameSelected, id: customerIdSelected)}

        }
        
        navigationController?.popViewController(animated: true)
    }
    
}

extension SearchCollectionTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
        }
    }
}
