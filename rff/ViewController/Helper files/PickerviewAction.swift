//
//  PickerviewAction.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import UIKit

class PickerviewAction{
    
    //static var datePicker: UIDatePicker = UIDatePicker()
    
    let language = LoginViewController.languageChosen
    let textfield = UITextField()
    let toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.isTranslucent = true
        tb.tintColor = UIColor.black
        tb.sizeToFit()
        tb.isUserInteractionEnabled = true
        
        return tb
    }()

    func showPickView(txtfield: UITextField, pickerview: UIPickerView, viewController: Any?, cancelSelector: Selector?, doneSelector: Selector?){
        pickerview.dataSource = viewController as? UIPickerViewDataSource
        pickerview.delegate = viewController as? UIPickerViewDelegate
        
        txtfield.delegate = viewController as? UITextFieldDelegate
        txtfield.inputView = pickerview
        let cancelButton = UIBarButtonItem(title: getString(englishString: "Cancel", arabicString: "إلغاء", language: language), style: .plain, target: viewController, action: cancelSelector)
        if doneSelector != nil {
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: getString(englishString: "Done", arabicString: "تم", language: language), style: .plain, target: viewController, action: doneSelector)
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        } else {
            toolBar.setItems([cancelButton], animated: false)
        }
        txtfield.inputAccessoryView = toolBar
    }
    
    func showDatePicker(txtfield: UITextField, datePicker: UIDatePicker, title: String, viewController: Any?, datePickerSelector: Selector, doneSelector: Selector){
        datePicker.datePickerMode = UIDatePickerMode.date
        txtfield.inputView = datePicker
        
        datePicker.addTarget(viewController, action: datePickerSelector, for: .valueChanged)
        
        let doneButton = UIBarButtonItem(title: getString(englishString: "Done", arabicString: "تم", language: language), style: UIBarButtonItemStyle.plain, target: viewController, action: doneSelector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let text = UIBarButtonItem(title: title, style: .plain, target: viewController, action: nil)
        
        toolBar.setItems([spaceButton, spaceButton, text, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txtfield.inputAccessoryView = toolBar
    }
}












