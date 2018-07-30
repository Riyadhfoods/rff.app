//
//  ReturnItemSelectedCell.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnItemSelectedCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var serialNmuber: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    @IBOutlet weak var invoiceNumber: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var uofm: UILabel!
    @IBOutlet weak var qty: UITextField!
    @IBOutlet weak var avePrice: UILabel!
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var expiredDate: UILabel!
    @IBOutlet weak var invoiceDate: UILabel!
    @IBOutlet weak var showReturnType: UITextField!
    @IBOutlet weak var returnType: UITextField!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var cellIndex = 0
    let typeArray = ["Select Type", "Damage تالف", "Export Return مرتجع تصدير", "Quality Issue مشكلة جودة", "Over Stock", "Expired انتهاء الصلاحية", "Over Stock مخزون زائد", "Near to expire", "Other Reason اسباب أخرى"]
    let pickerview = UIPickerView()
    var selectedRow = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCellHolderViewAndCellBackground(holderView: holderView, contentView: nil)
        
        showReturnType.tintColor = .clear
        PickerviewAction().showPickView(txtfield: showReturnType, pickerview: pickerview, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        
        setViewAlignment()
        qty.delegate = self
        setUpKeyboardToolBar(textfield: qty, viewController: self, cancelTitle: nil, cancelSelector: nil, doneTitle: "Done", doneSelector: #selector(doneButtonClick))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    @objc func doneClick(){
        returnType.text = typeArray[selectedRow]
        itemsArrayFromWS[cellIndex].returnType = typeArray[selectedRow]
        showReturnType.resignFirstResponder()
    }
    
    @objc func cancelClick(){
        showReturnType.resignFirstResponder()
    }
    
    @objc func doneButtonClick(){
        if qty.becomeFirstResponder(){
            qty.resignFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if let qytText = qty.text{
            itemsArrayFromWS[cellIndex].qty = qytText
        }
    }
    
}
