//
//  AddReturnInvoiceViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AddReturnInvoiceViewController: UIViewController {

    // -- MARK: IBOutlets
    @IBOutlet weak var invoiceDateTextField: UITextField!
    @IBOutlet weak var invoiceTextField: UITextField!
    @IBOutlet weak var showInvoicePickerView: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var showItemPickerView: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    
    // -- MARK: Variables
    
    var invoiceDatePicker: UIDatePicker = UIDatePicker()
    var invoicePickerView: UIPickerView = UIPickerView()
    var itemPickerView: UIPickerView = UIPickerView()
    var pickerview: UIPickerView = UIPickerView()
    var invoiceArray: [String] = [String]()
    var itemArray: [String] = [String]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        invoiceArray = ["aaaaa1", "aaaaaaa2"]
        itemArray = ["bbbbbb1", "bbbbb2", "bbbbbb3"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    //func set
    
    // -- MARK: objc functions
    
    
    
    // -- MARK: IBActions

    @IBAction func showItemButtonTapped(_ sender: Any) {
    }
}
