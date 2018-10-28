//
//  SalesCollectionRequestViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesCollectionRequestViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var empTextField: UITextField!
    @IBOutlet weak var empDDTextField: UITextField!
    @IBOutlet weak var collectionTypeTextField: UITextField!
    @IBOutlet weak var collectionTypeDDTextField: UITextField!
    @IBOutlet weak var salesPersonTextField: UITextField!
    @IBOutlet weak var customerTextField: UITextField!
    @IBOutlet weak var territoryTextField: UITextField!
    @IBOutlet weak var territoryDDTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var checkNoTextField: UITextField!
    @IBOutlet weak var checkNoStackView: UIStackView!
    @IBOutlet weak var bankNameTextField: UITextField!
    @IBOutlet weak var bankNameStackView: UIStackView!
    @IBOutlet weak var bankNameDDTextField: UITextField!
    @IBOutlet weak var dueDate: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWitdh: NSLayoutConstraint!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    var textfield = UITextField()
    let pickerview = UIPickerView()
    let datePicker = UIDatePicker()
    let btripWebService = BusinessTripService.instance
    let webService = SalesCollectionService.instance
    var currentUser = AuthServices.currentUserId
    var language = LoginViewController.languageChosen
    let alertMsg = AlertMessage()
    
    var empArray = [BusinessTripClass]()
    var empIndex = 0
    let empPickerview = UIPickerView()
    
    var collectionTypeArray = [CollectionTypeModul]()
    var collectionTypeIndex = 0
    let collectionTypePickerview = UIPickerView()
    
    var salesPersonArray = [CollSalesPersonModul]()
    var salesPersonName = ""
    
    var customerArray = [CollCustomerModul]()
    var selectedCustomer = CollCustomerModul()
    
    var territoryArray = [TerritoryModul]()
    var territoryIndex = 0
    let territoryPickerview = UIPickerView()
    
    var bankArray = [BankTypeModul]()
    var bankIndex = 0
    let bankPickerview = UIPickerView()
    
    // -- MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSlideMenu(controller: self, menuButton: menuBtn)
        setUpView()
        setUpPickerView()
        datePickerSetUp()
        setViewAlignment()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        
        if empArray.isEmpty &&
            collectionTypeArray.isEmpty &&
            salesPersonArray.isEmpty &&
            territoryArray.isEmpty{
            
            setUpArray()
        }
        
        stop()
    }
    
    // -- MARK: Setups
    
    func start(){startLoader(superView: aiContainer, activityIndicator: ai)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: ai)}
    
    func setUpView(){
        amountTextField.delegate = self
        checkNoTextField.delegate = self
        commentTextView.delegate = self
        dueDate.tintColor = .clear
        stackViewWitdh.constant = AppDelegate.shared.screenSize.width - 32
        
        setUpToolbarForTextField()
        start()
    }
    
    func setUpArray(){
        empArray = btripWebService.BindDdlEmps(emp_id: currentUser, lang: language)
        collectionTypeArray = webService.GetCollectionType_SC(lang: "\(language)")
        salesPersonArray = webService.GetSlsPerson_SC()
        bankArray = webService.GetBank_SC(login_empid: currentUser, lang: "\(language)")
        
        initials()
    }
    
    func initials(){
        if !empArray.isEmpty && !collectionTypeArray.isEmpty && !salesPersonArray.isEmpty{
            empTextField.text = empArray[empIndex].EmpName
            empPickerview.selectRow(empIndex, inComponent: 0, animated: false)
            
            collectionTypeTextField.text = collectionTypeArray[collectionTypeIndex].Desc
            collectionTypePickerview.selectRow(collectionTypeIndex, inComponent: 0, animated: false)
            
            salesPersonName = salesPersonArray[0].SalespersonName
            salesPersonTextField.text = salesPersonName
            updateCustomerAndTerritory(id: salesPersonArray[0].SalesPersonId)
        }
    }
    
    // -- MARK: objc Functions
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // -- MARK: Helper methods
    
    func isCheckNoOrBankNameEmpty(_ checkNoTxt: String, _ dueDateTxt: String, _ bankNameTxt: String) -> Bool{
        if !collectionTypeArray.isEmpty{
            if !checkNoStackView.isHidden {
                return checkNoTxt.isEmpty || dueDateTxt.isEmpty
            } else if !bankNameStackView.isHidden{
                return bankNameTxt == "Select bank"
            }
        }
        return false
    }
    
    func setDefaultValues(){
        empIndex = 0
        collectionTypeIndex = 0
        territoryIndex = 0
        bankIndex = 0
        amountTextField.text = ""
        checkNoTextField.text = ""
        dueDate.text = ""
        bankNameTextField.text = "Select bank"
        checkNoStackView.isHidden = false
        bankNameStackView.isHidden = false
        initials()
        scrollView.scrollTo(direction: .Top, animated: false)
    }
    
    // -- MARK: IBAction
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        guard let empTxt = empTextField.text,
            let collectionTypeTxt = collectionTypeTextField.text,
            let slsTxt = salesPersonTextField.text,
            let customerTxt = customerTextField.text,
            let territoryTxt = amountTextField.text,
            let amtTxt = amountTextField.text,
            let checkNoTxt = checkNoTextField.text,
            let dueDateTxt = dueDate.text,
            let bankNameTxt = bankNameTextField.text,
            let comment = commentTextView.text
            else {return}
        
        if empTxt == "Select employee" ||
            collectionTypeTxt == "Select collection type" ||
            slsTxt == "Select sales person" ||
            customerTxt == "Select customer" ||
            territoryTxt == "Select territory" ||
            amtTxt.isEmpty ||
            isCheckNoOrBankNameEmpty(checkNoTxt, dueDateTxt, bankNameTxt){
            
            alertMsg.showAlertMessage(alertTitle: "Alert",
                                      alertMessage: "You did not select or fill one of the fields",
                                      actionTitle: "OK",
                                      onAction: { return },
                                      cancelAction: nil, self)
        } else {
            
            let bankInfo = bankNameStackView.isHidden ? BankTypeModul() : bankArray[bankIndex]
            let bankIntoId = bankInfo.Id.toInt() ?? 0
            let collectionTypeId = collectionTypeArray[collectionTypeIndex].Id.toInt() ?? 0
            let amount = amtTxt.toDouble() ?? 0.0
            
            print("""
                -------------------------
                emp_id: \(empArray[empIndex].EmpNum),
                coll_type: \(collectionTypeId),
                SalesPerson: \(salesPersonName),
                customer: \(selectedCustomer.CustomerName),
                InvoiceDate: \("1900-01-01"),
                InvoiceNo: \(""),
                Territory: \(territoryArray[territoryIndex].territoryName),
                amount: \(amount),
                CheckBookNo: \(checkNoTxt),
                comment: \(comment),
                bank: \(bankIntoId),
                CheckDueDate: \(dueDateTxt)
                -------------------------
                """)
            
            let collectionRequestResult = webService.SaveData__SC(emp_id: empArray[empIndex].EmpNum,
                                                                  coll_type: collectionTypeId,
                                                                  SalesPerson: salesPersonName,
                                                                  customer: selectedCustomer.CustomerName,
                                                                  InvoiceDate: "1900-01-01",
                                                                  InvoiceNo: "",
                                                                  Territory: territoryArray[territoryIndex].territoryName,
                                                                  amount: amount,
                                                                  CheckBookNo: checkNoTxt,
                                                                  comment: comment,
                                                                  bank: bankIntoId,
                                                                  CheckDueDate: dueDateTxt)
            
            if collectionRequestResult == "1" {
                alertMsg.showAlertMessage(alertTitle: "Success",
                                          alertMessage: "Collection request sent successfully",
                                          actionTitle: "OK",
                                          onAction: { self.setDefaultValues() },
                                          cancelAction: nil, self)
            } else {
                alertMsg.showAlertMessage(alertTitle: "Alert",
                                          alertMessage: collectionRequestResult,
                                          actionTitle: "OK",
                                          onAction: { },
                                          cancelAction: nil, self)
            }
            
        }
    }
    
    @IBAction func showSalesListButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showCollectionSearch", sender: 1)
    }
    
    @IBAction func showCustomerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showCollectionSearch", sender: 2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollectionSearch" {
            if let vc = segue.destination as? SearchCollectionTableViewController{
                if let sender = sender as? Int{
                    if sender == 1 {
                        vc.salesPersons = salesPersonArray
                    } else {
                        vc.customers = customerArray
                    }
                    vc.delegate = self
                }
            }
        }
    }
    
}

