//
//  InOutDeductionViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InOutDeductionViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var empTextField: UITextField!
    @IBOutlet weak var showEmpTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var DelayMinLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    @IBOutlet weak var aiContainer: UIView!
    
    // -- MARK: variables
    
    let webservice = InOutDeductionService.instance
    let screenSize = AppDelegate.shared.screenSize
    let lang = LoginViewController.languageChosen
    let currentUser = AuthServices.currentUserId
    var textfield = UITextField()
    
    var empsArray = [Emp_InfoModul]()
    var empsPickerView = UIPickerView()
    var empIndex = 0
    var oldEmpIndex = 0
    
    var date = ""
    var sTime = ""
    var eTime = ""
    var startTime = Date()
    var toTime = Date()
    
    var datePickerView: UIDatePicker = UIDatePicker()
    let dateDatePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        title = setLocalizedNavTitle(arabocTxt: "اذن خروج", englishTxt: "In Out Deduction")
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        setUpData()
        stop()
    }
    
    // -- MARK: setUps
    
    func setUpView(){
        showEmpTextField.tintColor = .clear
        dateTextField.tintColor = .clear
        startTimeTextField.tintColor = .clear
        endTimeTextField.tintColor = .clear
        
        dateTextField.delegate = self
        startTimeTextField.delegate = self
        endTimeTextField.delegate = self
        commentTextView.delegate = self
        
        stackViewWidth.constant = screenSize.width - 32
        
        setPickerView()
        setDateAndPicker()
    }
    
    func setUpData(){
        empsArray = webservice.Bind_dllEmp(lang: lang, emp_id: currentUser, formid: 1003)
        setInitailAction()
    }
    
    func setInitailAction(){
        if !empsArray.isEmpty{
            empTextField.text = empsArray[empIndex].Emp_Name
        }
        
        dateTextField.text = ""
        startTimeTextField.text = ""
        endTimeTextField.text = ""
        DelayMinLabel.text = ""
        commentTextView.text = ""
    }
    
    // -- MARK: Helper functions
    
    func start(){startLoader(superView: aiContainer, activityIndicator: ai)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: ai)}
    
    func displayWarningLayer(view: UIView){
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
    }
    
    func hideWarningLayer(view: UIView){
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0
    }
    
    func runRequest(date: String, start: String, end: String, delay: String, comment: String){
        print("""
            company     : 1
            emp_id      : \(empsArray[empIndex].Emp_Id)
            formId      : \(InOutDudection_formId)
            date        : \(date)
            start_date  : \(start)
            end_date    : \(end)
            delay_min   : \(delay)
            creator     : \(currentUser)
            comment     : \(comment)
            """)
        
        let result = webservice.save_data(comp: 1,
                                          emp_id_selected: empsArray[empIndex].Emp_Id,
                                          formId: "\(InOutDudection_formId)",
                                          date: date,
                                          fromtime: start,
                                          totime: end,
                                          total_mins: delay,
                                          creator_emp_id: currentUser,
                                          comment: comment)
        
        if result == "" {
            AlertMessage().showAlertMessage(alertTitle: "Success".localize(), alertMessage: "In-out deduction request sent successfully".localize(), actionTitle: "OK", onAction: {
                self.empIndex = 0
                self.setInitailAction()
            }, cancelAction: nil, self)
        } else {
            AlertMessage().showAlertMessage(alertTitle: "Alert".localize(), alertMessage: result, actionTitle: nil, onAction: nil, cancelAction: "OK", self)
        }
    }
    
    // -- MARK: IBAction
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if let dateText = dateTextField.text, let sText = startTimeTextField.text, let eText = endTimeTextField.text, let delayText = DelayMinLabel.text, let commentText = commentTextView.text {
            
            if dateText == "" || sText == "" || eText == "" || delayText == "" {
                AlertMessage().showAlertMessage(alertTitle: "Alert".localize(),
                                                alertMessage: "Please fill all the fields".localize(),
                                                actionTitle: nil,
                                                onAction: nil,
                                                cancelAction: "OK", self)
                
                return
            }
            
            AlertMessage().showAlertMessage(
                alertTitle: "Confirmation".localize(),
                alertMessage: "Do you want to send in-out deduction request?".localize(),
                actionTitle: "Yes".localize(),
                onAction: {
                    
                    self.start()
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        self.runRequest(date: dateText, start: sText, end: eText, delay: delayText, comment: commentText)
                        self.stop()
                    })
                    
            }, cancelAction: "Cancel".localize(), self)
        }
    }
}

