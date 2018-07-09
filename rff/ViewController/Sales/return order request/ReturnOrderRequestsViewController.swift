//
//  ReturnOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var returnOrderRequestDetails = ROR()

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
    @IBOutlet weak var selectorSuperMarketYes: UIView!
    @IBOutlet weak var selectorSuperMarketNo: UIView!
    @IBOutlet weak var innerSelectorSuperMarketYes: UIView!
    @IBOutlet weak var innerSelectorSuperMarketNo: UIView!
    @IBOutlet weak var superMarketYesButton: UIButton!
    @IBOutlet weak var superMarketNoButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    var companyPickerView = UIPickerView()
    var salesPersonPickerView = UIPickerView()
    var customerPickerView = UIPickerView()
    var branchPickerView = UIPickerView()
    var pickerView = UIPickerView()
    var companyRow = 0
    var salesPersonRow = 0
    var customerRow = 0
    var branchRow = 0
    
    var datePicker = UIDatePicker()
    let currentDate = Date()
    var date: String = ""
    
    let webservice = Sales()
    var companyArray = [SalesModel]()
    var companyNamesArray = [String]()
    var companyIdArray = [String]()
    var salespersonArray = [SalesModel]()
    var salesPersonNamesArray = [String]()
    var salesPersonIdArray = [String]()
    var customerArray = [SalesModel]()
    var customerNamesArray = [String]()
    var customerIdArray = [String]()
    var branchArray = [SalesModel]()
    var branchNamesArray = [String]()
    var branchIdArray = [String]()

    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        activityIndicator.startAnimating()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        returnOrderRequestDetails.itemsarrayFromWS.removeAll()
        returnOrderRequestDetails.invoicesArray.removeAll()
        if companyArray.isEmpty && salespersonArray.isEmpty && branchArray.isEmpty{
            setupArrays()
        }
        
        if returnOrderRequestDetails.isSendReturnSalesRequestCompleted{
            initialValues()
            returnDateTextField.text = ""
            returnOrderRequestDetails.isSendReturnSalesRequestCompleted = false
        }
        activityIndicator.stopAnimating()
    }
    
    // -- MARK: Set ups
    
    func setUpSalesOrderData(){
        companyArray = webservice.BindSalesOrderCompany()
        salespersonArray = webservice.BindSalesReturnSalesPerson()
        branchArray = webservice.BindSalesOrderBranches()
    }
    
    func setUpViews(){
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showCompanyPickerView.tintColor = .clear
        returnDateTextField.tintColor = .clear
        showSalesPersonPickerView.tintColor = .clear
        showCustomerPickerView.tintColor = .clear
        showBranchPickerView.tintColor = .clear
        
        companyNamesArray = ["Select company"]
        companyIdArray = [" "]
        salesPersonNamesArray = ["Select sales person"]
        salesPersonIdArray = [" "]
        customerNamesArray = ["Select customer"]
        customerIdArray = [" "]
        branchNamesArray = ["Select branch"]
        branchIdArray = [" "]
        
        setupPickerView()
        setupDatePicker()
        setUpSelectors()
    }
    
    func setupArrays(){
        setUpSalesOrderData()
        for company in companyArray{
            companyNamesArray.append(company.EName)
            companyIdArray.append(company.Comp_ID)
        }
        
        for salesperson in salespersonArray{
            salesPersonNamesArray.append(salesperson.SalesPerson)
            salesPersonIdArray.append(salesperson.SalesPersonId)
        }
        
        for branch in branchArray{
            branchNamesArray.append(branch.Branch)
            branchIdArray.append(branch.AccountEmp)
        }
        initialValues()
    }
    
    func initialValues(){
        if !companyArray.isEmpty {
            companyTextField.text = companyNamesArray[1]
            returnOrderRequestDetails.company = companyNamesArray[1]
            returnOrderRequestDetails.companyId = companyIdArray[1]
        } else { companyTextField.text = companyNamesArray[0] }
        salesPersonTextField.text = salesPersonNamesArray[0]
        customerTextField.text = customerNamesArray[0]
        branchTextField.text = branchNamesArray[0]
    }
    
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showCompanyPickerView, pickerview: companyPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerView, pickerview: salesPersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showCustomerPickerView, pickerview: customerPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showBranchPickerView, pickerview: branchPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: returnDateTextField, datePicker: datePicker, title: "Return Date", viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    func setUpSelectors(){
        let cornerRadiusValueHolder: CGFloat = 12
        let cornerRadiusValueInner: CGFloat = 11
        let cornerRadiusValueView: CGFloat = 9
        
        selectorSuperMarketYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorSuperMarketNo.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorSuperMarketYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorSuperMarketNo.layer.cornerRadius = cornerRadiusValueInner
        
        superMarketYesButton.layer.cornerRadius = cornerRadiusValueView
        superMarketYesButton.backgroundColor = .white
        superMarketNoButton.layer.cornerRadius = cornerRadiusValueView
        superMarketNoButton.backgroundColor = mainBackgroundColor
    }
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let userId = AuthServices.currentUserId{
            returnOrderRequestDetails.emp_id = userId
        }
        if companyTextField.text == companyNamesArray[0] ||
            returnDateTextField.text == "" ||
            salesPersonTextField.text == salesPersonNamesArray[0] ||
            customerTextField.text == customerNamesArray[0] ||
            branchTextField.text == branchNamesArray[0]
            {
            AlertMessage().showAlertMessage(alertTitle: "Alert", alertMessage: "You did not fill the fields", actionTitle: nil, onAction: nil, cancelAction: "OK", self)
        } else {
            performSegue(withIdentifier: "showInvoice", sender: nil)
        }
    }
    
    @IBAction func superMarketYesButtonTapped(_ sender: Any) {
        superMarketYesButton.backgroundColor = mainBackgroundColor
        superMarketNoButton.backgroundColor = .white
        
        returnOrderRequestDetails.supermarket = true
    }
    
    @IBAction func superMarketNoButtonTapped(_ sender: Any) {
        superMarketYesButton.backgroundColor = .white
        superMarketNoButton.backgroundColor = mainBackgroundColor
        
        returnOrderRequestDetails.supermarket = false
    }
}

