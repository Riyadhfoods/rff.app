//
//  AddReturnInvoiceViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

struct InvoicesModel {
    var serialNumber: Int = 0
    var invoiceDate: String = ""
    var invoice: String = ""
    var item: String = ""
    
    init(serialNumber: Int, invoiceDate: String, invoice: String, item: String){
        self.serialNumber = serialNumber
        self.invoiceDate = invoiceDate
        self.invoice = invoice
        self.item = item
    }
}

struct InvoiceItemModel {
    var serialNumberFromWS: Int = 0
    var itemNumberFromWS: String = ""
    var invoiceNumberFromWS: String = ""
    var desc: String = ""
    var uofm: String = ""
    var qty: String = ""
    var avgPrice: String = ""
    var totalPrice: String = ""
    var expiredDate: String = ""
    var invoiceDateFromWS: String = ""
    var returnType: String = ""
    
    init(serialNumberFromWS: Int, itemNumberFromWS: String, invoiceNumberFromWS: String, desc: String, unof: String, qty: String, avgPrice: String, totalPrice: String, expiredDate: String, invoiceDateFromWS: String, returnType: String){
        self.serialNumberFromWS = serialNumberFromWS
        self.itemNumberFromWS = itemNumberFromWS
        self.invoiceNumberFromWS = invoiceNumberFromWS
        self.desc = desc
        self.uofm = unof
        self.qty = qty
        self.avgPrice = avgPrice
        self.totalPrice = totalPrice
        self.expiredDate = expiredDate
        self.invoiceDateFromWS = invoiceDateFromWS
        self.returnType = returnType
    }
}

class AddReturnInvoiceViewController: UIViewController, UITextViewDelegate {

    // -- MARK: IBOutlets
    @IBOutlet weak var invoiceDateTextField: UITextField!
    @IBOutlet weak var invoiceTextField: UITextField!
    @IBOutlet weak var showInvoicePickerView: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var showItemPickerView: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var itemAddedLabel: UILabel!
    
    @IBOutlet weak var StoreAndCreditTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    var invoiceDatePicker: UIDatePicker = UIDatePicker()
    var invoicePickerView: UIPickerView = UIPickerView()
    var itemPickerView: UIPickerView = UIPickerView()
    var pickerView: UIPickerView = UIPickerView()
    var invoiceNameArray: [String] = [String]()
    var itemNameArray: [String] = [String]()
    var invoices: [InvoicesModel] = [InvoicesModel]()
    
    var datePicker = UIDatePicker()
    let currentDate = Date()
    var date: String = ""
    
    var storeArray = [SalesModel]()
    var creditDetailsArray = [SalesReturn]()
    var storeArrayReceived = [SalesModel]()
    var creditDetailsArrayReceived = [SalesReturn]()
    var invoiceArray = [SalesReturn]()
    var itemArray = [SalesReturn]()
    let cellId = "cell_storeAndCredit"
    let storeAndCreditArray = ["Store Details", "Credit Limmit Details"]
    var invoiceSelectedRow = 0
    var itemSelectedRow = 0
    
    var emptyArrayElementCheck = [Bool]()
    var emptyArrayCount: CGFloat = 0
    var count = 1
    var countItemAdded = 0
    var itemsarrayFromWS = [SalesReturn]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        setupViews()
        
        activityIndicator.startAnimating()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !returnOrderRequestDetails.itemsarrayFromWS.isEmpty{
            countItemAdded = returnOrderRequestDetails.itemsarrayFromWS.count
        }
        