// -- MARK: Handle Update Values From Search

extension SalesCollectionRequestViewController: UpdateCollectionSlsAndCustomerValueDelegate{
    func updateSalesPerson(name: String, id: String) {
        salesPersonName = name
        
        salesPersonTextField.text = name
        updateCustomerAndTerritory(id: id)
    }
    
    func updateCustomer(name: String, id: String) {
        selectedCustomer.CustomerName = name
        selectedCustomer.CustomerId = id
        
        customerTextField.text = selectedCustomer.CustomerName
    }
    
    func updateCustomerAndTerritory(id: String){
        start()
        DispatchQueue.main.async {
            self.customerArray = self.webService.GetCustomer_SC(SalesPerson_id: id)
            self.territoryArray = self.webService.GetTerritory_SC(salesperson_id: id)
            
            self.customerTextField.text = "Select customer"
            self.territoryTextField.text = "Select territory"
            self.territoryPickerview.selectRow(0, inComponent: 0, animated: false)
            
            self.stop()
        }
        
    }
    
}

// -- MARK: Handle Picker View

extension SalesCollectionRequestViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: empDDTextField,
                                pickerview: empPickerview,
                                viewController: self,
                                cancelSelector: #selector(cancelClicked),
                                doneSelector: #selector(doneClicked))
        
        PickerviewAction().showPickView(txtfield: collectionTypeDDTextField,
                                pickerview: collectionTypePickerview,
                                viewController: self,
                                cancelSelector: #selector(cancelClicked),
                                doneSelector: #selector(doneClicked))
        
        PickerviewAction().showPickView(txtfield: territoryDDTextField,
                                pickerview: territoryPickerview,
                                viewController: self,
                                cancelSelector: #selector(cancelClicked),
                                doneSelector: #selector(doneClicked))
        
        PickerviewAction().showPickView(txtfield: bankNameDDTextField,
                                pickerview: bankPickerview,
                                viewController: self,
                                cancelSelector: #selector(cancelClicked),
                                doneSelector: #selector(doneClicked))
    }
    
    func handleCollectionTypeSelection(){
        collectionTypeTextField.text = collectionTypeArray[collectionTypeIndex].Desc
        
        switch collectionTypeIndex{
        case 1:
            checkNoStackView.isHidden = false
            bankNameStackView.isHidden = true
        case 2:
            checkNoStackView.isHidden = true
            bankNameStackView.isHidden = false
        default:
            checkNoStackView.isHidden = true
            bankNameStackView.isHidden = true
        }
    }
    
    @objc func doneClicked(){
        if textfield == empDDTextField { empTextField.text = empArray[empIndex].EmpName }
        else if textfield == collectionTypeDDTextField { handleCollectionTypeSelection() }
        else if textfield == territoryDDTextField { territoryTextField.text = territoryArray[territoryIndex].territoryName }
        else if textfield == bankNameDDTextField { bankNameTextField.text = bankArray[bankIndex].Name }
        
        textfield.resignFirstResponder()
    }
    
    @objc func cancelClicked(){
        textfield.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == empPickerview{ return empArray.count }
        else if pickerView == collectionTypePickerview{ return collectionTypeArray.count }
        else if pickerView == territoryPickerview{ return territoryArray.count }
        else if pickerView == bankPickerview{ return bankArray.count }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == empPickerview{ return empArray[row].EmpName }
        else if pickerView == collectionTypePickerview{ return collectionTypeArray[row].Desc }
        else if pickerView == territoryPickerview{ return territoryArray[row].territoryName }
        else if pickerView == bankPickerview{ return bankArray[row].Name }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == empPickerview{ empIndex = row }
        else if pickerView == collectionTypePickerview{ collectionTypeIndex = row }
        else if pickerView == territoryPickerview{ territoryIndex = row }
        else if pickerView == bankPickerview{ bankIndex = row }
    }
}

// -- MARK: Handle Date

extension SalesCollectionRequestViewController{
    func datePickerSetUp(){
        PickerviewAction().showDatePicker(txtfield: dueDate,
                                  datePicker: datePicker,
                                  title: "Due Date",
                                  viewController: self,
                                  datePickerSelector: #selector(handleDatePicker(sender:)),
                                  doneSelector: #selector(dateDoneClicked))
    }
    
    @objc func dateDoneClicked(){
        dueDate.resignFirstResponder()
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        dueDate.text = sender.date.dateToString()
    }
}

// -- MARK: Handle TextField and TextView

extension SalesCollectionRequestViewController: UITextViewDelegate, UITextFieldDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
}

extension SalesCollectionRequestViewController{
    func setUpToolbarForTextField(){
        setUpKeyboardToolBar(textfield: amountTextField,
                             viewController: self,
                             cancelTitle: nil,
                             cancelSelector: nil,
                             doneTitle: "Done",
                             doneSelector: #selector(toolbarDoneClikced))
        setUpKeyboardToolBar(textfield: checkNoTextField,
                             viewController: self,
                             cancelTitle: nil,
                             cancelSelector: nil,
                             doneTitle: "Done",
                             doneSelector: #selector(toolbarDoneClikced))
    }
    
    @objc func toolbarDoneClikced(){
        textfield.resignFirstResponder()
    }
}

extension SalesCollectionRequestViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 81, right: 0)
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
