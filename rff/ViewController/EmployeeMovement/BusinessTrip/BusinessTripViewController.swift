//
//  BusinessTripViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class BusinessTripViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var showEmpNamePickerTextField: UITextField!
    @IBOutlet weak var transModeTextField: UITextField!
    @IBOutlet weak var showTransModePickerTextField: UITextField!
    
    @IBOutlet weak var selectorExitReEntryVisa: UIView!
    @IBOutlet weak var innerSelectorExitReEntryVisa: UIView!
    @IBOutlet weak var exitReEntryVisaYesButton: UIButton!
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var businessTripAmtTextField: UITextField!
    @IBOutlet weak var amountDescTextField: UITextField!
    @IBOutlet weak var reasonTextField: UITextField!
    
    @IBOutlet weak var airLine_1TextField: UITextField!
    @IBOutlet weak var fromLoc_1TextField: UITextField!
    @IBOutlet weak var ToLoc_1TextField: UITextField!
    @IBOutlet weak var fromDate_1TextField: UITextField!
    @IBOutlet weak var toDate_1TextField: UITextField!
    @IBOutlet weak var visa_1Button: UIButton!
    
    @IBOutlet weak var airLine_2TextField: UITextField!
    @IBOutlet weak var fromLoc_2TextField: UITextField!
    @IBOutlet weak var ToLoc_2TextField: UITextField!
    @IBOutlet weak var fromDate_2TextField: UITextField!
    @IBOutlet weak var toDate_2TextField: UITextField!
    @IBOutlet weak var visa_2Button: UIButton!
    
    @IBOutlet weak var airLine_3TextField: UITextField!
    @IBOutlet weak var fromLoc_3TextField: UITextField!
    @IBOutlet weak var ToLoc_3TextField: UITextField!
    @IBOutlet weak var fromDate_3TextField: UITextField!
    @IBOutlet weak var toDate_3TextField: UITextField!
    @IBOutlet weak var visa_3Button: UIButton!
    
    @IBOutlet weak var meetAndAssistanceTextField: UITextField!
    @IBOutlet weak var luggageAndCargoTextField: UITextField!
    @IBOutlet weak var AirlinesTextField: UITextField!
    @IBOutlet weak var membershipTextField: UITextField!
    @IBOutlet weak var othersTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate.shared.screenSize
    let btWebService = BusinessTripService.instance
    
    let empPickerView = UIPickerView()
    var empSelectedRow = 0
    let transModePickerView = UIPickerView()
    var transModeSelectedRow = 0
    var pickerView = UIPickerView()
    
    var empName = [BusinessTripClass]()
    var transMode = [BusinessTripClass]()
    
    var empId = ""
    var transId = ""
    
    var exitReEntryVisaCheckBox = false
    var visa_1CheckBox = false
    var visa_2CheckBox = false
    var visa_3CheckBox = false
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    var fromDate_1DatePicker = UIDatePicker()
    var toDate_1DatePicker = UIDatePicker()
    var fromDate_2DatePicker = UIDatePicker()
    var toDate_2DatePicker = UIDatePicker()
    var fromDate_3DatePicker = UIDatePicker()
    var toDate_3DatePicker = UIDatePicker()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDatePickerView()
        setUpPickerViews()
        setUpSelectors()
        setUpView()
        
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpDate()
    }
    
    // -- MARK: SetUps
    
    func setUpView(){
        stackViewWidth.constant = screenSize.width - 32
        showTransModePickerTextField.tintColor = .clear
        showEmpNamePickerTextField.tintColor = .clear
        
        destinationTextField.delegate = self
        businessTripAmtTextField.delegate = self
        amountDescTextField.delegate = self
        reasonTextField.delegate = self
        airLine_1TextField.delegate = self
        fromLoc_1TextField.delegate = self
        ToLoc_1TextField.delegate = self
        airLine_2TextField.delegate = self
        fromLoc_2TextField.delegate = self
        ToLoc_2TextField.delegate = self
        airLine_3TextField.delegate = self
        fromLoc_3TextField.delegate = self
        ToLoc_3TextField.delegate = self
        meetAndAssistanceTextField.delegate = self
        luggageAndCargoTextField.delegate = self
        AirlinesTextField.delegate = self
        membershipTextField.delegate = self
        othersTextField.delegate = self
        commentTextView.delegate = self
        
        setUpEmptyText()
    }
    
    func setUpEmptyText(){
        destinationTextField.text = ""
        businessTripAmtTextField.text = ""
        amountDescTextField.text = ""
        reasonTextField.text = ""
        airLine_1TextField.text = ""
        fromLoc_1TextField.text = ""
        ToLoc_1TextField.text = ""
        airLine_2TextField.text = ""
        fromLoc_2TextField.text = ""
        ToLoc_2TextField.text = ""
        airLine_3TextField.text = ""
        fromLoc_3TextField.text = ""
        ToLoc_3TextField.text = ""
        meetAndAssistanceTextField.text = ""
        luggageAndCargoTextField.text = ""
        AirlinesTextField.text = ""
        membershipTextField.text = ""
        othersTextField.text = ""
        startDateTextField.text = ""
        endDateTextField.text = ""
        fromDate_1TextField.text = ""
        toDate_1TextField.text = ""
        fromDate_2TextField.text = ""
        toDate_2TextField.text = ""
        fromDate_3TextField.text = ""
        toDate_3TextField.text = ""
        commentTextView.text = ""
    }
    
    func setUpSelectors(){
        exitReEntryVisaYesButton.setBackgroundImage(UIImage(), for: .normal)
        visa_1Button.setBackgroundImage(UIImage(), for: .normal)
        visa_2Button.setBackgroundImage(UIImage(), for: .normal)
        visa_3Button.setBackgroundImage(UIImage(), for: .normal)
    }
    
    func setUpDate(){
        empName = btWebService.BindDdlEmps(emp_id: AuthServices.currentUserId, lang: LoginViewController.languageChosen)
        transMode = btWebService.BindDdlTrans(lang: LoginViewController.languageChosen)
        initailVlaue()
    }
    
    func initailVlaue(){
        if !empName.isEmpty{
            empId = empName[0].EmpNum
            empNameTextField.text = empName[0].EmpName
        }
        
        if !transMode.isEmpty{
            transId = transMode[0].TransDesc
            transModeTextField.text = transMode[0].TransDesc
        }
    }
    
    
    // -- MARK: IBActions
    
    func handleSuccessAction(action: @escaping () -> Void){
        //self.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            action()
            //self.activityIndicator.stopAnimating()
        })
    }
    
    func isBoxChecked(isCheckedValue: inout Bool, button: UIButton) -> Bool{
        isCheckedValue = !isCheckedValue
        if isCheckedValue == true {
            button.setBackgroundImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
        } else {
            button.setBackgroundImage(UIImage(), for: .normal)
        }
        return isCheckedValue
    }
    
    @IBAction func exitReEntryVisaButtonTapped(_ sender: Any) {
        exitReEntryVisaCheckBox = isBoxChecked(isCheckedValue: &exitReEntryVisaCheckBox, button: exitReEntryVisaYesButton)
    }
    
    @IBAction func visa_1ButtonTapped(_ sender: Any) {
        visa_1CheckBox = isBoxChecked(isCheckedValue: &visa_1CheckBox, button: visa_1Button)
    }
    
    @IBAction func visa_2ButtonTapped(_ sender: Any) {
        visa_2CheckBox = isBoxChecked(isCheckedValue: &visa_2CheckBox, button: visa_2Button)
    }
    
    @IBAction func visa_3ButtonTapped(_ sender: Any) {
        visa_3CheckBox = isBoxChecked(isCheckedValue: &visa_3CheckBox, button: visa_3Button)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to send loan request?",
            actionTitle: "Yes",
            onAction: {
                if self.isReqFieldEmpty(){
                    AlertMessage().showAlertMessage(
                        alertTitle: "Alert",
                        alertMessage: "Please fill all the fields",
                        actionTitle: nil,
                        onAction: nil,
                        cancelAction: "Cancel", self)
                } else {self.submit()}
                
        }, cancelAction: "Cancel", self)
        
    }
    
    func submit(){
        if let empNameTxt = empNameTextField.text,
            let transModeTxt = transModeTextField.text,
            let startDateTxt = startDateTextField.text,
            let endDateTxt = endDateTextField.text,
            let destinationTxt = destinationTextField.text,
            let businessTripAmtTxt = businessTripAmtTextField.text,
            let amountDescTxt = amountDescTextField.text,
            let reasonTxt = reasonTextField.text,
            let airLine_1Txt = airLine_1TextField.text,
            let fromLoc_1Txt = fromLoc_1TextField.text,
            let ToLoc_1Txt = ToLoc_1TextField.text,
            let fromDate_1Txt = fromDate_1TextField.text,
            let toDate_1Txt = toDate_1TextField.text,
            let airLine_2Txt = airLine_2TextField.text,
            let fromLoc_2Txt = fromLoc_2TextField.text,
            let ToLoc_2Txt = ToLoc_2TextField.text,
            let fromDate_2Txt = fromDate_2TextField.text,
            let toDate_2Txt = toDate_2TextField.text,
            let airLine_3Txt = airLine_3TextField.text,
            let fromLoc_3Txt = fromLoc_3TextField.text,
            let ToLoc_3Txt = ToLoc_3TextField.text,
            let fromDate_3Txt = fromDate_3TextField.text,
            let toDate_3Txt = toDate_3TextField.text,
            let meetAndAssistanceTxt = meetAndAssistanceTextField.text,
            let luggageAndCargoTxt = luggageAndCargoTextField.text,
            let AirlinesTxt = AirlinesTextField.text,
            let membershipTxt = membershipTextField.text,
            let othersTxt = othersTextField.text,
            let commentTxt = commentTextView.text{
            
            print("""
                -------------------------------------------------
                empNameTxt            = \(empId)
                transModeTxt          = \(transId)
                exitReEntryVisa       = \(exitReEntryVisaCheckBox)
                startDateTxt          = \(startDateTxt)
                endDateTxt            = \(endDateTxt)
                destinationTxt        = \(destinationTxt)
                businessTripAmtTxt    = \(businessTripAmtTxt)
                amountDescTxt         = \(amountDescTxt)
                reasonTxt             = \(reasonTxt)
                airLine_1Txt          = \(airLine_1Txt)
                visa_1                = \(visa_1CheckBox)
                fromLoc_1Txt          = \(fromLoc_1Txt)
                ToLoc_1Txt            = \(ToLoc_1Txt)
                fromDate_1Txt         = \(fromDate_1Txt)
                toDate_1Txt           = \(toDate_1Txt)
                airLine_2Txt          = \(airLine_2Txt)
                visa_2                = \(visa_2CheckBox)
                fromLoc_2Txt          = \(fromLoc_2Txt)
                ToLoc_2Txt            = \(ToLoc_2Txt)
                fromDate_2Txt         = \(fromDate_2Txt)
                toDate_2Txt           = \(toDate_2Txt)
                airLine_3Txt          = \(airLine_3Txt)
                visa_3                = \(visa_3CheckBox)
                fromLoc_3Txt          = \(fromLoc_3Txt)
                ToLoc_3Txt            = \(ToLoc_3Txt)
                fromDate_3Txt         = \(fromDate_3Txt)
                toDate_3Txt           = \(toDate_3Txt)
                meetAndAssistanceTxt  = \(meetAndAssistanceTxt)
                luggageAndCargoTxt    = \(luggageAndCargoTxt)
                AirlinesTxt           = \(AirlinesTxt)
                membershipTxt         = \(membershipTxt)
                othersTxt             = \(othersTxt)
                commentTxt            = \(commentTxt)
                creator_id            = \(AuthServices.currentUserId)
                comp_id               = 1
                -------------------------------------------------
                """)
            
            let btSentResult = btWebService.SubmitBusinessTrip(emp_id: empId,
                                                               trns_mode: transId,
                                                               exit_Reentry_Visa: exitReEntryVisaCheckBox,
                                                               journey_Start_Date: startDateTxt,
                                                               journey_End_Date: endDateTxt,
                                                               destination: destinationTxt,
                                                               business_Trip_Amount: businessTripAmtTxt,
                                                               amount_Description: amountDescTxt,
                                                               reason_for_business_Trip: reasonTxt,
                                                               airLines1: airLine_1Txt,
                                                               visa1: visa_1CheckBox,
                                                               to_Location1: ToLoc_1Txt,
                                                               from_Location1: fromLoc_1Txt,
                                                               to_Date1: toDate_1Txt,
                                                               from_Date1: fromDate_1Txt,
                                                               airLines2: airLine_2Txt,
                                                               visa2: visa_2CheckBox,
                                                               to_Location2: ToLoc_2Txt,
                                                               from_Location2: fromLoc_2Txt,
                                                               to_Date2: toDate_2Txt,
                                                               from_Date2: fromDate_2Txt,
                                                               airLines3: airLine_3Txt,
                                                               visa3: visa_3CheckBox,
                                                               to_Location3: ToLoc_3Txt,
                                                               from_Location3: fromLoc_3Txt,
                                                               to_Date3: ToLoc_3Txt,
                                                               from_Date3: fromDate_3Txt,
                                                               meet_Assistance: meetAndAssistanceTxt,
                                                               luggage_Cargo: luggageAndCargoTxt,
                                                               air_Lines: AirlinesTxt,
                                                               membership_Card_No: membershipTxt,
                                                               others: othersTxt,
                                                               comment: commentTxt,
                                                               creator_id: AuthServices.currentUserId,
                                                               comp_id: "1")
            handleSentResultValue(result: btSentResult)
            
        }
    }
    
    func isReqFieldEmpty() -> Bool{
        if let empNameTxt = empNameTextField.text,
        let transModeTxt = transModeTextField.text,
        let startDateTxt = startDateTextField.text,
        let endDateTxt = endDateTextField.text,
        let destinationTxt = destinationTextField.text,
        let businessTripAmtTxt = businessTripAmtTextField.text,
        let amountDescTxt = amountDescTextField.text,
        let reasonTxt = reasonTextField.text,
        let airLine_1Txt = airLine_1TextField.text,
        let fromLoc_1Txt = fromLoc_1TextField.text,
        let ToLoc_1Txt = ToLoc_1TextField.text,
        let fromDate_1Txt = fromDate_1TextField.text,
        let toDate_1Txt = toDate_1TextField.text{
            if empNameTxt == "Select Employee" ||
                transModeTxt == "Select Employee" ||
                startDateTxt == "" ||
                endDateTxt == "" ||
                destinationTxt == "" ||
                businessTripAmtTxt == "" ||
                amountDescTxt == "" ||
                reasonTxt == "" ||
                airLine_1Txt == "" ||
                fromLoc_1Txt == "" ||
                ToLoc_1Txt == "" ||
                fromDate_1Txt == "" ||
                toDate_1Txt == ""{
                    return true
            }
        }
        return false
    }
    
    func handleSentResultValue(result: String){
        if result != "" {
            AlertMessage().showAlertMessage(
                alertTitle: "Alert",
                alertMessage: "Could not send the business trip request",
                actionTitle: nil,
                onAction: nil,
                cancelAction: "OK", self)
        } else {
            AlertMessage().showAlertMessage(
                alertTitle: "Success",
                alertMessage: "Business trip request is sent successfully",
                actionTitle: "OK",
                onAction: {
                    
                    self.handleSuccessAction {
                        self.setValueToDefault()
                    }
                    
            }, cancelAction: nil, self)
        }
    }
    
    func setValueToDefault(){
        empSelectedRow = 0
        empNameTextField.text = "Select Employee"
        empPickerView.selectRow(0, inComponent: 0, animated: true)
        transModeSelectedRow = 0
        transModeTextField.text = "Select Transportation"
        transModePickerView.selectRow(0, inComponent: 0, animated: true)
        
        exitReEntryVisaCheckBox = false
        visa_1CheckBox = false
        visa_2CheckBox = false
        visa_3CheckBox = false
        
        setUpEmptyText()
        setUpSelectors()
        scrollView.scrollTo(direction: .Top, animated: false)
    }
}