        setupArrays()
        handleTheHeightOfTableView()
        activityIndicator.stopAnimating()
    }
    
    // -- MARK: Set ups
    
    func setupViews(){
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showInvoicePickerView.tintColor = .clear
        showItemPickerView.tintColor = .clear
        
        StoreAndCreditTableView.delegate = self
        StoreAndCreditTableView.dataSource = self
        StoreAndCreditTableView.isHidden = true
        invoiceNameArray = ["Select invoce"]
        itemNameArray = [" "]
        
        setUpCommentDisplay()
        setupDatePicker()
        setupPickerView()
    }
    
    func setCountLabel(c: Int){
        itemAddedLabel.text = "Items added is ".localize() + "\(c)"
    }
    
    func setUpCommentDisplay(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    func setupArrays(){
        storeArray = webservice.BindDdlStore(customerid: returnOrderRequestDetails.customer)
        creditDetailsArray = webservice.SRR_BindCustomerAging(customer_no: returnOrderRequestDetails.customer)
    }
    
    func handleTheHeightOfTableView(){
        emptyArrayElementCheck.append(storeArray.isEmpty)
        emptyArrayElementCheck.append(creditDetailsArray.isEmpty)
        for isEmpty in emptyArrayElementCheck{
            if isEmpty{
                emptyArrayCount += 1
            }
        }
        let rowHeight: CGFloat = 44 * (2 - emptyArrayCount)
        setTableViewHeight(height: rowHeight)
    }
    
    func setTableViewHeight(height: CGFloat){
        tableViewHeight.constant = height
    }
    
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showInvoicePickerView, pickerview: invoicePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showItemPickerView, pickerview: itemPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: invoiceDateTextField, datePicker: datePicker, title: "Return Date", viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // -- MARK: IBActions

    @IBAction func showItemButtonTapped(_ sender: Any) {
        if let commentText = commentTextView.text{
            returnOrderRequestDetails.comment = commentText
        }
        
        if !storeArray.isEmpty{
            if returnOrderRequestDetails.store.isEmpty && returnOrderRequestDetails.city.isEmpty && returnOrderRequestDetails.salespersonstore.isEmpty && returnOrderRequestDetails.merchandiser.isEmpty{
                returnOrderRequestDetails.isStoreArrayNotEmptyAndStoreSelectionEmpty = true
            }
        }
        
        performSegue(withIdentifier: "showItemSelected", sender: nil)
        print(returnOrderRequestDetails)
    }
    
    struct oldValue {
        var invoiceDate = ""
        var invoiceNumber = ""
        var itemNumber = ""
    }
    
    var oldValuesArray = [oldValue]()
    var isItemExist = false
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if let invoiceDateText = invoiceDateTextField.text,
            let invoiceText = invoiceTextField.text,
            let itemText = itemTextField.text{
            
            if invoiceDateText.isEmpty || invoiceText == invoiceNameArray[0] || itemText == itemNameArray[0]{
                AlertMessage().showAlertMessage(alertTitle: "Alert", alertMessage: "You did not fill invoice date or did not select invoice or item", actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
            } else {
                
                invoices.append(InvoicesModel(serialNumber: count, invoiceDate: invoiceDateText, invoice: invoiceText, item: itemText))
                returnOrderRequestDetails.invoicesArray = invoices

                itemsarrayFromWS = webservice.SRR_AddItem(
                    rownumber: count,
                    returnid: "",
                    empno: returnOrderRequestDetails.emp_id,
                    qty: "",
                    invoicenumber: invoiceNameArray[invoiceSelectedRow],
                    item: itemNameArray[itemSelectedRow],
                    table: "")
                count += 1
                
                if oldValuesArray.isEmpty{
                    addItemAndUpdateOldValues(invoiceDateTExt: invoiceDateText, invoiceNoText: invoiceText, itemNoText: itemText)
                } else {
                    for value in oldValuesArray{
                        if value.invoiceDate == invoiceDateText &&
                            value.invoiceNumber == invoiceText &&
                            value.itemNumber == itemText{
                            isItemExist = true
                            break
                        }
                    }
                    
                    if isItemExist{
                        AlertMessage().showAlertMessage(alertTitle: "Invoice has been Added".localize(), alertMessage: "You have already added this invoice. Do you wnat to add it again".localize(), actionTitle: "Yes".localize(), onAction: {
                            self.addItem()
                        }, cancelAction: "No".localize(), self)
                        isItemExist = false
                    } else {
                        addItemAndUpdateOldValues(invoiceDateTExt: invoiceDateText, invoiceNoText: invoiceText, itemNoText: itemText)
                    }
                }
            }
        }
    }
    
    func addItem(){
        for item in itemsarrayFromWS{
            returnOrderRequestDetails.itemsarrayFromWS.append(InvoiceItemModel(
                serialNumberFromWS: countItemAdded,
                itemNumberFromWS: item.SRR_ITEMGRID_COLUMN2,
                invoiceNumberFromWS: item.SRR_ITEMGRID_COLUMN3,
                desc: item.SRR_ITEMGRID_COLUMN4,
                unof: item.SRR_ITEMGRID_COLUMN5,
                qty: item.SRR_ITEMGRID_COLUMN6,
                avgPrice: item.SRR_ITEMGRID_COLUMN8,
                totalPrice: item.SRR_ITEMGRID_COLUMN7,
                expiredDate: item.SRR_ITEMGRID_COLUMN9,
                invoiceDateFromWS: item.SRR_ITEMGRID_COLUMN10,
                returnType: "Select Type"))
            
            countItemAdded += 1
            setCountLabel(c: countItemAdded)
            AlertMessage().showAlertForXTime(alertTitle: "Invoice has been Added".localize(), time: 0.5, tagert: self)
        }
    }
    
    func addItemAndUpdateOldValues(invoiceDateTExt: String, invoiceNoText: String, itemNoText: String){
        addItem()
        oldValuesArray.append(oldValue(invoiceDate: invoiceDateTExt, invoiceNumber: invoiceNoText, itemNumber: itemNoText))
    }
}

