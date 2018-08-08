//
//  ReturnOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var fileInfo = [FileModul]()
var itemsArrayFromWS = [InvoiceItemModel]()

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
    @IBOutlet weak var selectorSuperMarketYes: UIView!
    @IBOutlet weak var selectorSuperMarketNo: UIView!
    @IBOutlet weak var innerSelectorSuperMarketYes: UIView!
    @IBOutlet weak var innerSelectorSuperMarketNo: UIView!
    @IBOutlet weak var superMarketYesButton: UIButton!
    @IBOutlet weak var superMarketNoButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var invoiceDateTextField: UITextField!
    @IBOutlet weak var invoiceTextField: UITextField!
    @IBOutlet weak var showInvoicePickerView: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var showItemPickerView: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var storeTextfield: UITextField!
    @IBOutlet weak var showStorePickerViewTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var showCityPickerViewTextfield: UITextField!
    @IBOutlet weak var salesPersonStoreTextfield: UITextField!
    @IBOutlet weak var showSalesPersonPickerViewTextfield: UITextField!
    @IBOutlet weak var merchandiserTextfield: UITextField!
    @IBOutlet weak var showMerchandiserPickerViewTextfield: UITextField!
    
    @IBOutlet weak var creditLimitRight: UILabel!
    @IBOutlet weak var totalDueRight: UILabel!
    @IBOutlet weak var upTo31Right: UILabel!
    @IBOutlet weak var upTo60Right: UILabel!
    @IBOutlet weak var upTo90Right: UILabel!
    @IBOutlet weak var upTo120Right: UILabel!
    @IBOutlet weak var moreThan90Right: UILabel!
    @IBOutlet weak var statusRight: UILabel!
    @IBOutlet weak var viewHolder: UIView!
    
    @IBOutlet weak var uploadFileOutlet: UIButton!
    @IBOutlet weak var showFilesOutlet: UIButton!
    @IBOutlet weak var itemOutlet: UIBarButtonItem!
    
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var storeStackView: UIStackView!
    
    // -- MARK: Variables
    
    let takeAction = ROActions.shared
    
    let screenSize = AppDelegate.shared.screenSize
    var companyPickerView = UIPickerView()
    var salesPersonPickerView = UIPickerView()
    var customerPickerView = UIPickerView()
    var branchPickerView = UIPickerView()
    var pickerView = UIPickerView()
    
    var invoicePickerView: UIPickerView = UIPickerView()
    var itemPickerView: UIPickerView = UIPickerView()
    
    let storePickerView: UIPickerView = UIPickerView()
    let cityPickerView: UIPickerView = UIPickerView()
    let salesPersonStorePickerView: UIPickerView = UIPickerView()
    let merchandiserPickerView: UIPickerView = UIPickerView()
    
    var datePicker = UIDatePicker()
    var invoiceDatePicker: UIDatePicker = UIDatePicker()
    let currentDate = Date()
    var date: String = ""
    
    let webservice = SalesReturnRequestService.instance
    var companyArray = [CompanyModul]()
    var companyNamesArray = [String]()
    var companyIdArray = [String]()
    var salespersonArray = [SalesPersonModul]()
    var salesPersonNamesArray = [String]()
    var salesPersonIdArray = [String]()
    var customerArray = [CustomerModul]()
    var customerNamesArray = [String]()
    var customerIdArray = [String]()
    var branchArray = [BranchModul]()
    var branchNamesArray = [String]()
    var branchIdArray = [String]()
    
    var invoiceNameArray: [String] = [String]()
    var itemNameArray: [String] = [String]()
    var invoices: [InvoicesModel] = [InvoicesModel]()
    
    var invoiceArray = [InvoiceAndItemModul]()
    var itemArray = [InvoiceAndItemModul]()
    
    var creditDetailsArray = [CreditLimitModul]()
    var creditDetailsArrayReceived = [CreditLimitModul]()
    
    var storeArrayReceived = [StoreModul]()
    var storeArray = [StoreModul]()
    var storeIdArray = [String]()
    var cityArray = [StoreModul]()
    var salesPersonStoreArray = [StoreModul]()
    var merchandiserArray = [StoreModul]()
    
    var salesSelecteedRow: Int = 0
    var citySelectedRow: Int = 0
    var salesperosnSelectedRow: Int = 0
    var merSelectedRow: Int = 0
    var isThereStoreId: Bool = true
    
    var companyRow = 0
    var salesPersonRow = 0
    var customerRow = 0
    var branchRow = 0
    
    var invoiceSelectedRow = 0
    var itemSelectedRow = 0
    
    var count = 0
    var textField = UITextField()
    
    var emp_id = ""
    var returnId = ""
    var supermarket = false
    
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emp_id = AuthServices.currentUserId
        
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
        if companyArray.isEmpty && salespersonArray.isEmpty && branchArray.isEmpty{
            setupArrays()
        }
        takeAction.setCountForItem(c: itemsArrayFromWS.count, button: itemOutlet)
        
        activityIndicator.stopAnimating()
    }
    
    // -- MARK: Set ups
    
    func setUpSalesOrderData(){
        companyArray = webservice.commonSalesService.BindSalesOrderCompany()
        salespersonArray = webservice.BindSalesReturnSalesPerson()
        branchArray = webservice.commonSalesService.BindSalesOrderBranches()
    }
    
    func setUpViews(){
        setCustomDefaultNav(navItem: navigationItem)
        
        stackViewWidth.constant = AppDelegate.shared.screenSize.width - 32
        showCompanyPickerView.tintColor = .clear
        returnDateTextField.tintColor = .clear
        showSalesPersonPickerView.tintColor = .clear
        showCustomerPickerView.tintColor = .clear
        showBranchPickerView.tintColor = .clear
        showInvoicePickerView.tintColor = .clear
        showInvoicePickerView.tintColor = .clear
        showItemPickerView.tintColor = .clear
        showStorePickerViewTextfield.tintColor = .clear
        showCityPickerViewTextfield.tintColor = .clear
        showSalesPersonPickerViewTextfield.tintColor = .clear
        showMerchandiserPickerViewTextfield.tintColor = .clear
        
        viewHolder.layer.cornerRadius = 5.0
        viewHolder.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        viewHolder.layer.borderWidth = 1
        
        storeStackView.isHidden = true
        viewHolder.isHidden = true
        
        returnDateTextField.delegate = self
        invoiceDateTextField.delegate = self
        commentTextView.delegate = self
        
        companyNamesArray = ["Select company".localize()]
        companyIdArray = [" "]
        salesPersonNamesArray = ["Select sales person".localize()]
        salesPersonIdArray = [" "]
        customerNamesArray = ["Select customer".localize()]
        customerIdArray = [" "]
        branchNamesArray = ["Select branch".localize()]
        branchIdArray = [" "]
        invoiceNameArray = ["Select invoce".localize()]
        itemNameArray = [" "]
        storeIdArray = ["Select store id".localize()]
        
        setupPickerView()
        setupDatePicker()
        setUpSelectors()
        setUpCommentDisplay()
        setUpButtonBorderView()
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
            companyRow = 1
        } else {
            companyTextField.text = companyNamesArray[0]
        }
        customerTextField.text = customerNamesArray[0]
        branchTextField.text = branchNamesArray[0]
        
        if salespersonArray.isEmpty{
            salesPersonTextField.text = salesPersonNamesArray[0]
        } else {
            salesPersonTextField.text = salesPersonNamesArray[1]
            salesPersonRow = 1
            getCustomers(salesperson: salesPersonIdArray[1])
        }
    }
    
    let cornerRadiusValueHolder: CGFloat = 12
    let cornerRadiusValueInner: CGFloat = 11
    let cornerRadiusValueView: CGFloat = 9
    func setUpSelectors(){
        selectorSuperMarketYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorSuperMarketNo.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorSuperMarketYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorSuperMarketNo.layer.cornerRadius = cornerRadiusValueInner
        setDefaultSelectorSelection()
    }
    
    func setDefaultSelectorSelection(){
        superMarketYesButton.layer.cornerRadius = cornerRadiusValueView
        superMarketYesButton.backgroundColor = .white
        superMarketNoButton.layer.cornerRadius = cornerRadiusValueView
        superMarketNoButton.backgroundColor = mainBackgroundColor
    }
    
    func setUpCommentDisplay(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    func setUpButtonBorderView(){
        setupButtonBorder(button: uploadFileOutlet)
        setupButtonBorder(button: showFilesOutlet)
    }
    
    func setupButtonBorder(button: UIButton){
        button.layer.borderWidth = 1
        button.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
    }
    
    // -- MARK: IBActions
    
    @IBAction func itemButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showItemSelected", sender: nil)
    }
    
    var eachItemAddedCount = 0
    func addItem(itemArrayFromWS: [ReturnItemSendModel]){
        for item in itemArrayFromWS{
            eachItemAddedCount += 1
            itemsArrayFromWS.append(InvoiceItemModel(
                serialNumberFromWS: eachItemAddedCount,
                itemNumberFromWS: item.SRR_ITEMGRID_COLUMN2,
                invoiceNumberFromWS: item.SRR_ITEMGRID_COLUMN3,
                desc: item.SRR_ITEMGRID_COLUMN4,
                unof: item.SRR_ITEMGRID_COLUMN5,
                qty: item.SRR_ITEMGRID_COLUMN6,
                avgPrice: item.SRR_ITEMGRID_COLUMN8,
                totalPrice: item.SRR_ITEMGRID_COLUMN7,
                expiredDate: item.SRR_ITEMGRID_COLUMN9,
                invoiceDateFromWS: item.SRR_ITEMGRID_COLUMN10,
                returnType: "Select Type".localize()))
            self.takeAction.setCountForItem(c: itemsArrayFromWS.count, button: itemOutlet)
            AlertMessage().showAlertForXTime(alertTitle: "Invoice has been Added".localize(), time: 0.5, tagert: self)
        }
        addItemCount += 1
    }
    
    var addItemCount = 0
    var isItemExist = false
    @IBAction func addItemButtonTapped(_ sender: Any) {
        if let invoiceDateText = invoiceDateTextField.text,
            let invoiceText = invoiceTextField.text,
            let itemText = itemTextField.text{
            
            if invoiceDateText.isEmpty || invoiceText == invoiceNameArray[0] || itemText == itemNameArray[0]{
                AlertMessage().showAlertMessage(alertTitle: "Alert".localize(), alertMessage: "You did not fill invoice date or did not select invoice or item".localize(), actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
            } else {
                let itemDetailsFromWS = webservice.SRR_AddItem(
                    rownumber: addItemCount,
                    returnid: "",
                    empno: emp_id,
                    qty: "",
                    invoicenumber: invoiceNameArray[invoiceSelectedRow],
                    item: itemNameArray[itemSelectedRow],
                    table: "")
                
                if itemsArrayFromWS.isEmpty{
                    self.addItem(itemArrayFromWS: itemDetailsFromWS)
                } else {
                    for value in itemsArrayFromWS{
                        if value.invoiceDateFromWS == invoiceDateText &&
                            value.invoiceNumberFromWS == invoiceText &&
                            value.itemNumberFromWS == itemText{
                            isItemExist = true
                            break
                        }
                    }
                    
                    if isItemExist{
                        AlertMessage().showAlertMessage(alertTitle: "Invoice has been Added".localize(), alertMessage: "You have already added this invoice. Do you wnat to add it again".localize(), actionTitle: "Yes".localize(), onAction: {
                            self.addItem(itemArrayFromWS: itemDetailsFromWS)
                        }, cancelAction: "No".localize(), self)
                        isItemExist = false
                    } else {
                        self.addItem(itemArrayFromWS: itemDetailsFromWS)
                    }
                }
            }
        }
    }
    
    @IBAction func uplaodFileButtonTapped(_ sender: Any) {
        takeAction.handleFilesToShow(target: self)
    }
    
    @IBAction func showFilesButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showFile", sender: nil)
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation".localize(),
            alertMessage: "Do you want to send the request".localize(),
            actionTitle: "Ok",
            onAction: {
                self.checkRequirementsAndThenProccess()
        }, cancelAction: "Cancel",
           self)
    }
    
    func alertMessageForEmptyField(alertMessage: String){
        AlertMessage().showAlertMessage(
            alertTitle: "Alert".localize(),
            alertMessage: alertMessage,
            actionTitle: nil,
            onAction: nil,
            cancelAction: "OK", self)
        return
    }
    
    var shouldProcess = false
    func checkRequirementsAndThenProccess(){
        if let companyText = companyTextField.text,
            let returnDateText = returnDateTextField.text,
            let salesPerosnText = salesPersonTextField.text,
            let customerText = customerTextField.text,
            let branchText = branchTextField.text,
            let storeText = storeTextfield.text,
            let cityText = cityTextfield.text,
            let salesPersonStoreText = salesPersonStoreTextfield.text,
            let merText = merchandiserTextfield.text,
            let comment = commentTextView.text
        {
            if companyText == companyNamesArray[0] ||
                returnDateText == "" ||
                salesPerosnText == salesPersonNamesArray[0] ||
                customerText == customerNamesArray[0] ||
                branchText == branchNamesArray[0]{
                    self.alertMessageForEmptyField(alertMessage: "You did not fill the fields".localize())
                    self.shouldProcess = false
            } else if !storeArray.isEmpty && storeText == storeIdArray[0] {
                self.alertMessageForEmptyField(alertMessage: "You did not select store id".localize())
                self.shouldProcess = false
            } else if itemsArrayFromWS.isEmpty{
                self.alertMessageForEmptyField(alertMessage: "You did not add any items".localize())
                self.shouldProcess = false
            } else { self.shouldProcess = true }
            
            for item in itemsArrayFromWS{
                if item.returnType == "Select Type".localize(){
                    self.alertMessageForEmptyField(alertMessage: "You did not select return item for each item".localize())
                    self.shouldProcess = false
                } else { shouldProcess = true }
            }
            
            if shouldProcess{
                self.activityIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.runBeforeSending()
                    self.runSend(returnDate: returnDateText, comment: comment, city: cityText, salesPersonStore: salesPersonStoreText, merchandiser: merText)
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
    }
    
    func runBeforeSending(){
        for item in itemsArrayFromWS{
            let beforeSendResultArray = webservice.SRR_BEFORESEND_SRR(
                itemid: item.itemNumberFromWS,
                invoicenumber: item.invoiceNumberFromWS,
                quantity: item.qty,
                returnid: returnId,
                rownumber: item.serialNumberFromWS,
                Item_Desc: item.desc,
                unitofmeasure: item.uofm,
                totalcost: item.totalPrice,
                unitprice: item.avgPrice,
                lotnumber: item.expiredDate,
                invoicedate: item.invoiceDateFromWS,
                returntype_grid: item.returnType)
            
            validateBeforeSending(beforeSendResultArray: beforeSendResultArray)
        }
    }
    
    func validateBeforeSending(beforeSendResultArray: [String?]){
        if !beforeSendResultArray.isEmpty{
            if beforeSendResultArray[1] != ""{
                if let alertMessage = beforeSendResultArray[1]{
                    AlertMessage().showAlertMessage(
                        alertTitle: "Alert!".localize(),
                        alertMessage: alertMessage ,
                        actionTitle: "OK",
                        onAction: nil,
                        cancelAction: nil,
                        self)
                    self.activityIndicator.stopAnimating()
                    return
                }
            } else {
                if let returnIdFromBeforeSendResultArray = beforeSendResultArray[0]{
                    if returnId == ""{
                        returnId = returnIdFromBeforeSendResultArray
                    }
                }
            }
        }
    }
    
    func runSend(returnDate: String, comment: String, city: String, salesPersonStore: String, merchandiser: String){
        let sendResultArray = webservice.SRR_SEND_SRR(
            supermarket: supermarket,
            itemtable: !itemsArrayFromWS.isEmpty,
            returnid: returnId,
            customervalue: customerIdArray[customerRow],
            customertext: customerNamesArray[customerRow],
            salespersonvalue: salesPersonIdArray[salesPersonRow],
            salespersontext: salesPersonNamesArray[salesPersonRow],
            returndate: returnDate,
            emp_no: emp_id,
            comment: comment,
            branchtext: branchNamesArray[branchRow],
            companyid: companyIdArray[companyRow],
            branchvalue: branchIdArray[branchRow],
            storevalue: storeIdArray[salesSelecteedRow],
            cityvalue: city,
            storesalespersonvalue: salesPersonStore,
            merchandiser: merchandiser)
        
        if !sendResultArray.isEmpty{
            if sendResultArray[1] != ""{
                if let error = sendResultArray[1]{
                    AlertMessage().showAlertMessage(
                        alertTitle: "Sending Error".localize(),
                        alertMessage: "\(error)",
                        actionTitle: "OK",
                        onAction: nil,
                        cancelAction: nil,
                        self)
                    self.activityIndicator.stopAnimating()
                    return
                }
            } else {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success".localize(),
                    alertMessage: "Return request sent successfully with return no.".localize() + " \(returnId)",
                    actionTitle: "OK",
                    onAction: {
                        self.activityIndicator.startAnimating()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                            self.setViewToDefault()
                            self.activityIndicator.stopAnimating()
                        })
                },
                    cancelAction: nil,
                    self)
            }
        }
    }
    
    func setViewToDefault(){
        view.setNeedsDisplay()
        
        salesPersonPickerView.selectRow(0, inComponent: 0, animated: true)
        customerPickerView.selectRow(0, inComponent: 0, animated: true)
        branchPickerView.selectRow(0, inComponent: 0, animated: true)
        invoicePickerView.selectRow(0, inComponent: 0, animated: true)
        itemPickerView.selectRow(0, inComponent: 0, animated: true)
        storePickerView.selectRow(0, inComponent: 0, animated: true)
        cityPickerView.selectRow(0, inComponent: 0, animated: true)
        salesPersonStorePickerView.selectRow(0, inComponent: 0, animated: true)
        merchandiserPickerView.selectRow(0, inComponent: 0, animated: true)
        
        eachItemAddedCount = 0
        addItemCount = 0
        isItemExist = false
        shouldProcess = false
        returnId = ""
        count = 0
        initialValues()

        setDependentValuesToDefault()
        setDefaultSelectorSelection()
        returnDateTextField.text = ""
        commentTextView.text = ""
        storeStackView.isHidden = true
        viewHolder.isHidden = true
        itemsArrayFromWS.removeAll()
        takeAction.setCountForItem(c: itemsArrayFromWS.count, button: itemOutlet)
        scrollView.scrollTo(direction: .Top, animated: false)
    }
    
    func setUpDefaultValueForStore(){
        salesSelecteedRow = 0
        citySelectedRow = 0
        salesperosnSelectedRow = 0
        merSelectedRow = 0
        
        storeTextfield.text = storeIdArray[0]
        cityTextfield.text = "Select city".localize()
        salesPersonStoreTextfield.text = "Select sales person".localize()
        merchandiserTextfield.text = "Select merchandiser".localize()
    }
    
    func setDependentValuesToDefault(){
        date = ""
        setUpDefaultValueForStore()
        invoiceDateTextField.text = ""
        
        invoiceSelectedRow = 0
        itemSelectedRow = 0
        invoiceTextField.text = invoiceNameArray[0]
        itemTextField.text = itemNameArray[0]
    }
    
    @IBAction func superMarketYesButtonTapped(_ sender: Any) {
        superMarketYesButton.backgroundColor = mainBackgroundColor
        superMarketNoButton.backgroundColor = .white
        
        supermarket = true
    }
    
    @IBAction func superMarketNoButtonTapped(_ sender: Any) {
        superMarketYesButton.backgroundColor = .white
        superMarketNoButton.backgroundColor = mainBackgroundColor
        
        supermarket = false
    }
}