extension ReturnOrderRequestsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerView == companyPickerView{
            returnOrderRequestDetails.company = companyNamesArray[companyRow]
            returnOrderRequestDetails.companyId = companyIdArray[companyRow]
            
            companyTextField.text = companyNamesArray[companyRow]
            showCompanyPickerView.resignFirstResponder()
        } else if pickerView == salesPersonPickerView{
            returnOrderRequestDetails.salesperson = salesPersonNamesArray[salesPersonRow]
            returnOrderRequestDetails.salespersonId = salesPersonIdArray[salesPersonRow]
            
            salesPersonTextField.text = salesPersonNamesArray[salesPersonRow]
            showSalesPersonPickerView.resignFirstResponder()
        } else if pickerView == customerPickerView{
            returnOrderRequestDetails.customer = customerNamesArray[customerRow]
            returnOrderRequestDetails.customerId = customerIdArray[customerRow]
            
            customerTextField.text = customerNamesArray[customerRow]
            showCustomerPickerView.resignFirstResponder()
        } else {
            returnOrderRequestDetails.branch = branchNamesArray[branchRow]
            returnOrderRequestDetails.branchId = branchIdArray[branchRow]
            
            branchTextField.text = branchNamesArray[branchRow]
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
        returnOrderRequestDetails.returnDate = getStringDate(date: sender.date)
    }
    
    @objc func datePickerDoneClick(){
        if date.isEmpty{
            returnDateTextField.text = getStringDate(date: currentDate)
            returnOrderRequestDetails.returnDate = getStringDate(date: currentDate)
        }
        returnDateTextField.resignFirstResponder()
    }
    
    func getStringDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    func getCustomers(salesperson: String){
        customerArray = webservice.BindSalesReturnCustomers(salesperson: salesperson)
        if customerArray.isEmpty {
            customerNamesArray = ["Select customer".localize()]
        } else {
            customerNamesArray = ["Select customer".localize()]
            customerIdArray = [""]
            for customer in customerArray{
                customerNamesArray.append(customer.CustomerName)
                customerIdArray.append(customer.CustomerId)
            }
        }
    }
    
    // -- Mark: Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == companyPickerView{
            return companyNamesArray.count
        } else if pickerView == salesPersonPickerView{
            return salesPersonNamesArray.count
        } else if pickerView == customerPickerView{
            return customerNamesArray.count
        } else {
            return branchNamesArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerView = pickerView
        if pickerView == companyPickerView{
            return companyNamesArray[row].trimmingCharacters(in: .newlines)
        } else if pickerView == salesPersonPickerView{
            return salesPersonNamesArray[row]
        } else if pickerView == customerPickerView{
            return customerNamesArray[row]
        } else {
            return branchNamesArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == companyPickerView{
            companyRow = row
        } else if pickerView == salesPersonPickerView{
            salesPersonRow  = row
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            getCustomers(salesperson: salesPersonIdArray[row])
            customerTextField.text = customerNamesArray[0]
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        } else if pickerView == customerPickerView{
            customerRow = row
        } else {
            branchRow = row
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
