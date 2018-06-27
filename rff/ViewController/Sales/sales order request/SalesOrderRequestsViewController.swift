//
//  SalesOrderRequestsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

var salesRequestDetails = SOR()

class SalesOrderRequestsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: Variable
    
    let webservice = Sales()
    let screenSize = AppDelegate().screenSize
    let companyPickerView: UIPickerView = UIPickerView()
    let branchPickerView: UIPickerView = UIPickerView()
    let docIdPickerView: UIPickerView = UIPickerView()
    let LocCodePickerView: UIPickerView = UIPickerView()
    var companyTextChosen: String?
    var branchTextChosen: String?
    var docIdTextChosen: String?
    var LocCodeTextChosen: String?
    
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
    var storeArray = [SalesModel]()
    
    var selectedRowForCompany: Int = 0
    var selectedRowForBranch: Int = 0
    var selectedRowForLocCode: Int = 0
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        
        if let userId = AuthServices.currentUserId{
            salesRequestDetails.emp_id = userId
        }
        
        setupView()
        setUpWidth()
        setUpPickerView()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if companyArray.isEmpty && branchArray.isEmpty && locCodeArray.isEmpty && salespersonArray.isEmpty{
            setupAarray()
            activityIndicator.stopAnimating()
        }
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
        setCustomNav(navItem: navigationItem)
        
        showCompanyPickerViewTextfield.tintColor = .clear
        showBranchPickerViewTextfield.tintColor = .clear
        showDocIdPickerViewTextfield.tintColor = .clear
        showLocCodePickerViewTextfield.tintColor = .clear
        
        stackviewWidth.constant = screenSize.width - 32
        
        companyNamesArray = ["Select company".localize()]
        branchNamesArray = ["Select branch".localize()]
        docIdArray = ["SRFC"]
        locCodeNumsArray = ["Select location code".localize()]
        activityIndicator.startAnimating()
    }
    
    func setupAarray(){
        salesRequestDetails.docid = docIdArray[0]
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
        
        initalvalue()
    }
    
    func initalvalue(){
        salesRequestDetails.docid = docIdArray[0]
        if !companyArray.isEmpty{
            companyTextfield.text = companyNamesArray[1]
            salesRequestDetails.company = companyNamesArray[1]
            salesRequestDetails.companyId = companyIdArray[0]
        }
        
        branchTextfield.text = branchNamesArray[0]
        docIdTextfield.text = docIdArray[0]
        LocCodeTextfield.text = locCodeNumsArray[0]
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showCompanyPickerViewTextfield, pickerview: companyPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showBranchPickerViewTextfield, pickerview: branchPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showDocIdPickerViewTextfield, pickerview: docIdPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showLocCodePickerViewTextfield, pickerview: LocCodePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == companyPickerView{
            companyTextfield.text = companyNamesArray[selectedRowForCompany].localize()
            salesRequestDetails.company = companyNamesArray[selectedRowForCompany]
            salesRequestDetails.companyId = companyIdArray[selectedRowForCompany - 1]
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            branchTextfield.text = branchNamesArray[selectedRowForBranch].localize()
            salesRequestDetails.branch = branchNamesArray[selectedRowForBranch]
            salesRequestDetails.branchId = branchIdArray[selectedRowForBranch - 1]
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            docIdTextfield.text = docIdArray[0]
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else {
            LocCodeTextfield.text = locCodeNumsArray[selectedRowForLocCode].localize()
            salesRequestDetails.loccode = locCodeNumsArray[selectedRowForLocCode]
            showLocCodePickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == companyPickerView{
            showCompanyPickerViewTextfield.resignFirstResponder()
        } else if pickerview == branchPickerView{
            showBranchPickerViewTextfield.resignFirstResponder()
        } else if pickerview == docIdPickerView{
            showDocIdPickerViewTextfield.resignFirstResponder()
        } else {
            showLocCodePickerViewTextfield.resignFirstResponder()
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
        }
        return locCodeNumsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == companyPickerView{
            return companyNamesArray[row].trimmingCharacters(in: .newlines).localize()
        } else if pickerView == branchPickerView{
            return branchNamesArray[row].localize()
        } else if pickerView == docIdPickerView{
            return docIdArray[row]
        }
        return locCodeNumsArray[row].localize()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == companyPickerView{
            selectedRowForCompany = row
        } else if pickerView == branchPickerView{
            selectedRowForBranch = row
        } else if pickerView == LocCodePickerView{
            selectedRowForLocCode = row
        }
    }
    
    // -- MARK: IBAction
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if companyTextfield.text == companyNamesArray[0] || branchTextfield.text == branchNamesArray[0] || LocCodeTextfield.text == locCodeNumsArray[0]{
            let alertTitle = "Alert!".localize()
            let alertMessage = "You did not select branch or location code".localize()
            AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "OK", onAction: {
                return
            }, cancelAction: nil, self)
        }
        performSegue(withIdentifier: "showSalespersonDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SalesPersonViewController{
            vc.salespersonArray = self.salespersonArray
        }
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
}

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


