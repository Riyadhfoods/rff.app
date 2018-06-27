//
//  ReturnOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnOrderRequestsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var showCompanyPickerView: UITextField!
    @IBOutlet weak var returnDateTextField: UITextField!
    @IBOutlet weak var salesPersonTextField: UITextField!
    @IBOutlet weak var showSalesPersonPickerView: UITextField!
    @IBOutlet weak var customerTextField: UITextField!
    @IBOutlet weak var showCustomerPickerView: UITextField!
    @IBOutlet weak var branchTextField: UITextField!
    @IBOutlet weak var showBranchPickerView: UITextField!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize

    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: Set ups
    
    
    
    // -- MARK: objc functions
    
    
    
    // -- Mark: Picker view data source
    
    
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
}
