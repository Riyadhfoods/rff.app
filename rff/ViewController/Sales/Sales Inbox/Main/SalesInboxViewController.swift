//
//  SalesInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesInboxViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var ListTextfield: UITextField!
    @IBOutlet weak var showListPickerTextfield: UITextField!
    @IBOutlet weak var seachTextfield: UITextField!
    @IBOutlet weak var searchOutlet: UIButton!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: variables
    
    let screenSize = AppDelegate.shared.screenSize
    let languageChosen = LoginViewController.languageChosen
    let segueId_transferStyle = "showTransferStyle"
    let segueId_orderStyle = "showOrderStyle"
    let segueId_returnStyle = "showReturnStyle"
    
    let selectListPickerView: UIPickerView = UIPickerView()
    let selectListArray = ["Select a list", "Order List", "Transfer List", "Return List"]
    var selectedListIndex: Int = 0
    
    let salesWebservice = SalesInboxService.instance
    var salesArray: [SalesInboxModul] = [SalesInboxModul]()
    
    var currentUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ---------------
        setViewAlignment()
        stop()
        
        ListTextfield.tintColor = .clear
        showListPickerTextfield.tintColor = .clear
        seachTextfield.placeholder = "Search content".localize()
        
        setCustomDefaultNav(navItem: navigationItem)
        setUpPickerView()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CommonFunction.shared.getCurrentViewContoller(Target: self)
    }
    
    // -- MARK: Setups
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showListPickerTextfield, pickerview: selectListPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    func start(){startLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: activityIndicator)}
    
    // -- MARK: objc functions
    
    @objc func cancelClick(){
        showListPickerTextfield.resignFirstResponder()
    }
    
    @objc func doneClick(){
        ListTextfield.text = selectListArray[selectedListIndex].localize()
        showListPickerTextfield.resignFirstResponder()
    }
    
    // -- MARK: Pickerview data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectListArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectListArray[row].localize()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedListIndex = row
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        if ListTextfield.text == selectListArray[0].localize(){
            let alertTitle = "Alert".localize()
            let alertMessage = "You did not select a list".localize()
            AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
        }
        
        start()
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.01) {
            if let searchText = self.seachTextfield.text{
                self.salesArray = self.salesWebservice.GetSalesInbox(id: self.selectedListIndex, emp_id: AuthServices.currentUserId, searchtext: searchText, index: 0)
            } else { return }
            self.stop()
            
            switch self.selectedListIndex {
            case 1: self.performSegue(withIdentifier: self.segueId_orderStyle, sender: nil)
            case 2: self.performSegue(withIdentifier: self.segueId_transferStyle, sender: nil)
            case 3: self.performSegue(withIdentifier: self.segueId_returnStyle, sender: nil)
            default: break
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case segueId_orderStyle:
            if let vc = segue.destination as? OrderStyleTableViewController{
                vc.listIndexSelected = self.selectedListIndex
                vc.salesArray = salesArray
            }
        case segueId_transferStyle:
            if let vc = segue.destination as? TansferStyleTableViewController{
                vc.listIndexSelected = self.selectedListIndex
                vc.salesArray = salesArray
            }
        case segueId_returnStyle:
            if let vc = segue.destination as? ReturnStyleTableViewController{
                vc.listIndexSelected = self.selectedListIndex
                vc.salesArray = salesArray
            }
        default:
            break
        }
    }
    
    func getSearchText() -> String{
        if let search = seachTextfield.text{
            return search
        }
        return ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}