extension AddReturnInvoiceViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerView == invoicePickerView{
            invoiceTextField.text = invoiceNameArray[invoiceSelectedRow]
            
            itemArray = webservice.SRR_BindItemsonChangeofInvoice(invoicenumber: invoiceNameArray[invoiceSelectedRow])
            itemNameArray = [" "]
            for item in itemArray{
                itemNameArray.append(item.Items)
            }
            itemTextField.text = itemNameArray[0]
            showInvoicePickerView.resignFirstResponder()
        } else {
            itemTextField.text = itemNameArray[itemSelectedRow]
            showItemPickerView.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerView == invoicePickerView{
            showInvoicePickerView.resignFirstResponder()
        } else {
            showItemPickerView.resignFirstResponder()
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        date = getStringDate(date: sender.date)
        invoiceDateTextField.text = getStringDate(date: sender.date)
    }
    
    @objc func datePickerDoneClick(){
        var selectedDate = ""
        if date.isEmpty{
            invoiceDateTextField.text = getStringDate(date: currentDate)
            selectedDate = getStringDate(date: currentDate)
        } else {
            selectedDate = date
        }
        
        invoiceArray = webservice.SRR_BindInvoice(salesperson_id: returnOrderRequestDetails.salespersonId, customernumber: returnOrderRequestDetails.customerId, invoice_date: selectedDate)
        
        invoiceTextField.text = invoiceNameArray[0]
        itemTextField.text = itemNameArray[0]
        
        returnOrderRequestDetails.isStoreArrayNotEmptyAndStoreSelectionEmpty = true
        
        for invoice in invoiceArray{
            invoiceNameArray.append(invoice.Sop_Number)
        }
        
        storeArrayReceived = storeArray
        creditDetailsArrayReceived = creditDetailsArray
        returnOrderRequestDetails.setStoreDefaultValues()
        StoreAndCreditTableView.reloadData()
        invoiceDateTextField.resignFirstResponder()
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
        if pickerView == invoicePickerView{
            return invoiceNameArray.count
        } else {
            return itemNameArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerView  = pickerView
        if pickerView == invoicePickerView{
            return invoiceNameArray[row]
        } else {
            return itemNameArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == invoicePickerView{
            invoiceSelectedRow = row
            itemSelectedRow = 0
        } else {
            itemSelectedRow = row
        }
    }
}

extension AddReturnInvoiceViewController: UITableViewDelegate, UITableViewDataSource{
    // -- Mark: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeAndCreditArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? StoreAndCreditCell{
            cell.textLabel?.text = storeAndCreditArray[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            performSegue(withIdentifier: "showStoreDetailsOfReturn", sender: nil)
        } else if indexPath.row == 1{
            performSegue(withIdentifier: "showCreditDetailsOfReturn", sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if storeArray.isEmpty { return 0  }
        } else if indexPath.row == 1 {
            if creditDetailsArray.isEmpty { return 0 }
        }
        
        if storeArrayReceived.isEmpty && creditDetailsArrayReceived.isEmpty { StoreAndCreditTableView.isHidden = true }
        else { StoreAndCreditTableView.isHidden = false }
        
        return 44
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStoreDetailsOfReturn" {
            if let vc = segue.destination as? ReturnStoreViewController{
                vc.storeArray = self.storeArray
            }
        } else if segue.identifier == "showCreditDetailsOfReturn" {
            if let vc = segue.destination as? ReturnCreditDetailsViewController{
                vc.creditDetailsArray = self.creditDetailsArray
            }
        }
    }
}

extension AddReturnInvoiceViewController{
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
