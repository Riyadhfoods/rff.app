//
//  PromotionDerailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class PromotionDerailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
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
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
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
    
    // -- MARK: viewDodLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupPickerView()
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: SetUps
    
    func setupViews(){
        stackViewWidth.constant = AppDelegate().screenSize.width - 32
        showPromotionPickerTextField.tintColor = .clear
        showCutomerClassPickerTextField.tintColor = .clear
        showCustomerPickerTextField.tintColor = .clear
        showItemPickerTextField.tintColor = .clear
        showUofmPickerTextField.tintColor = .clear
        showProfitMarginPickerTextField.tintColor = .clear
    }
    
    // -- MARK: IBActions
    
    @IBAction func nextButtomTapped(_ sender: Any) {
    }
    
}


extension PromotionDerailsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    // -- MARK: PickerView Setup
    
    func setupPickerView(){
        PickerviewAction().showPickView(
            txtfield: showPromotionPickerTextField,
            pickerview: promotionTypePickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTapped),
            doneSelector: #selector(doneToolBarButtonTapped))
        
        PickerviewAction().showPickView(
            txtfield: showCutomerClassPickerTextField,
            pickerview: customerClassPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTapped),
            doneSelector: #selector(doneToolBarButtonTapped))
        
        PickerviewAction().showPickView(
            txtfield: showCustomerPickerTextField,
            pickerview: customerPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTapped),
            doneSelector: #selector(doneToolBarButtonTapped))
        
        PickerviewAction().showPickView(
            txtfield: showItemPickerTextField,
            pickerview: itemPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTapped),
            doneSelector: #selector(doneToolBarButtonTapped))
        
        PickerviewAction().showPickView(
            txtfield: showUofmPickerTextField,
            pickerview: uofmPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTapped),
            doneSelector: #selector(doneToolBarButtonTapped))
        
        PickerviewAction().showPickView(
            txtfield: showProfitMarginPickerTextField,
            pickerview: profitMarginPickerView,
            viewController: self,
            cancelSelector: #selector(cancelToolBarButtonTapped),
            doneSelector: #selector(doneToolBarButtonTapped))
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
    
    @objc func doneToolBarButtonTapped(){
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
    
    @objc func cancelToolBarButtonTapped(){
        if pickerView == promotionTypePickerView{ showPromotionPickerTextField.resignFirstResponder() }
        else if pickerView == customerClassPickerView{ showCutomerClassPickerTextField.resignFirstResponder() }
        else if pickerView == customerPickerView{ showCustomerPickerTextField.resignFirstResponder() }
        else if pickerView == itemPickerView{ showItemPickerTextField.resignFirstResponder() }
        else if pickerView == uofmPickerView{ showUofmPickerTextField.resignFirstResponder() }
        else { showProfitMarginPickerTextField.resignFirstResponder() }
    }
    
}

extension PromotionDerailsViewController{
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




