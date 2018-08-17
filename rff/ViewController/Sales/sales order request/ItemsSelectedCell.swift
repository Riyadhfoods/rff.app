//
//  ItemsSelectedCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ItemsSelectedCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var showPCSPickerTextField: UITextField!
    @IBOutlet weak var PCSTextfield: UITextField!
    @IBOutlet weak var qtyTextfield: UITextField!
    @IBOutlet weak var unitPriceTextfield: UITextField!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var holderView: UIView!
    
    let webservice = SalesOrderRequestService.instance
    var delegate: ItemsSelectedViewController?
    let pickerview = UIPickerView()
    var unoits = [unitOfMeasurementModel]()
    var selectedRow = 0
    var indexpathRow = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        holderView.layer.borderWidth = 1
        setViewAlignment()
        
        showPCSPickerTextField.tintColor = .clear
        
        qtyTextfield.delegate = self
        unitPriceTextfield.delegate = self
        
        setUpKeyboardToolBar(textfield: qtyTextfield, viewController: self, cancelTitle: nil, cancelSelector: nil, doneTitle: "Done".localize(), doneSelector: #selector(doneButtonClick))
        setUpKeyboardToolBar(textfield: unitPriceTextfield, viewController: self, cancelTitle: nil, cancelSelector: nil, doneTitle: "Done".localize(), doneSelector: #selector(doneButtonClick))
        
        PickerviewAction().showPickView(txtfield: showPCSPickerTextField, pickerview: pickerview, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var itemAddedReceived = [ItemClassModul]()
    
    @objc func doneClick(){
        PCSTextfield.text = unoits.isEmpty ? "" : unoits[selectedRow].UnitofMeasure
        
        if let itemText = desc.text, let qtyText = qtyTextfield.text, let unoitText = PCSTextfield.text{
            itemAddedReceived = webservice.BindPurchaseGridData(quantity: qtyText, quantityrequired: 0.0, ItemId: itemText, unitofmeasure: unoitText, customerid: customerGlobal, loccode: locCodeGlobal)
            
            for item in itemAddedReceived{
                if item.grid_error == "" {
                    unitPriceTextfield.text = item.Grid_UnitPrice
                    itemAddedArray[indexpathRow].Grid_UnitPrice = item.Grid_UnitPrice
                }
            }
        }
        
        showPCSPickerTextField.resignFirstResponder()
    }
    
    @objc func cancelClick(){
        showPCSPickerTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unoits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unoits[row].UnitofMeasure
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        itemAddedArray[indexpathRow].Grid_UOM = unoits[row].UnitofMeasure
    }
    
    @objc func doneButtonClick(){
        if qtyTextfield.becomeFirstResponder(){
            qtyTextfield.resignFirstResponder()
        } else {
            unitPriceTextfield.resignFirstResponder()
        }
    }
    
    var qtyOldText: String = ""
    var unitPriceOldText: String = ""
    var totalPriceOldText: String = ""
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let qtyTxt = qtyTextfield.text, let unitPriceTxt = unitPriceTextfield.text, let totalPriceText = totalPrice.text{
            qtyOldText = qtyTxt
            unitPriceOldText = unitPriceTxt
            totalPriceOldText = totalPriceText
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var error = ""
        if let qtyTxt = qtyTextfield.text,
            let qtyDouble = Double(qtyTxt),
            let unitPriceTxt = unitPriceTextfield.text,
            let unitPriceDouble = Double(unitPriceTxt),
            let itemText = desc.text,
            let uofmText = PCSTextfield.text{
            
            if qtyTxt == qtyOldText && unitPriceTxt == unitPriceOldText{ return }
            let result = qtyDouble * unitPriceDouble
            let resultFormatted = String(format: "%.5f", result)
            
            if textField == qtyTextfield{
                error = handleChangeInQty(itemText: itemText, qtyTxt: qtyTxt, uofmText: uofmText, index: textField.tag)
                
                if error != "" {
                    if let delegate = delegate{
                        AlertMessage().showAlertMessage(alertTitle: "Alert", alertMessage: error, actionTitle: nil, onAction: nil, cancelAction: "OK", delegate)
                    }
                    print("------------------- gty change in grid ----------------------")
                    print(error)
                    print("------------------- gty change in grid ----------------------")
                }
                
                itemAddedArray[textField.tag].Grid_Qty = error != "" ? qtyOldText : qtyTxt
                qtyTextfield.text = error != "" ? qtyOldText : qtyTxt
                
                
            } else {
                itemAddedArray[textField.tag].Grid_UnitPrice = unitPriceTxt
            }
            itemAddedArray[textField.tag].Grid_TotalPrice = error != "" ? totalPriceOldText : resultFormatted
            totalPrice.text = error != "" ? totalPriceOldText : resultFormatted
        }
        
        print("""
            Grid_ItemId: \(itemAddedArray[textField.tag].Grid_ItemId),
            Grid_Desc: \(itemAddedArray[textField.tag].Grid_Desc),
            Grid_UnitPrice: \(itemAddedArray[textField.tag].Grid_UnitPrice),
            Grid_Qty: \(itemAddedArray[textField.tag].Grid_Qty),
            Grid_TotalPrice: \(itemAddedArray[textField.tag].Grid_TotalPrice),
            Grid_UOM: \(itemAddedArray[textField.tag].Grid_UOM)
            
            """)
    }
    
    func handleChangeInQty(itemText: String, qtyTxt: String, uofmText: String, index: Int) -> String{
        let inQtyChange = self.webservice.qtyChangeInGrid(gpcust: gpCust, itemNum: itemText, gridqty: qtyTxt, girdUofm: uofmText,
                                                      gridItemNum: itemAddedArray[index].Grid_ItemId, uofm: uofmText, locCodeValue: locCodeGlobal)
        for qtyChange in inQtyChange{
            if qtyChange.grid_error != "" {
                return qtyChange.grid_error
            }
        }
        return ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension Double{
    func rounded(toPlaces places:Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}









