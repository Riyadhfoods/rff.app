//
//  PromotionRequestViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class PromotionRequestViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var supplierNo: UITextField!
    @IBOutlet weak var promotionTypeTextField: UITextField!
    @IBOutlet weak var showPromotionPickerTextField: UITextField!
    @IBOutlet weak var customerClassTextField: UITextField!
    @IBOutlet weak var showCutomerClassPickerTextField: UITextField!
    @IBOutlet weak var customerTextField: UITextField!
    @IBOutlet weak var showCustomerPickerTextField: UITextField!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var showItemPickerTextField: UITextField!
    @IBOutlet weak var uofmTextField: UITextField!
    @IBOutlet weak var showUofmPickerTextField: UITextField!
    @IBOutlet weak var profitMarginTextField: UITextField!
    @IBOutlet weak var showProfitMarginPickerTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var priceBefore: UITextField!
    @IBOutlet weak var offerPrice: UITextField!
    @IBOutlet weak var discountAmount: UITextField!
    @IBOutlet weak var discountPercent: UITextField!
    @IBOutlet weak var forecastQty: UITextField!
    @IBOutlet weak var othaimStockQty: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let fromDatePicker = UIDatePicker()
    let toDatePicker = UIDatePicker()
    var textField = UITextField()
    var fromDateString: String = ""
    var toDateString: String = ""
    
    var pickerView = UIPickerView()
    var promotionTypePickerView = UIPickerView()
    var customerClassPickerView = UIPickerView()
    var customerPickerView = UIPickerView()
    var itemPickerView = UIPickerView()
    var uofmPickerView = UIPickerView()
    var profitMarginPickerView = UIPickerView()
    
    var promotionTypeArray = ["Select promotion type"]
    var customerClassArray = ["Select cutomer class"]
    var customerArray = ["Select customer"]
    var itemArray = ["Select item"]
    var uofmArray = ["Select UofM"]
    var profitMarginArray = ["Select Profit Margin"]
    
    var promotionTypeRowSelected = 0
    var customerClassRowSelected = 0
    var customerRowSelected = 0
    var itemRowSelected = 0
    var uofmRowSelected = 0
    var profitMarginRowSelected = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    // -- MARK: SetUps
    
    func setUpViews(){
        fromDate.delegate = self
        fromDate.tintColor = .clear
        toDate.delegate = self
        toDate.tintColor = .clear
        supplierNo.delegate = self
        
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showPromotionPickerTextField.tintColor = .clear
        showCutomerClassPickerTextField.tintColor = .clear
        showCustomerPickerTextField.tintColor = .clear
        showItemPickerTextField.tintColor = .clear
        showUofmPickerTextField.tintColor = .clear
        showProfitMarginPickerTextField.tintColor = .clear
        
        priceBefore.delegate = self
        offerPrice.delegate = self
        discountAmount.delegate = self
        discountPercent.delegate = self
        forecastQty.delegate = self
        othaimStockQty.delegate = self
        
        commentTextView.delegate = self
        
        setUpDatePicker()
        setupPickerView()
        setUpCommentDisplay()
    }
    
    func setUpCommentDisplay(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    // -- MARK: Handle TextField
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
     // -- MARK: IBOAction
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
}

// -- MARK: Date Picker