// -- MARK: Picker View

extension BusinessTripViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func setUpPickerViews(){
        PickerviewAction().showPickView(txtfield: showEmpNamePickerTextField,
                                        pickerview: empPickerView,
                                        viewController: self,
                                        cancelSelector: #selector(cancelTapped),
                                        doneSelector: #selector(doneTapped))
        PickerviewAction().showPickView(txtfield: showTransModePickerTextField,
                                        pickerview: transModePickerView,
                                        viewController: self,
                                        cancelSelector: #selector(cancelTapped),
                                        doneSelector: #selector(doneTapped))
    }
    
    @objc func doneTapped(){
        if pickerView == empPickerView {
            empNameTextField.text = empName[empSelectedRow].EmpName
            empId = empName[empSelectedRow].EmpNum
            showEmpNamePickerTextField.resignFirstResponder()
        }
        else{
            transModeTextField.text = "\(transMode[transModeSelectedRow].TransDesc)"
            showTransModePickerTextField.resignFirstResponder()
        }
    }
    
    @objc func cancelTapped(){
        if pickerView == empPickerView { showEmpNamePickerTextField.resignFirstResponder() }
        else{ showTransModePickerTextField.resignFirstResponder() }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == empPickerView{ return empName.count }
        return transMode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerView = pickerView
        if pickerView == empPickerView{ return empName[row].EmpName }
        return "\(transMode[row].TransDesc)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == empPickerView{ empSelectedRow = row }
        else { transModeSelectedRow = row }
    }
    
}

// -- MARK: Date Picker

extension BusinessTripViewController{
    func setUpDatePickerView(){
        PickerviewAction().showDatePicker(txtfield: startDateTextField,
                                          datePicker: startDatePicker,
                                          title: "Start Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: endDateTextField,
                                          datePicker: endDatePicker,
                                          title: "End Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: fromDate_1TextField,
                                          datePicker: fromDate_1DatePicker,
                                          title: "From Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: toDate_1TextField,
                                          datePicker: toDate_1DatePicker,
                                          title: "To Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: fromDate_2TextField,
                                          datePicker: fromDate_2DatePicker,
                                          title: "From Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: toDate_2TextField,
                                          datePicker: toDate_2DatePicker,
                                          title: "To Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: fromDate_3TextField,
                                          datePicker: fromDate_3DatePicker,
                                          title: "From Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
        
        PickerviewAction().showDatePicker(txtfield: toDate_3TextField,
                                          datePicker: toDate_3DatePicker,
                                          title: "To Date",
                                          viewController: self,
                                          datePickerSelector: #selector(dateSelectionAction(sender:)),
                                          doneSelector: #selector(doneDateButtonTapped(sender:)))
    }
    
    @objc func dateSelectionAction(sender: UIDatePicker){
        switch sender{
        case startDatePicker: setDateText(txtField: startDateTextField, date: sender.date)
        case endDatePicker: setDateText(txtField: endDateTextField, date: sender.date)
        case fromDate_1DatePicker: setDateText(txtField: fromDate_1TextField, date: sender.date)
        case toDate_1DatePicker: setDateText(txtField: toDate_1TextField, date: sender.date)
        case fromDate_2DatePicker: setDateText(txtField: fromDate_2TextField, date: sender.date)
        case toDate_2DatePicker: setDateText(txtField: toDate_2TextField, date: sender.date)
        case fromDate_3DatePicker: setDateText(txtField: fromDate_3TextField, date: sender.date)
        case toDate_3DatePicker: setDateText(txtField: toDate_3TextField, date: sender.date)
        default: break
        }
    }
    
    func setDateText(txtField: UITextField, date: Date){
        txtField.text = getStringDate(date: date)
    }
    
    @objc func doneDateButtonTapped(sender: UIBarButtonItem){
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        fromDate_1TextField.resignFirstResponder()
        toDate_1TextField.resignFirstResponder()
        fromDate_2TextField.resignFirstResponder()
        toDate_2TextField.resignFirstResponder()
        fromDate_3TextField.resignFirstResponder()
        toDate_3TextField.resignFirstResponder()
    }
}

// -- MARK: Handling Text

extension BusinessTripViewController: UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension BusinessTripViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 73, right: 0)
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

















