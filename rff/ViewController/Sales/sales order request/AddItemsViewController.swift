//
//  AddItemsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
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

class AddItemsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, ItemCountAddedDelegate {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var itemsTextfield: UITextField!
    @IBOutlet weak var showItemsPickerViewTextfield: UITextField!
    @IBOutlet weak var unoitTextfield: UITextField!
    @IBOutlet weak var showUnoitPickerViewTextfield: UITextField!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var itemsAddedLabel: UILabel!
    @IBOutlet weak var commentTextview: UITextView!
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    let screenSize = AppDelegate().screenSize
    let itemsPickerView: UIPickerView = UIPickerView()
    let unoitPickerView: UIPickerView = UIPickerView()
    let qtyPickerView: UIPickerView = UIPickerView()
    var pickerview: UIPickerView = UIPickerView()
    
    var items = [SalesModel]()
    var itemsName = [String]()
    var unoits = [SalesModel]()
    var unoitsName = [String]()
    var itemAddedReceived = [ItemAddedModel]()
    var itemSelectedRow: Int = 0
    var uofmSelectedRow: Int = 0
    
    var count: Int = 0
    let customer = salesOrderRequestDetails.customer
    let loccode = salesOrderRequestDetails.loccode
    
    func setCount(count: Int) {
        self.count = count
    }
    func itemsArrayReceived(itemsArray: [ItemsModul]) {
        salesOrderRequestDetails.itemsArray = itemsArray
    }
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Items".localize()
        if LanguageManger.isArabicLanguage{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        stackviewWidth.constant = screenSize.width - 32
        showItemsPickerViewTextfield.tintColor = .clear
        showUnoitPickerViewTextfield.tintColor = .clear
        commentTextview.text = ""
        commentTextview.delegate = self
        
        setupArrays()
        setUpWidth()
        setupPickerView()
        setUpCommentDisplay()
        
        setUpKeyboardToolBar(textfield: qtyTextfield, viewController: self, cancelTitle: nil, cancelSelector: nil, doneTitle: "Done", doneSelector: #selector(doneButtonClick))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setViewAlignment()
        setbackNavTitle(navItem: navigationItem)
        if !salesOrderRequestDetails.itemsArray.isEmpty{
            count = salesOrderRequestDetails.itemsArray.count
        }
        setCountLabel(c: count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    func setupArrays(){
        items = webservice.BindSalesOrderItems(customerid: customer)
        for item in items{
            itemsName.append(item.DrpItems)
        }
    }
    
    func setCountLabel(c: Int){
        itemsAddedLabel.text = "Items added is ".localize() + "\(c)"
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
    }
    
    func setupPickerView(){
        PickerviewAction().showPickView(txtfield: showItemsPickerViewTextfield, pickerview: itemsPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showUnoitPickerViewTextfield, pickerview: unoitPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    func setUpCommentDisplay(){
        commentTextview.layer.cornerRadius = 5.0
        commentTextview.layer.borderColor = mainBackgroundColor.cgColor
        commentTextview.layer.borderWidth = 1
    }
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextview.resignFirstResponder()
            return false
        }
        return true
    }
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == itemsPickerView{
            itemsTextfield.text = items.isEmpty ? "Select item".localize() : itemsName[itemSelectedRow]
            unoits = items.isEmpty ? [SalesModel]() : webservice.BindSalesOrderUnitofMeasure(itemid: itemsName[itemSelectedRow])
            unoitTextfield.text = "Select unoit of measure".localize()
            qtyTextfield.text = "1"
            showItemsPickerViewTextfield.resignFirstResponder()
            warningLabel.isHidden = true
        } else {
            unoitTextfield.text = unoits.isEmpty ? "Select unoit of measure".localize() : unoits[uofmSelectedRow].UnitofMeasure
            showUnoitPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == itemsPickerView{
            showItemsPickerViewTextfield.resignFirstResponder()
        } else {
            showUnoitPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func doneButtonClick(){
        qtyTextfield.resignFirstResponder()
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerview = pickerView
        if pickerView == itemsPickerView{
            return itemsName.count
        }
        return unoits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == itemsPickerView{
            return itemsName[row]
        }
        return unoits[row].UnitofMeasure
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == itemsPickerView{
            unoits = webservice.BindSalesOrderUnitofMeasure(itemid: itemsName[row])
            itemSelectedRow = row
        } else {
            uofmSelectedRow = row
        }
    }
    
    // -- MARK: IBActions
    
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
            itemAddedReceived = webservice.BindPurchaseGridData(quantity: qtyText, quantityrequired: 0.0, ItemId: itemText, unitofmeasure: unoitText, customerid: customer, loccode: loccode)
            
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
            salesOrderRequestDetails.itemsArray.append(
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
    
    @IBAction func showItemsButtonTapped(_ sender: Any) {
        if let commentTxt = commentTextview.text{
            salesOrderRequestDetails.comment = commentTxt
        }
        performSegue(withIdentifier: "showSummary", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ItemsSelectedViewController{
            vc.delegate = self
        }
    }
}

extension AddItemsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
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

