//
//  InboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 27/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxTableViewController: UITableViewController {

    let cellId = "trackingInboxCell"
    var arrayOfInboxGrid = [InboxGrid]()
    var listIndexSelected: Int = 0
    var categoryIndexSelected: Int = 0
    
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    let languageChosen = LoginViewController.languageChosen
    var navTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set title for nav bar
        setCustomNav(navItem: navigationItem, title: navTitle)
        
        //Geting array of inbox elements
        setupArrayOfInboxGrid()
        
        setViewAlignment()
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: set ups
    
    func setupArrayOfInboxGrid(){
        if let currentUserId = AuthServices.currentUserId{
            if let currentUserIdInt = Int(currentUserId){
                arrayOfInboxGrid = Login().SearchInbox(empid: currentUserIdInt, formid: String(listIndexSelected), drpdwnvalue: String(categoryIndexSelected), search: "", langid: LoginViewController.languageChosen)
            }
        }
    }

    // -- MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if arrayOfInboxGrid.count == 0 {
            emptyMessage(message: "No data", viewController: self, tableView: self.tableView)
        }
        return arrayOfInboxGrid.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? InboxTableViewCell {
            cell.contentView.backgroundColor = UIColor.clear
            
            let emp_id = arrayOfInboxGrid[indexPath.row].empid
            let emp_name = arrayOfInboxGrid[indexPath.row].empname
            let date = arrayOfInboxGrid[indexPath.row].date
            
            cell.empIdEnglish.text = getString(englishString: emp_id, arabicString: "رقم الموظف", language: languageChosen)
            cell.empNameEnglish.text = getString(englishString: emp_name, arabicString: "اسم الموظف", language: languageChosen)
            cell.dateEnglish.text = getString(englishString: date, arabicString: "التاريخ", language: languageChosen)
            cell.viewForm.setTitle(getString(englishString: "VIEW FORM", arabicString: "عرض النموذج", language: languageChosen), for: .normal)
            
            cell.empIdArabic.text = getString(englishString: "Emp ID:", arabicString: emp_id, language: languageChosen)
            cell.empNameArabic.text = getString(englishString: "Emp Name:", arabicString: emp_name, language: languageChosen)
            cell.dateArabic.text = getString(englishString: "Date:", arabicString: date, language: languageChosen)
            
            
            return cell
        }

        // Configure the cell...

        return UITableViewCell()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