// -- MARK: Handle Picker View

extension ReturnOrderRequestsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showCompanyPickerView, pickerview: companyPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerView, pickerview: salesPersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showCustomerPickerView, pickerview: customerPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showBranchPickerView, pickerview: branchPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showInvoicePickerView, pickerview: invoicePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showItemPickerView, pickerview: itemPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showStorePickerViewTextfield, pickerview: storePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showCityPickerViewTextfield, pickerview: cityPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerViewTextfield, pickerview: salesPersonStorePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showMerchandiserPickerViewTextfield, pickerview: merchandiserPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerView == companyPickerView{
            companyTextField.text = companyNamesArray[companyRow]
            showCompanyPickerView.resignFirstResponder()
            
        } else if pickerView == salesPersonPickerView{
            HandleValuesForSalesPerson(
                name: salesPersonNamesArray[salesPersonRow],
                id: salesPersonIdArray[salesPersonRow])
            
            salesPersonTextField.text = salesPersonNamesArray[salesPersonRow]
            showSalesPersonPickerView.resignFirstResponder()
            
        } else if pickerView == customerPickerView{
            HandleValuesForCustomer(
                name: customerNamesArray[customerRow],
                id: customerIdArray[customerRow])
            
            customerTextField.text = customerNamesArray[customerRow]
            showCustomerPickerView.resignFirstResponder()
        } else if pickerView == branchPickerView{
            
            branchTextField.text = branchNamesArray[branchRow]
            showBranchPickerView.resignFirstResponder()
        }else if pickerView == invoicePickerView{
            HandleValuesForInvoiceNo(name: invoiceNameArray[invoiceSelectedRow])
            
        } else if pickerView == itemPickerView{
            itemTextField.text = itemNameArray[itemSelectedRow]
            showItemPickerView.resignFirstResponder()
            
        } else if pickerView == storePickerView{
            HandleValuesForStore(name: storeIdArray[salesSelecteedRow])
            
            storeTextfield.text = storeIdArray[salesSelecteedRow]
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerView == cityPickerView{
            HandleValuesForCity(name: cityArray[citySelectedRow].City)
            
        } else if pickerView == salesPersonStorePickerView{
            HandleValuesForSalesPersonStore(name: salesPersonStoreArray[salesperosnSelectedRow].SalesPersonStore)
            
        } else if pickerView == merchandiserPickerView{
            HandleValuesForMerchandiser(name: merchandiserArray[merSelectedRow].Merchandiser)
            
        }
    }
    
    @objc func cancelClick(){
        if pickerView == companyPickerView { showCompanyPickerView.resignFirstResponder() }
        else if pickerView == salesPersonPickerView { showSalesPersonPickerView.resignFirstResponder() }
        else if pickerView == customerPickerView { showCustomerPickerView.resignFirstResponder() }
        else if pickerView == branchPickerView { showBranchPickerView.resignFirstResponder() }
        else if pickerView == invoicePickerView { showInvoicePickerView.resignFirstResponder() }
        else if pickerView == itemPickerView { showItemPickerView.resignFirstResponder() }
        else if pickerView == storePickerView { showStorePickerViewTextfield.resignFirstResponder() }
        else if pickerView == cityPickerView { showCityPickerViewTextfield.resignFirstResponder() }
        else if pickerView == salesPersonStorePickerView { showSalesPersonPickerViewTextfield.resignFirstResponder() }
        else if pickerView == merchandiserPickerView { showMerchandiserPickerViewTextfield.resignFirstResponder() }
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
        } else if pickerView == branchPickerView{
            return branchNamesArray.count
        } else if pickerView == invoicePickerView{
            return invoiceNameArray.count
        } else if pickerView == itemPickerView{
            return itemNameArray.count
        } else if pickerView == storePickerView{
            return storeArray.count
        } else if pickerView == cityPickerView{
            return cityArray.count
        } else if pickerView == salesPersonStorePickerView{
            return salesPersonStoreArray.count
        } else if pickerView == merchandiserPickerView{
            return merchandiserArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerView = pickerView
        if pickerView == companyPickerView{
            return companyNamesArray[row].trimmingCharacters(in: .newlines)
        } else if pickerView == salesPersonPickerView{
            return salesPersonNamesArray[row]
        } else if pickerView == customerPickerView{
            return customerNamesArray[row]
        } else if pickerView == branchPickerView {
            return branchNamesArray[row]
        } else if pickerView == invoicePickerView{
            return invoiceNameArray[row]
        } else if pickerView == itemPickerView{
            return itemNameArray[row]
        } else if pickerView == storePickerView{
            return storeIdArray[row].localize()
        } else if pickerView == cityPickerView{
            return cityArray[row].City
        } else if pickerView == salesPersonStorePickerView{
            return salesPersonStoreArray[row].SalesPersonStore
        } else if pickerView == merchandiserPickerView{
            return merchandiserArray[row].Merchandiser
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == companyPickerView{
            companyRow = row
        } else if pickerView == salesPersonPickerView{
            salesPersonRow  = row
        } else if pickerView == customerPickerView{
            customerRow = row
        } else if pickerView == branchPickerView{
            branchRow = row
        } else if pickerView == invoicePickerView{
            invoiceSelectedRow = row
            itemSelectedRow = 0
        } else if pickerView == itemPickerView{
            itemSelectedRow = row
        } else if pickerView == storePickerView{
            salesSelecteedRow = row
        } else if pickerView == cityPickerView{
            citySelectedRow = row
        } else if pickerView == salesPersonStorePickerView {
            salesperosnSelectedRow = row
        } else {
            merSelectedRow = row
        }
    }
}

