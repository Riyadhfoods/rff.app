//
//  SearchFeature.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

protocol UpdateEmpTextDelegate{
    func updateEmp(newName: String, newId: String)
}

class SearchFeature{
    static let instance = SearchFeature()
    
    var searchController: UISearchController?
    
    func setSearchController(Target vc: UIViewController, tableView: UITableView, searchController sc: UISearchController, searchText txt: String){
        sc.hidesNavigationBarDuringPresentation = false
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.sizeToFit()
        sc.searchBar.placeholder = txt
        sc.searchResultsUpdater = vc as? UISearchResultsUpdating
        tableView.tableHeaderView = sc.searchBar
        tableView.keyboardDismissMode = .onDrag
        
        self.searchController = sc
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        if let sc = searchController{
            return sc.searchBar.text?.isEmpty ?? true
        }
        return true
    }
    
    func isFiltering() -> Bool {
        if let sc = searchController{
            return sc.isActive && !searchBarIsEmpty()
        }
        return false
    }
}
