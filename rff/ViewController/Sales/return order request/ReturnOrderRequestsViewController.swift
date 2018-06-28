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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    var companyNameArray = [String]()
    var salesPersonNameArray = [String]()
    var customerNameArray = [String]()
    var branchNameArray = [String]()
    
    var companyPickerView = UIPickerView()
    var salesPersonPickerView = UIPickerView()
    var customerPickerView = UIPickerView()
    var branchPickerView = UIPickerView()
    var pickerView = UIPickerView()
    var datePicker = UIDatePicker()
    let currentDate = Date()
    var date: String = ""

    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showCompanyPickerView.tintColor = .clear
        returnDateTextField.tintColor = .clear
        showSalesPersonPickerView.tintColor = .clear
        showCustomerPickerView.tintColor = .clear
        showBranchPickerView.tintColor = .clear
        
        setupArrays()
        setupPickerView()
        setupDatePicker()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialValues()
    }
    
    // -- MARK: Set ups
    
    func setupArrays(){
        companyNameArray = ["Select company"]
        salesPersonNameArray = ["Select sales person"]
        customerNameArray = ["Select customer"]
        branchNameArray = ["Select branch"]
    }
    
    func initialValues(){
        companyTextField.text = companyNameArray[0]
        salesPersonTextField.text = salesPersonNameArray[0]
        customerTextField.text = customerNameArray[0]
        branchTextField.text = branchNameArray[0]
    }
    
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showCompanyPickerView, pickerview: companyPickerView, viewController: self, cancelSelector: #selector(doneClick), doneSelector: #selector(cancelClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerView, pickerview: salesPersonPickerView, viewController: self, cancelSelector: #selector(doneClick), doneSelector: #selector(cancelClick))
        PickerviewAction().showPickView(txtfield: showCustomerPickerView, pickerview: customerPickerView, viewController: self, cancelSelector: #selector(doneClick), doneSelector: #selector(cancelClick))
        PickerviewAction().showPickView(txtfield: showBranchPickerView, pickerview: branchPickerView, viewController: self, cancelSelector: #selector(doneClick), doneSelector: #selector(cancelClick))
    }
    
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: returnDateTextField, datePicker: datePicker, title: "Return Date", viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showInvoice", sender: nil)
    }
}

extension ReturnOrderRequestsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerView == companyPickerView{
            showCompanyPickerView.resignFirstResponder()
        } else if pickerView == salesPersonPickerView{
            showSalesPersonPickerView.resignFirstResponder()
        } else if pickerView == customerPickerView{
            showCustomerPickerView.resignFirstResponder()
        } else {
            showBranchPickerView.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerView == companyPickerView{
            showCompanyPickerView.resignFirstResponder()
        } else if pickerView == salesPersonPickerView{
            showSalesPersonPickerView.resignFirstResponder()
        } else if pickerView == customerPickerView{
            showCustomerPickerView.resignFirstResponder()
        } else {
            showBranchPickerView.resignFirstResponder()
        }
    }

    @objc func handleDatePicker(sender: UIDatePicker){
        date = getStringDate(date: sender.date)
        returnDateTextField.text = getStringDate(date: sender.date)
    }
    
    @objc func datePickerDoneClick(){
        if date.isEmpty{
            returnDateTextField.text = getStringDate(date: currentDate)
        }
        returnDateTextField.resignFirstResponder()
    }
    
    func getStringDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // -- Mark: Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == companyPickerView{
            return companyNameArray.count
        } else if pickerView == salesPersonPickerView{
            return salesPersonNameArray.count
        } else if pickerView == customerPickerView{
            return customerNameArray.count
        } else {
            return branchNameArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerView = pickerView
        if pickerView == companyPickerView{
            return companyNameArray[row]
        } else if pickerView == salesPersonPickerView{
            return salesPersonNameArray[row]
        } else if pickerView == customerPickerView{
            return customerNameArray[row]
        } else {
            return branchNameArray[row]
        }
    }
    
}

extension ReturnOrderRequestsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 65, right: 0)
            self.scrollView.contentInset = contentInset
        }, onHide: { _ in
            self.scrollView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}
