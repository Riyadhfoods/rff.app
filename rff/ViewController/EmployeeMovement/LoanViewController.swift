//
//  LoanViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class LoanViewController: UIViewController {

    // -- MARK: Outlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var selectorFurnishing: UIView!
    @IBOutlet weak var selectorArrival: UIView!
    @IBOutlet weak var selectorUrgent: UIView!
    @IBOutlet weak var selectorExceptional: UIView!
    @IBOutlet weak var selectorOthers: UIView!
    
    @IBOutlet weak var innerSelectorFurnishing: UIView!
    @IBOutlet weak var innerSelectorArrival: UIView!
    @IBOutlet weak var innerSelectorUrgent: UIView!
    @IBOutlet weak var innerSelectorExceptional: UIView!
    @IBOutlet weak var innerSelectorOthers: UIView!
    
    @IBOutlet weak var furnishingButton: UIButton!
    @IBOutlet weak var arrivalButton: UIButton!
    @IBOutlet weak var urgentButton: UIButton!
    @IBOutlet weak var exceptionalBuuton: UIButton!
    @IBOutlet weak var othersBuuton: UIButton!
    
    @IBOutlet weak var amtRequiredTextField: UITextField!
    @IBOutlet weak var showGaurantorPickerTextField: UITextField!
    @IBOutlet weak var gaurantorTextField: UITextField!
    @IBOutlet weak var paymnetPeriodTextField: UITextField!
    @IBOutlet weak var amyEachMonthLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let gaurantorPickerview: UIPickerView = UIPickerView()
    var gaurantorsArray = ["Item 1", "Item 2", "Item 3"]
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amtRequiredTextField.delegate = self
        paymnetPeriodTextField.delegate = self
        
        setViewAlignment()
        setUpPickerView()
        setUpSelectors()
        setUpCommentDisplay()
        setUpToolBarButtons()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // -- MARK: Set ups
    
    func setUpSelectors(){
        let cornerRadiusValueHolder: CGFloat = 12
        let cornerRadiusValueInner: CGFloat = 11
        let cornerRadiusValueView: CGFloat = 9
        
        selectorFurnishing.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorFurnishing.layer.cornerRadius = cornerRadiusValueInner
        furnishingButton.layer.cornerRadius = cornerRadiusValueView
        
        selectorArrival.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorArrival.layer.cornerRadius = cornerRadiusValueInner
        arrivalButton.layer.cornerRadius = cornerRadiusValueView
        
        selectorUrgent.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorUrgent.layer.cornerRadius = cornerRadiusValueInner
        urgentButton.layer.cornerRadius = cornerRadiusValueView
        
        selectorExceptional.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorExceptional.layer.cornerRadius = cornerRadiusValueInner
        exceptionalBuuton.layer.cornerRadius = cornerRadiusValueView
        
        selectorOthers.layer.cornerRadius = cornerRadiusValueHolder
        innerSelectorOthers.layer.cornerRadius = cornerRadiusValueInner
        othersBuuton.layer.cornerRadius = cornerRadiusValueView
        
        
        setUpDefaultSelector()
    }
    
    func setUpDefaultSelector(){
        furnishingButton.backgroundColor = .white
        arrivalButton.backgroundColor = .white
        urgentButton.backgroundColor = .white
        exceptionalBuuton.backgroundColor = .white
        othersBuuton.backgroundColor = mainBackgroundColor
    }
    
    func setUpCommentDisplay(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    // -- MARK: IBAction
    
}

extension LoanViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func setUpPickerView(){
        PickerviewAction().showPickView(
            txtfield: showGaurantorPickerTextField,
            pickerview: gaurantorPickerview,
            viewController: self,
            cancelSelector: #selector(didCancelButtonTapped),
            doneSelector: #selector(didDoneButtonTapped))
    }
    
    @objc func didDoneButtonTapped(){
        showGaurantorPickerTextField.resignFirstResponder()
    }
    
    @objc func didCancelButtonTapped(){
        showGaurantorPickerTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gaurantorsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gaurantorsArray[row]
    }
}

extension LoanViewController: UITextFieldDelegate{
    func setUpToolBarButtons(){
        setUpKeyboardToolBar(
            textfield: amtRequiredTextField,
            viewController: self,
            cancelTitle: "Cancel",
            cancelSelector: #selector(didCancelToolBarButtonTapped),
            doneTitle: "Next",
            doneSelector: #selector(didDoneToolBarButtonTapped))
        
        setUpKeyboardToolBar(
            textfield: paymnetPeriodTextField,
            viewController: self,
            cancelTitle: nil,
            cancelSelector: nil,
            doneTitle: "Done",
            doneSelector: #selector(didDoneToolBarButtonTapped))
    }
    
    @objc func didDoneToolBarButtonTapped(){
        amtRequiredTextField.resignFirstResponder()
    }
    
    @objc func didCancelToolBarButtonTapped(){
        showGaurantorPickerTextField.becomeFirstResponder()
    }
}