extension PromotionRequestViewController{
    func setUpDatePicker(){
        PickerviewAction().showDatePicker(txtfield: fromDate, datePicker: fromDatePicker, title: "From Date", viewController: self, datePickerSelector: #selector(handleDatePickerSelection(sender:)), doneSelector:  #selector(doneToolBarButtonTapped(sender:)))
        PickerviewAction().showDatePicker(txtfield: toDate, datePicker: toDatePicker, title: "To Date", viewController: self, datePickerSelector: #selector(handleDatePickerSelection(sender:)), doneSelector:  #selector(doneToolBarButtonTapped(sender:)))
    }
    
    @objc func handleDatePickerSelection(sender: UIDatePicker){
        if sender == fromDatePicker{
            fromDateString = getStringDate(date: sender.date)
            fromDate.text = fromDateString
        } else {
            toDateString = getStringDate(date: sender.date)
            toDate.text = toDateString
        }
    }
    
    @objc func doneToolBarButtonTapped(sender: UIDatePicker){
        if textField == fromDate{
            if fromDateString.isEmpty{
                fromDate.text = getStringDate(date: Date())
            }
            fromDate.resignFirstResponder()
        } else {
            if toDateString.isEmpty{
                toDate.text = getStringDate(date: Date())
            }
            toDate.resignFirstResponder()
        }
    }
    
    func getStringDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

extension PromotionRequestViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    // -- MARK: PickerView Setup
    
    func setupPickerView(){
        PickerviewAction().showPickView(
            txtfield: showPromotionPickerTextField,
            pickerview: promotionTypePickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTappedForPickerView),
            doneSelector: #selector(doneToolBarButtonTappedForPickerView))
        
        PickerviewAction().showPickView(
            txtfield: showCutomerClassPickerTextField,
            pickerview: customerClassPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTappedForPickerView),
            doneSelector: #selector(doneToolBarButtonTappedForPickerView))
        
        PickerviewAction().showPickView(
            txtfield: showCustomerPickerTextField,
            pickerview: customerPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTappedForPickerView),
            doneSelector: #selector(doneToolBarButtonTappedForPickerView))
        
        PickerviewAction().showPickView(
            txtfield: showItemPickerTextField,
            pickerview: itemPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTappedForPickerView),
            doneSelector: #selector(doneToolBarButtonTappedForPickerView))
        
        PickerviewAction().showPickView(
            txtfield: showUofmPickerTextField,
            pickerview: uofmPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTappedForPickerView),
            doneSelector: #selector(doneToolBarButtonTappedForPickerView))
        
        PickerviewAction().showPickView(
            txtfield: showProfitMarginPickerTextField,
            pickerview: profitMarginPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTappedForPickerView),
            doneSelector: #selector(doneToolBarButtonTappedForPickerView))
    }
    
    // -- MARK: PickerView Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == promotionTypePickerView{ return promotionTypeArray.count }
        else if pickerView == customerClassPickerView{ return customerClassArray.count }
        else if pickerView == customerPickerView{ return customerArray.count }
        else if pickerView == itemPickerView{ return itemArray.count }
        else if pickerView == uofmPickerView{ return uofmArray.count }
        return profitMarginArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerView = pickerView
        if pickerView == promotionTypePickerView{
            promotionTypeRowSelected = row
            return promotionTypeArray[row]
        } else if pickerView == customerClassPickerView{
            customerClassRowSelected = row
            return customerClassArray[row]
        } else if pickerView == customerPickerView{
            customerRowSelected = row
            return customerArray[row]
        } else if pickerView == itemPickerView{
            itemRowSelected = row
            return itemArray[row]
        } else if pickerView == uofmPickerView{
            uofmRowSelected = row
            return uofmArray[row]
        }
        profitMarginRowSelected = row
        return profitMarginArray[row]
    }
    
    // -- MARK: objc Functions
    
    @objc func doneToolBarButtonTappedForPickerView(){
        if pickerView == promotionTypePickerView{
            promotionTypeTextField.text = promotionTypeArray[promotionTypeRowSelected]
            showPromotionPickerTextField.resignFirstResponder()
        } else if pickerView == customerClassPickerView{
            customerClassTextField.text = customerClassArray[customerClassRowSelected]
            showCutomerClassPickerTextField.resignFirstResponder()
        } else if pickerView == customerPickerView{
            customerTextField.text = customerArray[customerRowSelected]
            showCustomerPickerTextField.resignFirstResponder()
        } else if pickerView == itemPickerView{
            itemTextField.text = itemArray[itemRowSelected]
            showItemPickerTextField.resignFirstResponder()
        } else if pickerView == uofmPickerView{
            uofmTextField.text = uofmArray[uofmRowSelected]
            showUofmPickerTextField.resignFirstResponder()
        } else {
            profitMarginTextField.text = profitMarginArray[profitMarginRowSelected]
            showProfitMarginPickerTextField.resignFirstResponder()
        }
    }
    
    @objc func cancelToolBarButtonTappedForPickerView(){
        if pickerView == promotionTypePickerView{ showPromotionPickerTextField.resignFirstResponder() }
        else if pickerView == customerClassPickerView{ showCutomerClassPickerTextField.resignFirstResponder() }
        else if pickerView == customerPickerView{ showCustomerPickerTextField.resignFirstResponder() }
        else if pickerView == itemPickerView{ showItemPickerTextField.resignFirstResponder() }
        else if pickerView == uofmPickerView{ showUofmPickerTextField.resignFirstResponder() }
        else { showProfitMarginPickerTextField.resignFirstResponder() }
    }
    
}

extension PromotionRequestViewController{
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











