//
//  TrackingInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class TrackingInboxViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var listTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var searchContectTextfield: UITextField!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    @IBOutlet weak var returnButtonOutlet: UIButton!
    
    // TextField Action
    @IBOutlet weak var showListPickerTextField: UITextField!
    @IBOutlet weak var showCategoryPickerTextField: UITextField!
    
    
    let pickerViewAction = PickerviewAction()
    
    let toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.isTranslucent = true
        tb.tintColor = UIColor.black
        tb.sizeToFit()
        tb.isUserInteractionEnabled = true
        
        return tb
    }()
    
    // -- MARK: Variable
    let screenSize = AppDelegate().screenSize
    let pickViewList: UIPickerView = UIPickerView()
    let pickViewCategory: UIPickerView = UIPickerView()
    var pickview: UIPickerView = UIPickerView()
    
    var categoryArray = [String]()
    
    var listTextChosen: String?
    var categoryTextChosen: String?
    let webservice = Login()
    var arrayOfListReceived = [ListType]()
    var arrayOfList = [ListType]()
    var list = ListType()
    let languageChosen = LoginViewController.languageChosen
    
    var listIndexSelected: Int = 0
    var categoryIndexSelected: Int = 0
    var listRowIndex: Int = 0
    var CategopryRowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Arrays for picker views
        setUpArrays()
        
        // Set an initialized value
        listTextfield.text = arrayOfList[0].listname
        categoryTextfield.text = categoryArray[0]
        
        // Changing the back button of the navigation contoller
        //navigationItem.backBarButtonItem = backButtonItem
        setCustomNav(navItem: navigationItem)
        listTextfield.tintColor = .clear
        categoryTextfield.tintColor = .clear
        showListPickerTextField.tintColor = .clear
        showCategoryPickerTextField.tintColor = .clear
        
        setViewAlignment()
        setUpPickerView()
        setupLanguagChange()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: Setups
    
    func setupLanguagChange(){
//        searchContectTextfield.placeholder = getString(englishString: "Search content", arabicString: "محتوى البحث", language: languageChosen)
//        setUpHeaderLabel(txt: searchContectTextfield, language: languageChosen)
//        searchButtonOutlet.setTitle(getString(englishString: "SEARCH", arabicString: "بحث", language: languageChosen), for: .normal)
        returnButtonOutlet.setTitle(getString(englishString: "RETURN", arabicString: "عودة", language: languageChosen), for: .normal)
    }
    
    func setUpPickerView(){
        pickerViewAction.showPickView(
            txtfield: showListPickerTextField,
            pickerview: pickViewList,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(doneClick))
        
        pickerViewAction.showPickView(
            txtfield: showCategoryPickerTextField,
            pickerview: pickViewCategory,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(doneClick))
    }
    
    func setUpArrays(){
        arrayOfListReceived = webservice.Bind_ddlReqType(langid: languageChosen)
        
        if languageChosen == 1 {
            list.listname = "Select a list"
            categoryArray = [
                "Select a category",
                "Pending",
                "Rejected",
                "On Hold",
                "Approved",
                "All"
            ]
        } else {
            list.listname = "اختر القائمة"
            categoryArray = [
                "اختر الحاله",
                "قيد الانتظار",
                "مرفوض",
                "معلق",
                "موافقة",
                "الكل"
            ]
        }
        
        list.listtype = "0"
        arrayOfList.append(list)
        
        for listReceived in arrayOfListReceived{
            arrayOfList.append(listReceived)
        }
    }
    
    // -- MSRK: objc functions
    
    @objc func cancelClick(){
        if pickview == pickViewList{
            showListPickerTextField.resignFirstResponder()
            return
        }
        showCategoryPickerTextField.resignFirstResponder()
    }
    
    @objc func doneClick(){
        if pickview == pickViewList{
            if listRowIndex == 0 {
                listTextfield.text = arrayOfList[0].listname
                showListPickerTextField.resignFirstResponder()
            } else {
                listTextfield.text = listTextChosen
                showListPickerTextField.resignFirstResponder()
            }
            return
        }
        if CategopryRowIndex == 0 {
            categoryTextfield.text = categoryArray[0]
            showCategoryPickerTextField.resignFirstResponder()
        } else {
            categoryTextfield.text = categoryTextChosen
            showCategoryPickerTextField.resignFirstResponder()
        }
    }
    
    // -- MARK: Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickViewList {
            return arrayOfList.count
        }
        return categoryArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickViewList{
            self.pickview = pickViewList
            return arrayOfList[row].listname
        }
        self.pickview = pickViewCategory
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickViewList{
            listTextChosen = arrayOfList[row].listname
            if let arraylistInt = Int(arrayOfList[row].listtype){
                listIndexSelected = arraylistInt
            }
            listRowIndex = row
        } else {
            categoryTextChosen =  categoryArray[row]
            categoryIndexSelected = row - 1
            CategopryRowIndex = row
        }
    }
    
    // -- MARK: IBActions
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if listRowIndex == 0
            || CategopryRowIndex == 0 {
            AlertMessage().showAlertMessage(
                alertTitle: getString(englishString: "Alert!", arabicString: "تنبيه", language: languageChosen),
                alertMessage: getString(englishString: "Select a list or category first", arabicString: "اختر قائمة او حالة اولاً", language: languageChosen),
                actionTitle: "Ok",
                onAction: {
                return
            }, cancelAction: nil, self)
        }
        performSegue(withIdentifier: "showInboxTable", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInboxTable" {
            if let viewController = segue.destination as? InboxTableViewController{
                viewController.listIndexSelected = self.listIndexSelected
                viewController.categoryIndexSelected = self.categoryIndexSelected
                if let title = self.listTextfield.text{
                    viewController.navTitle = title
                }
            }
        }
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeStoryboard = storyboard.instantiateViewController(withIdentifier: "homeViewControllerNav")
        revealViewController().pushFrontViewController(homeStoryboard, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
