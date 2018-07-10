//
//  SalesOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

struct ItemsModul {
    var grid_error: String = ""
    var Grid_ItemId: String = ""
    var Grid_Desc: String = ""
    var Grid_UOM: String = ""
    var Grid_Qty: String = ""
    var Grid_UnitPrice: String = ""
    var Grid_TotalPrice: String = ""
    
    init(grid_error: String, Grid_ItemId: String, Grid_Desc: String, Grid_UOM: String, Grid_Qty: String, Grid_UnitPrice: String, Grid_TotalPrice: String){
        self.grid_error = grid_error
        self.Grid_ItemId = Grid_ItemId
        self.Grid_Desc = Grid_Desc
        self.Grid_UOM = Grid_UOM
        self.Grid_Qty = Grid_Qty
        self.Grid_UnitPrice = Grid_UnitPrice
        self.Grid_TotalPrice = Grid_TotalPrice
    }
}

var itemAddedArray = [ItemsModul]()
var customerGlobal = ""
var locCodeGlobal = ""

class SalesOrderRequestsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var showCompanyPickerViewTextfield: UITextField!
    @IBOutlet weak var branchTextfield: UITextField!
    @IBOutlet weak var showBranchPickerViewTextfield: UITextField!
    @IBOutlet weak var docIdTextfield: UITextField!
    @IBOutlet weak var showDocIdPickerViewTextfield: UITextField!
    @IBOutlet weak var LocCodeTextfield: UITextField!
    @IBOutlet weak var showLocCodePickerViewTextfield: UITextField!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    @IBOutlet weak var storeStackView: UIStackView!
    @IBOutlet weak var storeTextfield: UITextField!
    @IBOutlet weak var showStorePickerViewTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var showCityPickerViewTextfield: UITextField!
    @IBOutlet weak var salesPersonTextfield: UITextField!
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
    
    @IBOutlet weak var itemsTextfield: UITextField!
    @IBOutlet weak var showItemsPickerViewTextfield: UITextField!
    @IBOutlet weak var unoitTextfield: UITextField!
    @IBOutlet weak var showUnoitPickerViewTextfield: UITextField!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var commentTextview: UITextView!
    
    @IBOutlet weak var itemButtonOutlet: UIBarButtonItem!
    
    // -- MARK: Variable
    
    let webservice = Sales()
    let screenSize = AppDelegate().screenSize
    
    let companyPickerView: UIPickerView = UIPickerView()
    let branchPickerView: UIPickerView = UIPickerView()
    let docIdPickerView: UIPickerView = UIPickerView()
    let LocCodePickerView: UIPickerView = UIPickerView()
    let salespersonPickerView: UIPickerView = UIPickerView()
    let customerPickerView: UIPickerView = UIPickerView()
    let storePickerView: UIPickerView = UIPickerView()
    let cityPickerView: UIPickerView = UIPickerView()
    let salesPersonStorePickerView: UIPickerView = UIPickerView()
    let merchandiserPickerView: UIPickerView = UIPickerView()
    let itemsPickerView: UIPickerView = UIPickerView()
    let unoitPickerView: UIPickerView = UIPickerView()
    
    var companyTextChosen: String?
    var branchTextChosen: String?
    var docIdTextChosen: String?
    var LocCodeTextChosen: String?
    var salespersonTextChosen: String?
    var customerTextChosen: String?
    var storeTextChosen: String?
    var cityTextChosen: String?
    var salesPersonTextChosen: String?
    var merchandiserTextChosen: String?
    
    var companyArray = [SalesModel]()
    var companyNamesArray = [String]()
    var companyIdArray = [String]()
    var branchArray = [SalesModel]()
    var branchNamesArray = [String]()
    var branchIdArray = [String]()
    var docIdArray = [String]()
    var locCodeArray = [SalesModel]()
    var locCodeNumsArray = [String]()
    
    var salespersonArray = [SalesModel]()
    var customerArray = [SalesModel]()
    var salespersonNamesArray = [String]()
    var customerNamesArray = [String]()
    
    var storeArray = [SalesModel]()
    var storeIdArray = [String]()
    var cityArray = [SalesModel]()
    var salesPersonArray = [SalesModel]()
    var merchandiserArray = [SalesModel]()
    
    var creditDetailsArray = [SalesModel]()
    var items = [SalesModel]()
    var itemsName = [String]()
    var unoits = [SalesModel]()
    var unoitsName = [String]()
    var itemAddedReceived = [ItemAddedModel]()
    
    let deliveryDatePickerView: UIDatePicker = UIDatePicker()
    let currentDate = Date()
    var date: String = ""
    var offer: Bool = false
    var supermarket: Bool = false
    var isThereStoreId: Bool = true
    
    var selectedRowForCompany: Int = 0
    var selectedRowForBranch: Int = 0
    var selectedRowForLocCode: Int = 0
    
    var selectedRowForSalesPerson: Int = 0
    var selectedRowForCustomer: Int = 0
    
    var salesSelecteedRow: Int = 0
    var citySelectedRow: Int = 0
    var salesperosnSelectedRow: Int = 0
    var merSelectedRow: Int = 0
    var itemSelectedRow: Int = 0
    var uofmSelectedRow: Int = 0
    
    var count: Int = 0
    
    var itemSentStatus = [SalesModel]()
    var sentStatus = [SalesModel]()
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    let languageChosen = LoginViewController.languageChosen
    var emp_id: String = ""
    var table: Bool = false
    var flag: Bool = false
    
    var error = ""
    var orderId = ""
    
    var textField = UITextField()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        
        if let userId = AuthServices.currentUserId{
            emp_id = userId
        }
        
        setupView()
        setUpPickerView()
        setupDatePicker()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if companyArray.isEmpty && branchArray.isEmpty && locCodeArray.isEmpty && salespersonArray.isEmpty{
            setupAarray()
        }
        if !itemAddedArray.isEmpty{
            count = itemAddedArray.count
        }
        setCountLabel(c: count)
        activityIndicator.stopAnimating()
    }
    
    func setUpSalesOrderData(){
        companyArray = webservice.BindSalesOrderCompany()
        branchArray = webservice.BindSalesOrderBranches()
        locCodeArray = webservice.BindSalesOrderLocCode()
        salespersonArray = webservice.BindSalesOrderSalesPerson()
    }
    
    // -- MARK: Set ups
    
    func setupView(){
        stackViewWidth.constant = screenSize.width - 32
        setCustomDefaultNav(navItem: navigationItem)
        
        showCompanyPickerViewTextfield.tintColor = .clear
        showBranchPickerViewTextfield.tintColor = .clear
        showDocIdPickerViewTextfield.tintColor = .clear
        showLocCodePickerViewTextfield.tintColor = .clear
        showsalespersonPickerViewTextfield.tintColor = .clear
        showcustomerPickerViewTextfield.tintColor = .clear
        deliveryDateTextfield.tintColor = .clear
        deliveryDateTextfield.text = ""
        showStorePickerViewTextfield.tintColor = .clear
        showCityPickerViewTextfield.tintColor = .clear
        showSalesPersonPickerViewTextfield.tintColor = .clear
        showMerchandiserPickerViewTextfield.tintColor = .clear
        
        viewHolder.layer.cornerRadius = 5.0
        viewHolder.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        viewHolder.layer.borderWidth = 1
        
        showItemsPickerViewTextfield.tintColor = .clear
        showUnoitPickerViewTextfield.tintColor = .clear
        commentTextview.text = ""
        commentTextview.delegate = self
        deliveryDateTextfield.delegate = self
        qtyTextfield.delegate = self
        
        companyNamesArray = ["Select company".localize()]
        branchNamesArray = ["Select branch".localize()]
        docIdArray = ["SRFC"]
        locCodeNumsArray = ["Select location code".localize()]
        customerNamesArray = ["Select customer".localize()]
        salespersonNamesArray = ["Select salesperson".localize()]
        storeIdArray = ["Select store id".localize()]
        
        setUpKeyboardToolBar(textfield: qtyTextfield, viewController: self, cancelTitle: nil, cancelSelector: nil, doneTitle: "Done", doneSelector: #selector(doneButtonClick))
        
        setUpSelectors()
        setUpCommentDisplay()
        activityIndicator.startAnimating()
    }
    
    func setupAarray(){
        setUpSalesOrderData()
        
        for company in companyArray{
            companyNamesArray.append(company.EName)
            companyIdArray.append(company.Comp_ID)
        }
        for branch in branchArray{
            branchNamesArray.append(branch.Branch)
            branchIdArray.append(branch.AccountEmp)
        }
        for locCode in locCodeArray{
            locCodeNumsArray.append(locCode.LocationCode)
        }
        for salespreson in salespersonArray{
            salespersonNamesArray.append(salespreson.SalesPerson)
        }
        
        initalvalue()
    }
    
    func initalvalue(){
        if !companyArray.isEmpty{
            companyTextfield.text = companyNamesArray[1]
        } else  { companyTextfield.text = companyNamesArray[0] }
        branchTextfield.text = branchNamesArray[0]
        docIdTextfield.text = docIdArray[0]
        LocCodeTextfield.text = locCodeNumsArray[0]
        if salespersonArray.isEmpty{
            salespersonTextfield.text = salespersonNamesArray[0]
        } else {
            salespersonTextfield.text = salespersonNamesArray[1]
            getCustomers(salesperson: salespersonNamesArray[1])
        }
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
        superMarketNoButton.layer.cornerRadius = cornerRadiusValueView
        
        selectorOfferYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorOfferNo.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorOfferYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorOfferNo.layer.cornerRadius = cornerRadiusValueInner
        
        offerYesButton.layer.cornerRadius = cornerRadiusValueView
        offerNoButton.layer.cornerRadius = cornerRadiusValueView
        
        setUpDefaultSelector()
    }
    
    func setUpDefaultSelector(){
        offer = false
        supermarket = false
        superMarketYesButton.backgroundColor = .white
        superMarketNoButton.backgroundColor = mainBackgroundColor
        offerYesButton.backgroundColor = .white
        offerNoButton.backgroundColor = mainBackgroundColor
    }
    
    func setCountLabel(c: Int){
        itemButtonOutlet.title = "Items (".localize() + "\(c))"
    }
    
    func setUpCommentDisplay(){
        commentTextview.layer.cornerRadius = 5.0
        commentTextview.layer.borderColor = mainBackgroundColor.cgColor
        commentTextview.layer.borderWidth = 1
    }
    
    func setUpDefaultValueFromStoreToQty(){
        storeTextfield.text = storeIdArray[0]
        cityTextfield.text = "Select city"
        salesPersonTextfield.text = "Select sales person"
        merchandiserTextfield.text = "Select merchandiser"
        itemsTextfield.text = "Select item"
        unoitTextfield.text = "Select unoit of measure"
        qtyTextfield.text = "1"
    }
    
    func setDeaultValueForArrays(){
        storeArray.removeAll()
        storeIdArray = ["Select store id".localize()]
        storeStackView.isHidden = true
        creditDetailsArray.removeAll()
        viewHolder.isHidden = true
        items.removeAll()
        itemsName = ["Select item".localize()]
        unoits.removeAll()
    }
    
    // -- MARK: objc Functions
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func doneButtonClick(){
        if textField == qtyTextfield{
            qtyTextfield.resignFirstResponder()
        }
    }
    
    // -- MARK: Helper Functions
    
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
    
    func getStoreId(customerId: String){
        storeArray = webservice.BindDdlStore(customerid: customerId)
        if storeArray.isEmpty {
            storeIdArray = ["Select store id".localize()]
            storeStackView.isHidden = true
        } else {
            storeStackView.isHidden = false
            storeIdArray = ["Select store id".localize()]
            for store in storeArray{
                storeIdArray.append(store.StoreID)
            }
        }
    }
    
    func getCreditDetails(customerId: String){
        creditDetailsArray = webservice.BindCustomerAgingGV(cutomerid: customerId)
        if creditDetailsArray.isEmpty{
            viewHolder.isHidden = true
        } else {
            viewHolder.isHidden = false
            creditLimitRight.text = creditDetailsArray[0].CreditLimit
            totalDueRight.text = creditDetailsArray[0].ToTalDue
            upTo31Right.text = creditDetailsArray[0].ZEROTO31days
            upTo60Right.text = creditDetailsArray[0].ThirtyOneTo60Days
            upTo90Right.text = creditDetailsArray[0].SIXTYOneTo90Days
            upTo120Right.text = creditDetailsArray[0].NINETYOneTo120Days
            moreThan90Right.text = creditDetailsArray[0].Above120DAYS
            statusRight.text = creditDetailsArray[0].CustomerAgying_Status
        }
    }
    
    func getItems(customerId: String){
        items = webservice.BindSalesOrderItems(customerid: customerId)
        if customerArray.isEmpty {
            itemsName = ["Select item".localize()]
        } else {
            itemsName = ["Select item".localize()]
            for item in items{
                itemsName.append(item.DrpItems)
            }
        }
    }
    
    // -- MARK: IBAction
    
    @IBAction func itemButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showItemAddedList", sender: nil)
    }
    
    struct oldValue {
        var name = ""
        var uofm = ""
        var qty = ""
    }
    
    var oldItemName = ""
    var oldItemUofm = ""
    var oldItemQty = ""
    var oldValuesArray = [oldValue]()
    var isItemExist = false
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        if let itemText = itemsTextfield.text, let unoitText = unoitTextfield.text, let qtyText = qtyTextfield.text{
            itemAddedReceived = webservice.BindPurchaseGridData(quantity: qtyText, quantityrequired: 0.0, ItemId: itemText, unitofmeasure: unoitText, customerid: customerNamesArray[selectedRowForCustomer], loccode: locCodeNumsArray[selectedRowForLocCode])
            
            if unoitText == "Select unoit of measure".localize(){
                AlertMessage().showAlertMessage(alertTitle: "Alert!".localize(), alertMessage: "You did not select a unit of measure".localize(), actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
                return
            }
            
            if oldValuesArray.isEmpty {
                addItemAndUpdateOldValues(itemText: itemText, unoitText: unoitText, qtyText: qtyText)
            } else {
                for value in oldValuesArray{
                    if value.name == itemText && value.uofm == unoitText && value.qty == qtyText{
                        isItemExist = true
                        break
                    }
                }
                if isItemExist{
                    AlertMessage().showAlertMessage(alertTitle: "Item has been Added".localize(), alertMessage: "You have already added this item. Do you wnat to add it again".localize(), actionTitle: "Yes".localize(), onAction: {
                        self.addItem(itemText: itemText, unoitText: unoitText, qtyText: qtyText)
                    }, cancelAction: "No".localize(), self)
                    isItemExist = false
                } else {
                    addItemAndUpdateOldValues(itemText: itemText, unoitText: unoitText, qtyText: qtyText)
                }
            }
        }
    }
    
    func addItem(itemText: String, unoitText: String, qtyText: String){
        for item in itemAddedReceived{
            if item.grid_error != ""{
                warningLabel.isHidden = false
                warningLabel.text = item.grid_error
                return
            }
            itemAddedArray.append(
                ItemsModul(
                    grid_error: item.grid_error,
                    Grid_ItemId: item.Grid_ItemId,
                    Grid_Desc: itemText,
                    Grid_UOM: unoitText,
                    Grid_Qty: qtyText,
                    Grid_UnitPrice: item.Grid_UnitPrice,
                    Grid_TotalPrice: item.Grid_TotalPrice))
        }
        warningLabel.isHidden = true
        count += 1
        setCountLabel(c: count)
        AlertMessage().showAlertForXTime(alertTitle: "Item has been Added".localize(), time: 0.5, tagert: self)
    }
    
    func addItemAndUpdateOldValues(itemText: String, unoitText: String, qtyText: String){
        addItem(itemText: itemText, unoitText: unoitText, qtyText: qtyText)
        oldValuesArray.append(oldValue(name: itemText, uofm: unoitText, qty: qtyText))
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let companyText = companyTextfield.text,
            let branchText = branchTextfield.text,
            let locCodeText = LocCodeTextfield.text,
            let salespersonText = salespersonTextfield.text,
            let customerText = customerTextfield.text,
            let deliveryDate = deliveryDateTextfield.text,
            let storeTxt = storeTextfield.text,
            let comment = commentTextview.text
        {
            if companyText == companyNamesArray[0] ||
                branchText == branchNamesArray[0] ||
                locCodeText == locCodeNumsArray[0] ||
                salespersonText == salespersonNamesArray[0] ||
                customerText == customerNamesArray[0] ||
                deliveryDate.isEmpty
            {
                let alertTitle = "Alert!".localize()
                let alertMessage = "You did not fill or select any of the fields".localize()
                if !storeArray.isEmpty{
                    if storeTxt == storeIdArray[0]{
                        AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "OK", onAction: nil, cancelAction: nil, self)
                    }
                } else {
                    AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "OK", onAction: nil, cancelAction: nil, self)
                }
                return
            } else {
                var countForItemStatus = 0
                table = !itemAddedArray.isEmpty
                if table{
                    for item in itemAddedArray{
                        itemSentStatus = webservice.SendItemGrid(
                            orderid: orderId,
                            serialno: countForItemStatus,
                            customerid: customerNamesArray[selectedRowForCustomer],
                            Grid_ItemId: item.Grid_ItemId,
                            Grid_Desc: item.Grid_Desc,
                            Grid_UnitPrice: item.Grid_UnitPrice,
                            Grid_Qty: item.Grid_Qty,
                            Grid_TotalPrice: item.Grid_TotalPrice,
                            Grid_UOM: item.Grid_UOM)
                        for status in itemSentStatus{
                            if status.grid_error != ""{
                                let alertTitle = "Alert".localize()
                                let alertMessage = status.grid_error
                                AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "Ok", onAction: {
                                    return
                                }, cancelAction: nil, self)
                            } else {
                                if orderId == ""{
                                    orderId = status.OrderID
                                }
                                if status.Flag == true {
                                    flag = true
                                } else { flag = false }
                                countForItemStatus += 1
                                print("Item sent successfully")
                            }
                        }
                    }
                    
                    let branchId = selectedRowForBranch != 0 ? branchIdArray[selectedRowForBranch - 1] : ""
                    let companyId = selectedRowForCompany != 0 ? companyIdArray[selectedRowForCompany - 1] : companyIdArray[0]
                    let store = storeArray.isEmpty ? "" : storeIdArray[salesSelecteedRow]
                    let city = cityArray.isEmpty ? "" : cityArray[citySelectedRow].City
                    let salespersonstore = salesPersonArray.isEmpty ? "" : salesPersonArray[salesperosnSelectedRow].SalesPersonStore
                    let merchandiser = merchandiserArray.isEmpty ? "" :merchandiserArray[merSelectedRow].Merchandiser
                    
                    sentStatus = webservice.Senditem(
                        orderid: orderId,
                        branchid: branchId,
                        customerid: customerText,
                        branch: branchText,
                        table: table,
                        salesperson: salespersonText,
                        company: companyId,
                        emp_id: emp_id,
                        comment: comment,
                        city: city,
                        store: store,
                        salespersonstore: salespersonstore,
                        merchandiser: merchandiser,
                        offer: offer,
                        deliverydate: deliveryDate,
                        loccode: locCodeText,
                        docid: docIdArray[0],
                        purchasegrid: "",
                        supermarket: supermarket,
                        flag: flag)
                    
                    for status in sentStatus{
                        if status.grid_error != ""{
                            error = status.grid_error
                        }
                    }
                    if error != ""{
                        AlertMessage().showAlertMessage(alertTitle: "Alert!".localize(), alertMessage: error, actionTitle: "Ok", onAction: nil, cancelAction: nil, self)
                        return
                    } else {
                        AlertMessage().showAlertMessage(alertTitle: "Success".localize(), alertMessage: "Order request sent successfully".localize(), actionTitle: "Ok", onAction: {
                            self.setViewToDefault()
                        }, cancelAction: nil, self)
                    }
                }
            }
        }
    }
    
    func setViewToDefault(){
        initalvalue()
        error = ""
        orderId = ""
        count = 0
        customerTextfield.text = companyNamesArray[0]
        deliveryDateTextfield.text = ""
        setUpDefaultSelector()
        setUpDefaultValueFromStoreToQty()
        commentTextview.text = ""
        itemAddedArray.removeAll()
        setCountLabel(c: itemAddedArray.count)
        scrollView.scrollTo(direction: .Top, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ItemsSelectedViewController{
            vc.delegate = self
        }
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
}

// -- MARK: Handle picker view

extension SalesOrderRequestsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showCompanyPickerViewTextfield, pickerview: companyPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showBranchPickerViewTextfield, pickerview: branchPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showDocIdPickerViewTextfield, pickerview: docIdPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showLocCodePickerViewTextfield, pickerview: LocCodePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showsalespersonPickerViewTextfield, pickerview: salespersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showcustomerPickerViewTextfield, pickerview: customerPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showStorePickerViewTextfield, pickerview: storePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showCityPickerViewTextfield, pickerview: cityPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerViewTextfield, pickerview: salesPersonStorePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showMerchandiserPickerViewTextfield, pickerview: merchandiserPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showItemsPickerViewTextfield, pickerview: itemsPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showUnoitPickerViewTextfield, pickerview: unoitPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == companyPickerView{
            companyTextfield.text = companyNamesArray[selectedRowForCompany].localize()
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            branchTextfield.text = branchNamesArray[selectedRowForBranch].localize()
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            docIdTextfield.text = docIdArray[0]
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else if pickerview == LocCodePickerView{
            LocCodeTextfield.text = locCodeNumsArray[selectedRowForLocCode].localize()
            locCodeGlobal = locCodeNumsArray[selectedRowForLocCode]
            showLocCodePickerViewTextfield.resignFirstResponder()
        } else if pickerview == salespersonPickerView{
            salespersonTextfield.text = salespersonNamesArray[selectedRowForSalesPerson].localize()
            showsalespersonPickerViewTextfield.resignFirstResponder()
        } else if pickerview == customerPickerView{
            customerTextfield.text = customerNamesArray[selectedRowForCustomer].localize()
            customerGlobal = customerNamesArray[selectedRowForCustomer]
            showcustomerPickerViewTextfield.resignFirstResponder()
        } else if pickerview == storePickerView{
            storeTextfield.text = storeIdArray[salesSelecteedRow]
            if salesSelecteedRow == 0 {
                cityTextfield.text = "Select city".localize()
                salesPersonTextfield.text = "Select sales person".localize()
                merchandiserTextfield.text = "Select merchandiser".localize()
            }
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            cityTextfield.text = cityArray.isEmpty ? "Select city".localize() : cityArray[citySelectedRow].City
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonStorePickerView{
            salesPersonTextfield.text = salesPersonArray.isEmpty ? "Select sales person".localize() : salesPersonArray[salesperosnSelectedRow].SalesPersonStore
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else if pickerview == merchandiserPickerView {
            merchandiserTextfield.text = merchandiserArray.isEmpty ? "Select merchandiser".localize() : merchandiserArray[merSelectedRow].Merchandiser
            showMerchandiserPickerViewTextfield.resignFirstResponder()
        } else if pickerview == itemsPickerView{
            itemsTextfield.text = items.isEmpty ? "Select item".localize() : itemsName[itemSelectedRow]
            unoits = items.isEmpty ? [SalesModel]() : webservice.BindSalesOrderUnitofMeasure(itemid: itemsName[itemSelectedRow])
            unoitTextfield.text = "Select unoit of measure".localize()
            qtyTextfield.text = "1"
            showItemsPickerViewTextfield.resignFirstResponder()
            warningLabel.isHidden = true
        } else if pickerview == unoitPickerView{
            unoitTextfield.text = unoits.isEmpty ? "Select unoit of measure".localize() : unoits[uofmSelectedRow].UnitofMeasure
            showUnoitPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == companyPickerView{
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else if pickerview == LocCodePickerView{
            showLocCodePickerViewTextfield.resignFirstResponder()
        } else if pickerview == salespersonPickerView{
            showsalespersonPickerViewTextfield.resignFirstResponder()
        } else if pickerview == customerPickerView{
            showcustomerPickerViewTextfield.resignFirstResponder()
        } else if pickerview == storePickerView{
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonStorePickerView{
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else if pickerview == merchandiserPickerView{
            showMerchandiserPickerViewTextfield.resignFirstResponder()
        } else if pickerview == itemsPickerView{
            showItemsPickerViewTextfield.resignFirstResponder()
        } else if pickerview == unoitPickerView{
            showUnoitPickerViewTextfield.resignFirstResponder()
        }
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == companyPickerView{
            return companyNamesArray.count
        } else if pickerView == branchPickerView{
            return branchNamesArray.count
        } else if pickerView == docIdPickerView{
            return docIdArray.count
        } else if pickerView == LocCodePickerView{
            return locCodeNumsArray.count
        } else if pickerView == salespersonPickerView{
            return salespersonNamesArray.count
        } else if pickerView == customerPickerView{
            return customerNamesArray.count
        } else if pickerView == storePickerView{
            return storeArray.count
        } else if pickerView == cityPickerView{
            return cityArray.count
        } else if pickerView == salesPersonStorePickerView{
            return salesPersonArray.count
        } else if pickerView == merchandiserPickerView{
            return merchandiserArray.count
        } else if pickerView == itemsPickerView{
            return itemsName.count
        } else if pickerView == unoitPickerView{
            return unoits.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == companyPickerView{
            return companyNamesArray[row].trimmingCharacters(in: .newlines).localize()
        } else if pickerView == branchPickerView{
            return branchNamesArray[row].localize()
        } else if pickerView == docIdPickerView{
            return docIdArray[row]
        } else if pickerView == LocCodePickerView{
            return locCodeNumsArray[row].localize()
        } else if pickerView == salespersonPickerView{
            return salespersonNamesArray[row].localize()
        } else if pickerView == customerPickerView{
            return customerNamesArray[row].localize()
        } else if pickerView == storePickerView{
            return storeIdArray[row].localize()
        } else if pickerView == cityPickerView{
            return cityArray[row].City
        } else if pickerView == salesPersonStorePickerView{
            return salesPersonArray[row].SalesPersonStore
        } else if pickerView == merchandiserPickerView{
            return merchandiserArray[row].Merchandiser
        } else if pickerView == itemsPickerView{
            return itemsName[row]
        } else if pickerView == unoitPickerView{
            return unoits[row].UnitofMeasure
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == companyPickerView{
            selectedRowForCompany = row
        } else if pickerView == branchPickerView{
            selectedRowForBranch = row
        } else if pickerView == LocCodePickerView{
            selectedRowForLocCode = row
        } else if pickerView == salespersonPickerView{
            selectedRowForSalesPerson = row
            getCustomers(salesperson: salespersonNamesArray[row])
            customerTextfield.text = customerNamesArray[0].localize()
        } else if pickerView == customerPickerView{
            selectedRowForCustomer = row
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            getStoreId(customerId: customerNamesArray[selectedRowForCustomer])
            getCreditDetails(customerId: customerNamesArray[selectedRowForCustomer])
            getItems(customerId: customerNamesArray[selectedRowForCustomer])
            if storeArray.isEmpty{
                storeStackView.isHidden = true
                viewHolder.isHidden = true
            } else {
                viewHolder.isHidden = false
                storeStackView.isHidden = false
                setUpDefaultValueFromStoreToQty()
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        } else if pickerView == storePickerView{
            salesSelecteedRow = row
            storeTextfield.text = storeIdArray[row]
            cityArray = webservice.BindCity(storevalue: storeIdArray[row], customer: customerNamesArray[selectedRowForCustomer])
            if !cityArray.isEmpty{
                cityTextfield.text = cityArray[0].City
                salesPersonArray = webservice.BindSalesPersonforStore(customer: customerNamesArray[selectedRowForCustomer], city: cityArray[0].City, store: storeIdArray[row])
                if !salesPersonArray.isEmpty{
                    salesPersonTextfield.text = salesPersonArray[0].SalesPersonStore
                    merchandiserArray = webservice.BindMerchandiser(customer: customerNamesArray[selectedRowForCustomer], city: cityArray[0].City, store: storeIdArray[row], salesperson: salesPersonArray[0].SalesPersonStore)
                    if !merchandiserArray.isEmpty{
                        merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                    }
                }
            }
        } else if pickerView == cityPickerView{
            citySelectedRow = row
            if  !cityArray.isEmpty{
                salesPersonArray = webservice.BindSalesPersonforStore(customer: customerNamesArray[selectedRowForCustomer], city: cityArray[row].City, store: storeIdArray[salesSelecteedRow])
                if !salesPersonArray.isEmpty{
                    salesPersonTextfield.text = salesPersonArray[0].SalesPersonStore
                    merchandiserArray = webservice.BindMerchandiser(customer: customerNamesArray[selectedRowForCustomer], city: cityArray[row].City, store: storeIdArray[salesSelecteedRow], salesperson: salesPersonArray[0].SalesPersonStore)
                    if !merchandiserArray.isEmpty{
                        merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                    }
                }
            }
        } else if pickerView == salesPersonStorePickerView {
            if !salesPersonArray.isEmpty{
                salesperosnSelectedRow = row
                merchandiserArray = webservice.BindMerchandiser(customer: customerNamesArray[selectedRowForCustomer], city: cityArray[citySelectedRow].City, store: storeIdArray[salesSelecteedRow], salesperson: salesPersonArray[row].SalesPersonStore)
                if !merchandiserArray.isEmpty{
                    merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                }
            }
        } else if pickerView == merchandiserPickerView{
            merSelectedRow = row
        } else if pickerView == itemsPickerView{
            unoits = webservice.BindSalesOrderUnitofMeasure(itemid: itemsName[row])
            itemSelectedRow = row
        } else if pickerView == unoitPickerView{
            uofmSelectedRow = row
        }
    }
}

// -- MARK: Date Picker

extension SalesOrderRequestsViewController{
    func setupDatePicker(){
        PickerviewAction().showDatePicker(txtfield: deliveryDateTextfield, datePicker: deliveryDatePickerView, title: "Delivery Date".localize(), viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        date = getStringDate(date: sender.date)
        deliveryDateTextfield.text = getStringDate(date: sender.date)
    }
    
    func getStringDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    @objc func datePickerDoneClick(){
        if date.isEmpty{
            deliveryDateTextfield.text = getStringDate(date: currentDate)
        }
        deliveryDateTextfield.resignFirstResponder()
    }
}

// -- MARK: Handle pass info using delegate

extension SalesOrderRequestsViewController: ItemCountAddedDelegate{
    func setCount(count: Int) {
        self.count = count
    }
    func itemsArrayReceived(itemsArray: [ItemsModul]) {
        itemAddedArray = itemsArray
    }
}

// -- MARK: Handle TextView and TextField

extension SalesOrderRequestsViewController: UITextViewDelegate, UITextFieldDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextview.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField = textField
    }
}

// -- MARK: Handle keyboard appeance

extension SalesOrderRequestsViewController{
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


