//
//  searchEmpDeledateVacTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 01/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class searchEmpDeledateVacTableViewController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let searchFeature = SearchFeature.instance
    
    let cellId = "cell_empDelegateForVac"
    var emps = [EmpInfoModul]()
    var filteredEmps = [EmpInfoModul]()
    var delegate: UpdateEmpTextDelegate?
    
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
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredEmps = emps.filter({( emp : EmpInfoModul) -> Bool in
            return emp.Emp_Ename.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension searchEmpDeledateVacTableViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchFeature.isFiltering() { return filteredEmps.count }
        return emps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let emp = searchFeature.isFiltering() ? filteredEmps[indexPath.row].Emp_Ename : emps[indexPath.row].Emp_Ename
        cell.textLabel?.text = emp
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let empName = searchFeature.isFiltering() ? filteredEmps[indexPath.row].Emp_Ename : emps[indexPath.row].Emp_Ename
        let empId = searchFeature.isFiltering() ? filteredEmps[indexPath.row].Emp_Id : emps[indexPath.row].Emp_Id
        print("Search view -> Emp name = \(empName)\nEmp id = \(empId)")
        
        if let delegate = delegate{
            delegate.updateEmp(newName: empName, newId: "\(empId)")
        }
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Updating Search Resault

extension searchEmpDeledateVacTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
        }
    }
}













