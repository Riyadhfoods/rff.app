//
//  AddReturnInvoiceViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

struct InvoicesModel {
    var invoiceDate: String = ""
    var invoice: String = ""
    var item: String = ""
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
    
    @IBOutlet weak var StoreAndCreditTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
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
    var isThereStore = false
    var isThereCreditLimit = false
    
    var storeArray = [SalesModel]()
    var creditDetailsArray = [SalesReturn]()
    var invoiceArray = [SalesReturn]()
    let cellId = "cell_storeAndCredit"
    let storeAndCreditArray = ["Store Details", "Credit Limmit Details"]
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showInvoicePickerView.tintColor = .clear
        showItemPickerView.tintColor = .clear
        
        StoreAndCreditTableView.delegate = self
        StoreAndCreditTableView.dataSource = self
        StoreAndCreditTableView.isHidden = true
        
        setViewAlignment()
        setUpCommentDisplay()
        setupDatePicker()
        setupPickerView()
        
        setupArrays()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialValues()
    }
    
    // -- MARK: Set ups
    
    func setupArrays(){
        invoiceNameArray = ["Select invoce"]
        itemNameArray = [" "]
        
        storeArray = webservice.BindDdlStore(customerid: returnOrderRequestDetails.customer)
        isThereStore = !storeArray.isEmpty
        
        creditDetailsArray = webservice.SRR_BindCustomerAging(customer_no: returnOrderRequestDetails.customer)
        isThereCreditLimit = !creditDetailsArray.isEmpty
    }
    
    func initialValues(){
        invoiceTextField.text = invoiceNameArray[0]
        itemTextField.text = itemNameArray[0]
    }
    
    func setUpCommentDisplay(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showInvoicePickerView, pickerview: invoicePickerView, viewController: self, cancelSelector: #selector(doneClick), doneSelector: #selector(cancelClick))
        PickerviewAction().showPickView(txtfield: showItemPickerView, pickerview: itemPickerView, viewController: self, cancelSelector: #selector(doneClick), doneSelector: #selector(cancelClick))
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
        //performSegue(withIdentifier: "showItemSelected", sender: nil)
        print(returnOrderRequestDetails)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        if let invoiceDateText = invoiceDateTextField.text, let invoiceText = invoiceTextField.text, let itemText = itemTextField.text{
//            if invoiceDateText.isEmpty || invoiceText.isEmpty || itemText.isEmpty{
//                AlertMessage().showAlertMessage(alertTitle: "Alert", alertMessage: "You did not fill invoice date or did not select invoice or item", actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
//            } else {
//                invoiceArray.append(InvoicesModel(invoiceDate: invoiceDateText, invoice: invoiceText, item: itemText))
//                returnOrderRequestDetails.invoicesArray = invoices
//            }
            invoices.append(InvoicesModel(invoiceDate: invoiceDateText, invoice: invoiceText, item: itemText))
            returnOrderRequestDetails.invoicesArray = invoices
            print(invoices)
        }
    }
    
}

extension AddReturnInvoiceViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerView == invoicePickerView{
            showInvoicePickerView.resignFirstResponder()
        } else {
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
        if date.isEmpty{
            invoiceDateTextField.text = getStringDate(date: currentDate)
            
            invoiceArray = webservice.SRR_BindInvoice(salesperson_id: returnOrderRequestDetails.salespersonId, customernumber: returnOrderRequestDetails.companyId, invoice_date: getStringDate(date: currentDate))
            invoiceTextField.text = invoiceNameArray[0]
            for invoice in invoiceArray{
                invoiceNameArray.append(invoice.Sop_Number)
            }
            
            StoreAndCreditTableView.isHidden = false
            StoreAndCreditTableView.reloadData()
        }
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
        if !isThereStore{
            if indexPath.row == 0 {
                tableViewHeight.constant = 44
                return 0
            }
        } else if !isThereCreditLimit{
            if indexPath.row == 1 {
                tableViewHeight.constant = 44
                return 0
            }
        } else {
            tableViewHeight.constant = 88
        }
        
        if !isThereStore && !isThereCreditLimit { StoreAndCreditTableView.isHidden = true }
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
