//
//  SalesPersonViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesPersonViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var salespersonTextfield: UITextField!
    @IBOutlet weak var showsalespersonPickerViewTextfield: UITextField!
    @IBOutlet weak var customerTextfield: UITextField!
    @IBOutlet weak var showcustomerPickerViewTextfield: UITextField!
    @IBOutlet weak var deliveryDateTextfield: UITextField!
    
    @IBOutlet weak var selectorSuperMarketYes: UIView!
    @IBOutlet weak var selectorSuperMarketNo: UIView!
    @IBOutlet weak var innerSelectorSuperMarketYes: UIView!
    @IBOutlet weak var innerSelectorSuperMarketNo: UIView!
    @IBOutlet weak var superMarketYesButton: UIButton!
    @IBOutlet weak var superMarketNoButton: UIButton!
    
    @IBOutlet weak var selectorOfferYes: UIView!
    @IBOutlet weak var selectorOfferNo: UIView!
    @IBOutlet weak var innerSelectorOfferYes: UIView!
    @IBOutlet weak var innerSelectorOfferNo: UIView!
    @IBOutlet weak var offerYesButton: UIButton!
    @IBOutlet weak var offerNoButton: UIButton!
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let screenSize = AppDelegate().screenSize
    let salespersonPickerView: UIPickerView = UIPickerView()
    let customerPickerView: UIPickerView = UIPickerView()
   
    var salespersonTextChosen: String?
    var customerTextChosen: String?
    var salespersonArray = [SalesModel]()
    var customerArray = [SalesModel]()
    var salespersonNamesArray = [String]()
    var customerNamesArray = [String]()
    var selectedRow: Int = 0
    
    let deliveryDatePickerView: UIDatePicker = UIDatePicker()
    let currentDate = Date()
    
    var offer: Bool = false
    var supermarket: Bool = false
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Salesperson Details".localize()
        
        stackviewWidth.constant = screenSize.width - 32
        setbackNavTitle(navItem: navigationItem)
        
        showsalespersonPickerViewTextfield.tintColor = .clear
        showcustomerPickerViewTextfield.tintColor = .clear
        deliveryDateTextfield.tintColor = .clear
        deliveryDateTextfield.text = ""
        
        setupArrays()
        setUpWidth()
        setUpPickerView()
        setUpSelectors()
        setupDatePicker()
        setViewAlignment()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Set ups
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setupArrays(){
        //salespersonArray = webservice.BindSalesOrderSalesPerson()
        for salespreson in salespersonArray{
            salespersonNamesArray.append(salespreson.SalesPerson)
        }
        customerNamesArray = ["Select customer".localize()]
        
        if salespersonArray.isEmpty{
            salespersonTextfield.text = "No salespreson aviable".localize()
        } else {
            salespersonTextfield.text = salespersonNamesArray[0]
            getCustomers(salesperson: salespersonNamesArray[0])
        }
    }
    
    func getCustomers(salesperson: String){
        customerArray = webservice.BindSalesOrderCustomers(salesperson: salesperson)
        if customerArray.isEmpty {
            customerNamesArray = ["Select customer".localize()]
        } else {
            customerNamesArray = ["Select customer".localize()]
            for customer in customerArray{
                customerNamesArray.append(customer.CustomerName)
            }
        }
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showsalespersonPickerViewTextfield, pickerview: salespersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showcustomerPickerViewTextfield, pickerview: customerPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
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
        
        selectorOfferYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorOfferNo.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorOfferYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorOfferNo.layer.cornerRadius = cornerRadiusValueInner
        
        offerYesButton.layer.cornerRadius = cornerRadiusValueView
        offerYesButton.backgroundColor = .white
        offerNoButton.layer.cornerRadius = cornerRadiusValueView
        offerNoButton.backgroundColor = mainBackgroundColor
    }
    
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: deliveryDateTextfield, datePicker: deliveryDatePickerView, title: "Delivery Date".localize(), viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    var date: String = ""
    @objc func handleDatePicker(sender: UIDatePicker){
        date = getStringDate(date: sender.date)
        deliveryDateTextfield.text = getStringDate(date: sender.date)
    }
    
    func getStringDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == salespersonPickerView{
            salespersonTextfield.text = salespersonNamesArray[selectedRow].localize()
            showsalespersonPickerViewTextfield.resignFirstResponder()
        } else {
            customerTextfield.text = customerNamesArray[selectedRow].localize()
            showcustomerPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == salespersonPickerView{
            showsalespersonPickerViewTextfield.resignFirstResponder()
        } else {
            showcustomerPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func datePickerDoneClick(){
        if date.isEmpty{
            deliveryDateTextfield.text = getStringDate(date: currentDate)
        }
        deliveryDateTextfield.resignFirstResponder()
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == salespersonPickerView{
            return salespersonNamesArray.count
        }
        return customerNamesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == salespersonPickerView{
            return salespersonNamesArray[row].localize()
        }
        return customerNamesArray[row].localize()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        if pickerView == salespersonPickerView{
            getCustomers(salesperson: salespersonNamesArray[row])
            customerTextfield.text = customerNamesArray[0].localize()
        }
    }
    
    // -- MARK: IBActions
    
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
    
    @IBAction func offerYesButtonTapped(_ sender: Any) {
        offerYesButton.backgroundColor = mainBackgroundColor
        offerNoButton.backgroundColor = .white
        
        offer = true
    }
    
    @IBAction func offerNoButtonTapped(_ sender: Any) {
        offerYesButton.backgroundColor = .white
        offerNoButton.backgroundColor = mainBackgroundColor
        
        offer = false
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let salespersonText = salespersonTextfield.text, let customerText = customerTextfield.text, let deliveryDate = deliveryDateTextfield.text{
            if customerText == customerNamesArray[0] || deliveryDate.isEmpty{
                let alertTitle = "Alert!".localize()
                let alertMessage = "You did not select a customer or delivery date".localize()
                AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "OK", onAction: {
                    return
                }, cancelAction: nil, self)
            }
            salesOrderRequestDetails.salesperson = salespersonText
            salesOrderRequestDetails.customer = customerText
            salesOrderRequestDetails.deliverydate = deliveryDate
            salesOrderRequestDetails.supermarket = supermarket
            salesOrderRequestDetails.offer = offer
        }
        
        let storeArray = webservice.BindDdlStore(customerid: salesOrderRequestDetails.customer)
        if storeArray.isEmpty{
            performSegue(withIdentifier: "skipToAddItem", sender: nil)
        } else {
            performSegue(withIdentifier: "showStoreDetails", sender: nil)
        }
    }
}

extension SalesPersonViewController{
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





