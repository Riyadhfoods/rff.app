//
//  AddReturnInvoiceViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var uploadFileBtn: UIButton!
    
    // -- MARK: Variables
    
    var invoiceDatePicker: UIDatePicker = UIDatePicker()
    var invoicePickerView: UIPickerView = UIPickerView()
    var itemPickerView: UIPickerView = UIPickerView()
    var pickerView: UIPickerView = UIPickerView()
    var invoiceNameArray: [String] = [String]()
    var itemNameArray: [String] = [String]()
    
    var datePicker = UIDatePicker()
    let currentDate = Date()
    var date: String = ""
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showInvoicePickerView.tintColor = .clear
        showItemPickerView.tintColor = .clear
        
        setViewAlignment()
        setUpCommentDisplay()
        setupArrays()
        setupDatePicker()
        setupPickerView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
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
        
        uploadFileBtn.layer.borderWidth = 1
        uploadFileBtn.layer.borderColor = AppDelegate().mainBackgroundColor.cgColor
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
    
    // -- MARK: objc functions
    
    
    
    // -- MARK: IBActions

    @IBAction func showItemButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showItemSelected", sender: nil)
    }
    
    @IBAction func uploadFileButtonTapped(_ sender: Any) {
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