// -- MARK: Picker view

extension InOutDeductionViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func setPickerView(){
        PickerviewAction().showPickView(txtfield: showEmpTextField,
                                        pickerview: empsPickerView,
                                        viewController: self,
                                        cancelSelector: #selector(cancelPickerTapped),
                                        doneSelector: #selector(donePickerTapped))
    }
    
    @objc func cancelPickerTapped(){
        showEmpTextField.resignFirstResponder()
    }
    
    @objc func donePickerTapped(){
        empTextField.text = empsArray[empIndex].Emp_Name
        showEmpTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return empsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return empsArray[row].Emp_Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        empIndex = row
    }
}

// -- MARK: Date and time picker

extension InOutDeductionViewController{
    func setDateAndPicker(){
        PickerviewAction().showDatePicker(txtfield: dateTextField,
                                          datePicker: dateDatePicker,
                                          title: "Date".localize(),
                                          viewController: self,
                                          datePickerSelector: #selector(handleDatePicker(sender:)),
                                          doneSelector: #selector(doneTapped))
        
        PickerviewAction().showTimePicker(txtfield: startTimeTextField,
                                          datePicker: startTimePicker,
                                          title: "Start Time".localize(),
                                          viewController: self,
                                          datePickerSelector: #selector(handleDatePicker(sender:)),
                                          doneSelector: #selector(doneTapped))
        
        PickerviewAction().showTimePicker(txtfield: endTimeTextField,
                                          datePicker: endTimePicker,
                                          title: "End Time".localize(),
                                          viewController: self,
                                          datePickerSelector: #selector(handleDatePicker(sender:)),
                                          doneSelector: #selector(doneTapped))
        
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let minDate = calendar.date(byAdding: DateComponents(), to: Date())
        let minStartTime = calendar.date(byAdding: .minute, value: 0, to: Date())
        let minEndTime = calendar.date(byAdding: .minute, value: 1, to: startTime)
        let currentDate = Date()
        
        dateDatePicker.minimumDate = minDate
        endTimePicker.minimumDate = minEndTime
        
        if sender == dateDatePicker {
            date = sender.date.dateToString()
            if sender.date == currentDate{
                startTimePicker.minimumDate = minStartTime
            }
        }
        else if sender == startTimePicker {
            sTime = sender.date.timeToString()
            startTime = sender.date
        }
        else {
            eTime = sender.date.timeToString()
            toTime = sender.date
        }
    }
    
    @objc func doneTapped(){
        
        if textfield == dateTextField {
            dateTextField.text = (date == "") ? Date().dateToString() : date
            dateTextField.resignFirstResponder()
            
        } else if textfield == startTimeTextField {
            startTimeTextField.text = (sTime == "") ? Date().timeToString() : sTime
            startTimeTextField.resignFirstResponder()
            
        } else if textfield == endTimeTextField {
            endTimeTextField.text = (eTime == "") ? Date().timeToString() : eTime
            endTimeTextField.resignFirstResponder()
            
        }
        
        if textfield != dateTextField{
            if let sText = startTimeTextField.text, let eText = endTimeTextField.text {
                if sText == "" || eText == ""{
                    return
                }
                getDiff(start: startTime, to: toTime)
            }
        }
    }
    
    func getDiff(start: Date, to: Date){
        let dateComponents = NSCalendar.current.dateComponents([.minute], from: start, to: to)
        if let diff = dateComponents.minute {
            DelayMinLabel.text = "\(diff)"
        }
    }
    
}

extension InOutDeductionViewController: UITextViewDelegate, UITextFieldDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
    }
}

extension InOutDeductionViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 72, right: 0)
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