// -- MARK: Handle Date Picker

extension ReturnOrderRequestsViewController{
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: returnDateTextField, datePicker: datePicker, title: "Return Date".localize(), viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
        PickerviewAction().showDatePicker(txtfield: invoiceDateTextField, datePicker: datePicker, title: "Invoice Date".localize(), viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        date = takeAction.getStringDate(date: sender.date)
        
        if textField == returnDateTextField{
            returnDateTextField.text = takeAction.getStringDate(date: sender.date)
        } else if textField == invoiceDateTextField{
            invoiceDateTextField.text = takeAction.getStringDate(date: sender.date)
            setUpDefaultValueForStore()
        }
    }
    
    @objc func datePickerDoneClick(){
        var selectedDate = ""
        if date.isEmpty{
            if textField == returnDateTextField{
                returnDateTextField.text = takeAction.getStringDate(date: currentDate)
            } else if textField == invoiceDateTextField{
                selectedDate = takeAction.getStringDate(date: currentDate)
                invoiceDateTextField.text = takeAction.getStringDate(date: currentDate)
            }
        } else {
            selectedDate = date
        }
        
        if textField == invoiceDateTextField{
            getInvoiceNumber(
                salesperson_id: salesPersonIdArray[salesPersonRow],
                customernumber: customerIdArray[customerRow],
                invoice_date: selectedDate)
            invoiceTextField.text = invoiceNameArray[0]
            invoicePickerView.selectRow(0, inComponent: 0, animated: true)
            itemTextField.text = itemNameArray[0]
            itemPickerView.selectRow(0, inComponent: 0, animated: true)
            
            if selectedDate != date{
                setUpDefaultValueForStore()
            }
            
            storeStackView.isHidden = storeArray.isEmpty
            viewHolder.isHidden = creditDetailsArray.isEmpty
        }
        
        invoiceDateTextField.resignFirstResponder()
        returnDateTextField.resignFirstResponder()
    }
}

// -- MARK: Handle Text View and Text Field

extension ReturnOrderRequestsViewController: UITextViewDelegate, UITextFieldDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField = textField
    }
}

// -- MARK: Handle Keyboard Appearance

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
