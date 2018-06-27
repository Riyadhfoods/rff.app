//
//  StoreViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 07/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var storeTextfield: UITextField!
    @IBOutlet weak var showStorePickerViewTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var showCityPickerViewTextfield: UITextField!
    @IBOutlet weak var salesPersonTextfield: UITextField!
    @IBOutlet weak var showSalesPersonPickerViewTextfield: UITextField!
    @IBOutlet weak var merchandiserTextfield: UITextField!
    @IBOutlet weak var showMerchandiserPickerViewTextfield: UITextField!
    
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let webservice = Sales()
    let storePickerView: UIPickerView = UIPickerView()
    let cityPickerView: UIPickerView = UIPickerView()
    let salesPersonPickerView: UIPickerView = UIPickerView()
    let merchandiserPickerView: UIPickerView = UIPickerView()
    var storeTextChosen: String?
    var cityTextChosen: String?
    var salesPersonTextChosen: String?
    var merchandiserTextChosen: String?
    var storeArray = [SalesModel]()
    var storeIdArray = [String]()
    var cityArray = [SalesModel]()
    var salesPersonArray = [SalesModel]()
    var merchandiserArray = [SalesModel]()
    var selectedRow: Int = 0
    
    var salesSelecteedRow: Int = 0
    var citySelectedRow: Int = 0
    var salesperosnSelectedRow: Int = 0
    var merSelectedRow: Int = 0
    var isThereStoreId: Bool = true
    
    // To keep track
    var pickerview: UIPickerView = UIPickerView()
    let languageChosen = LoginViewController.languageChosen
    //salesDetails.CustomerInFull
    let customer = salesRequestDetails.customer
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Store Details".localize()
        setbackNavTitle(navItem: navigationItem)
        stackviewWidth.constant = screenSize.width - 32
        showStorePickerViewTextfield.tintColor = .clear
        showCityPickerViewTextfield.tintColor = .clear
        showSalesPersonPickerViewTextfield.tintColor = .clear
        showMerchandiserPickerViewTextfield.tintColor = .clear
        
        setupArrays()
        setUpWidth()
        setUpPickerView()
        setViewAlignment()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if storeArray.isEmpty{
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            setupArrays()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        salesRequestDetails.itemsArray.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: Set ups
    
    func setupArrays(){
        storeArray = webservice.BindDdlStore(customerid: customer)
        storeIdArray = ["Select store id".localize()]
        for store in storeArray{
            storeIdArray.append(store.StoreID)
        }
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setUpWidth(){
        stackviewWidth.constant = screenSize.width - 32
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showStorePickerViewTextfield, pickerview: storePickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showCityPickerViewTextfield, pickerview: cityPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showSalesPersonPickerViewTextfield, pickerview: salesPersonPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
        PickerviewAction().showPickView(txtfield: showMerchandiserPickerViewTextfield, pickerview: merchandiserPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    
    
    // -- MARK: objc functions
    
    @objc func doneClick(){
        if pickerview == storePickerView{
            storeTextfield.text = storeIdArray[salesSelecteedRow]
            if selectedRow == 0 {
                cityTextfield.text = "Select city".localize()
                salesPersonTextfield.text = "Select sales person".localize()
                merchandiserTextfield.text = "Select merchandiser".localize()
            }
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            cityTextfield.text = cityArray.isEmpty ? "Select city".localize() : cityArray[citySelectedRow].City
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonPickerView{
            salesPersonTextfield.text = salesPersonArray.isEmpty ? "Select sales person".localize() : salesPersonArray[salesperosnSelectedRow].SalesPersonStore
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else {
            merchandiserTextfield.text = merchandiserArray.isEmpty ? "Select merchandiser".localize() : merchandiserArray[merSelectedRow].Merchandiser
            showMerchandiserPickerViewTextfield.resignFirstResponder()
        }
    }
    
    @objc func cancelClick(){
        if pickerview == storePickerView{
            showStorePickerViewTextfield.resignFirstResponder()
        } else if pickerview == cityPickerView{
            showCityPickerViewTextfield.resignFirstResponder()
        } else if pickerview == salesPersonPickerView{
            showSalesPersonPickerViewTextfield.resignFirstResponder()
        } else {
            showMerchandiserPickerViewTextfield.resignFirstResponder()
        }
    }
    
    // -- MARK: picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerview = pickerView
        if pickerView == storePickerView{
            return storeArray.count
        } else if pickerView == cityPickerView{
            return cityArray.count
        } else if pickerView == salesPersonPickerView{
            return salesPersonArray.count
        }
        return merchandiserArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == storePickerView{
            return storeIdArray[row].localize()
        } else if pickerView == cityPickerView{
            return cityArray[row].City
        } else if pickerView == salesPersonPickerView{
            return salesPersonArray[row].SalesPersonStore
        }
        return merchandiserArray[row].Merchandiser
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        
        if pickerView == storePickerView{
            salesSelecteedRow = row
            storeTextfield.text = storeIdArray[row]
            cityArray = webservice.BindCity(storevalue: storeIdArray[row], customer: customer)
            if !cityArray.isEmpty{
                cityTextfield.text = cityArray[0].City
                salesPersonArray = webservice.BindSalesPersonforStore(customer: customer, city: cityArray[0].City, store: storeIdArray[row])
                if !salesPersonArray.isEmpty{
                    salesPersonTextfield.text = salesPersonArray[0].SalesPersonStore
                    merchandiserArray = webservice.BindMerchandiser(customer: customer, city: cityArray[0].City, store: storeIdArray[row], salesperson: salesPersonArray[0].SalesPersonStore)
                    if !merchandiserArray.isEmpty{
                        merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                    }
                }
            }
        } else if pickerView == cityPickerView{
            citySelectedRow = row
            if  !cityArray.isEmpty{
                salesPersonArray = webservice.BindSalesPersonforStore(customer: customer, city: cityArray[row].City, store: storeIdArray[salesSelecteedRow])
                if !salesPersonArray.isEmpty{
                    salesPersonTextfield.text = salesPersonArray[0].SalesPersonStore
                    merchandiserArray = webservice.BindMerchandiser(customer: customer, city: cityArray[row].City, store: storeIdArray[salesSelecteedRow], salesperson: salesPersonArray[0].SalesPersonStore)
                    if !merchandiserArray.isEmpty{
                        merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                    }
                }
            }
        } else if pickerView == salesPersonPickerView {
            if !salesPersonArray.isEmpty{
                salesperosnSelectedRow = row
                merchandiserArray = webservice.BindMerchandiser(customer: customer, city: cityArray[citySelectedRow].City, store: storeIdArray[salesSelecteedRow], salesperson: salesPersonArray[row].SalesPersonStore)
                if !merchandiserArray.isEmpty{
                    merchandiserTextfield.text = merchandiserArray[0].Merchandiser
                }
            }
        } else {
            merSelectedRow = row
        }
    }
    
    // -- MARK: IBActions

    @IBAction func nextButtonTapped(_ sender: Any) {
        if let storeTxt = storeTextfield.text,
            let cityTxt = cityTextfield.text,
            let salespersonTxt = salesPersonTextfield.text,
            let merTxt = merchandiserTextfield.text{
            
            if storeTxt == storeIdArray[0]{
                let alertTitle = "Alert!".localize()
                let alertMessage = "You did not select a store id".localize()
                AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: "OK", onAction: {
                    return
                }, cancelAction: nil, self)
            }
            
            salesRequestDetails.store = storeTxt
            salesRequestDetails.city = cityTxt
            salesRequestDetails.salespersonstore = salespersonTxt
            salesRequestDetails.merchandiser = merTxt
        }
        performSegue(withIdentifier: "showCreditDetails", sender: nil)
    }
}

extension StoreViewController{
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
