//
//  TrackingInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var formId: String = ""

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
    @IBOutlet weak var activityIndicatorContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    let screenSize = AppDelegate.shared.screenSize
    let pickViewList: UIPickerView = UIPickerView()
    let pickViewCategory: UIPickerView = UIPickerView()
    var pickview: UIPickerView = UIPickerView()
    
    var categoryArray = [String]()
    
    var listTextChosen: String?
    var categoryTextChosen: String?
    var arrayOfListReceived = [ListTypeModul]()
    var arrayOfList = [ListTypeModul]()
    var list = ListTypeModul()
    var arrayOfInboxGrid = [InboxGridModul]()
    let languageChosen = LoginViewController.languageChosen
    
    var listFormId: Int = 0
    var categoryIndexSelected: Int = 0
    var listRowIndex: Int = 0
    var CategopryRowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCustomDefaultNav(navItem: navigationItem)
        listTextfield.tintColor = .clear
        categoryTextfield.tintColor = .clear
        showListPickerTextField.tintColor = .clear
        showCategoryPickerTextField.tintColor = .clear
        
        setUpPickerView()
        setupLanguagChange()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        startLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        listRowIndex = 0
//        CategopryRowIndex = 0
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        if arrayOfListReceived.isEmpty{
            self.setUpArrays()
        }
        stopLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)
        
        if formId != ""{
            runViewIfComeFromHome()
        }
        
        print("listRowIndex = ", listRowIndex)
        print("CategopryRowIndex = ", CategopryRowIndex)

        
//        listTextfield.text = arrayOfList[0].listname
//        pickViewList.selectRow(0, inComponent: 0, animated: false)
//        categoryTextfield.text = categoryArray[0]
//        pickViewCategory.selectRow(0, inComponent: 0, animated: false)
    }
    
    // -- MARK: Setups
    
    func setupLanguagChange(){
        searchContectTextfield.placeholder = "Search content".localize()
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
        arrayOfListReceived = TrackingService.instance.Bind_ddlReqType(langid: languageChosen)
        
        list.listname = "Select list".localize()
        categoryArray = [
            "Select category".localize(),
            "Pending".localize(),
            "Rejected".localize(),
            "On Hold".localize(),
            "Approved".localize(),
            "All".localize()
        ]
        list.listtype = "0"
        arrayOfList.append(list)
        
        for listReceived in arrayOfListReceived{
            if listReceived.listtype == "10" || listReceived.listtype == "1004" || listReceived.listtype == "2079" || listReceived.listtype == "1003" || listReceived.listtype == "2083" {
                arrayOfList.append(listReceived)
            }
        }
    }
    
    // -- MSRK: objc functions
    
    @objc func cancelClick(){
        if pickview == pickViewList{ showListPickerTextField.resignFirstResponder() }
        else { showCategoryPickerTextField.resignFirstResponder() }
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
        } else {
            if CategopryRowIndex == 0 {
                categoryTextfield.text = categoryArray[0]
                showCategoryPickerTextField.resignFirstResponder()
            } else {
                categoryTextfield.text = categoryTextChosen
                showCategoryPickerTextField.resignFirstResponder()
            }
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
        self.pickview = pickerView
        if pickerView == pickViewList{
            return arrayOfList[row].listname
        }
        return categoryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickViewList{
            listTextChosen = arrayOfList[row].listname
            if let arraylistInt = Int(arrayOfList[row].listtype){
                listFormId = arraylistInt
            }
            listRowIndex = row
        } else {
            categoryTextChosen = categoryArray[row]
            categoryIndexSelected = row - 1
            CategopryRowIndex = row
        }
    }
    
    // -- MARK: IBActions
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        if listRowIndex == 0
            || CategopryRowIndex == 0 {
            AlertMessage().showAlertMessage(
                alertTitle: "Alert!".localize(),
                alertMessage: "You did not select a list or category".localize(),
                actionTitle: "Ok",
                onAction: {
                return
            }, cancelAction: nil, self)
        } else {
            startLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.showArrayOfInboxGrid(fromId: String(self.listFormId), drpdwnvalue: String(self.categoryIndexSelected))
            }
        }
    }
    
    // -- MARK: Helper functions
    
    func runViewIfComeFromHome(){
        var count = 0
        for list in arrayOfList{
            if list.listtype == formId{
                listRowIndex = count + 1
                CategopryRowIndex = 1
                listTextfield.text = list.listname
                categoryTextfield.text = categoryArray[1]
                if let arraylistInt = Int(list.listtype){
                    listFormId = arraylistInt
                }
                
                activityIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.showArrayOfInboxGrid(fromId: formId, drpdwnvalue: String(0))
                    
                    self.pickViewList.selectRow(self.listRowIndex, inComponent: 0, animated: false)
                    self.pickViewCategory.selectRow(self.CategopryRowIndex, inComponent: 0, animated: false)
                }
                break
            }
            count += 1
        }
    }
    
    func showArrayOfInboxGrid(fromId: String, drpdwnvalue: String){
        if let currentUserIdInt = Int(AuthServices.currentUserId), let searchText = searchContectTextfield.text{
            self.arrayOfInboxGrid = TrackingService.instance.SearchInbox(empid: currentUserIdInt,
                                                                       formid: fromId,
                                                                       drpdwnvalue: drpdwnvalue,
                                                                       search: searchText,
                                                                       langid: LoginViewController.languageChosen)

            formId = ""
            self.performSegue(withIdentifier: "showInboxTable", sender: nil)
            stopLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInboxTable" {
            if let viewController = segue.destination as? InboxTableViewController{
                viewController.arrayOfInboxGrid = self.arrayOfInboxGrid
                viewController.listFormId = listFormId
                viewController.categorySelected = CategopryRowIndex
                if let title = self.listTextfield.text{
                    viewController.navTitle = title
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
