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
    @IBOutlet weak var empTextField: UITextField!
    @IBOutlet weak var showEmpPickerTextField: UITextField!
    @IBOutlet weak var activityIndicatorContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate.shared.screenSize
    let webservice = LoanService.instance
    let gaurantorPickerview: UIPickerView = UIPickerView()
    let empPickerview: UIPickerView = UIPickerView()
    
    var gaurantorsArray = [EmpInfoModul_2]()
    var gaurantorsNamesArray = [String]()
    var gaurantorsIdsArray = [String]()
    var empArray = [EmpInfoModul_2]()
    var empNamesArray = [String]()
    var empIdsArray = [String]()
    
    let langChosen = LoginViewController.languageChosen
    var textField = UITextField()
    
    var empSelectedRow = 0
    var gaurantorSelectedRow = 0
    var loanType = 5
    var amtOldText: String = ""
    var paymentOldText: String = ""
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpSelectors()
        setViewAlignment()
        setUpPickerView()
        setUpSelectors()
        setUpCommentDisplay()
        setUpToolBarButtons()
        setSlideMenu(controller: self, menuButton: menuBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpArray()
        stop()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // -- MARK: Set ups
    
    func setUpViews(){
        stackViewWidth.constant = screenSize.width - 32
        
        amtRequiredTextField.delegate = self
        paymnetPeriodTextField.delegate = self
        showEmpPickerTextField.tintColor = .clear
        showGaurantorPickerTextField.tintColor = .clear
        
        amyEachMonthLabel.text = "0.0 " + "each month".localize()
        
        gaurantorsNamesArray = [""]
        gaurantorsIdsArray = [""]
        empNamesArray = ["Select employee"]
        empIdsArray = [""]
        activityIndicator.startAnimating()
    }
    
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
        commentTextView.delegate = self
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    func setUpData(){
        gaurantorsArray = webservice.BindEmployees(
            emp_number: "992",
            lang: 1)
        empArray = webservice.BindEmployees(
            emp_number: AuthServices.currentUserId,
            lang: 1)
    }
    
    func initalValues(){
        if empNamesArray.isEmpty{
            empTextField.text = empNamesArray[0]
            empPickerview.selectRow(0, inComponent: 0, animated: false)
            empSelectedRow = 0
        } else {
            empTextField.text = empNamesArray[1]
            empPickerview.selectRow(1, inComponent: 0, animated: false)
            empSelectedRow = 1
        }
        
        gaurantorTextField.text = gaurantorsNamesArray[0]
        
    }
    
    func setUpArray(){
        setUpData()
        for emp in empArray{
            empNamesArray.append(emp.Emp_Name)
            empIdsArray.append(emp.Emp_ID)
        }
        
        for gaurantor in gaurantorsArray{
            gaurantorsNamesArray.append(gaurantor.Emp_Name)
            gaurantorsIdsArray.append(gaurantor.Emp_ID)
        }
        initalValues()
    }
    
    // -- MARK: Helper functions
    func start(){startLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)}
    func stop(){stopLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)}
    
    func handleSuccessAction(action: @escaping () -> Void){
        self.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            action()
            self.stop()
        })
    }
    
    func submit(paymentText: String, amtText: String, commentText: String){
        var error = ""
        let submitLoanResult = webservice.SubmitEmpLoan(
            login_emp_number: AuthServices.currentUserId,
            guarantor: gaurantorsIdsArray[gaurantorSelectedRow],
            loan_empnumber: empIdsArray[empSelectedRow],
            loantype: "\(loanType)",
            paymentperiod: paymentText,
            Amt_Required: amtText,
            comment: commentText)
        
        for result in submitLoanResult{
            error = result.error
        }
        
        if error != "" {
            AlertMessage().showAlertMessage(
                alertTitle: "Alert",
                alertMessage: "Could not send the loan request",
                actionTitle: nil,
                onAction: nil,
                cancelAction: "OK", self)
        } else {
            AlertMessage().showAlertMessage(
                alertTitle: "Success",
                alertMessage: "Loan request is sent successfully",
                actionTitle: "OK",
                onAction: {
                    
                    self.handleSuccessAction {
                        self.setUpViewToDefault()
                    }
                    
            }, cancelAction: nil, self)
        }
    }
    
    func setUpViewToDefault(){
        initalValues()
        setUpDefaultSelector()
        loanType = 5
        amtOldText = ""
        amtRequiredTextField.text = ""
        paymentOldText = ""
        paymnetPeriodTextField.text = ""
        amyEachMonthLabel.text = "0.0 " + "each month".localize()
        commentTextView.text = ""
        
        gaurantorPickerview.selectRow(0, inComponent: 0, animated: false)
        gaurantorSelectedRow = 0
        scrollView.scrollTo(direction: .Top, animated: false)
    }
    
    // -- MARK: IBAction
    
    @IBAction func furnishingButtonTapped(_ sender: Any) {
        furnishingButton.backgroundColor = mainBackgroundColor
        arrivalButton.backgroundColor = .white
        urgentButton.backgroundColor = .white
        exceptionalBuuton.backgroundColor = .white
        othersBuuton.backgroundColor = .white
        
        loanType = 1
    }
    
    @IBAction func arrivalButtonTapped(_ sender: Any) {
        furnishingButton.backgroundColor = .white
        arrivalButton.backgroundColor = mainBackgroundColor
        urgentButton.backgroundColor = .white
        exceptionalBuuton.backgroundColor = .white
        othersBuuton.backgroundColor = .white
        
        loanType = 2
    }
    
    @IBAction func urgentButtonTapped(_ sender: Any) {
        furnishingButton.backgroundColor = .white
        arrivalButton.backgroundColor = .white
        urgentButton.backgroundColor = mainBackgroundColor
        exceptionalBuuton.backgroundColor = .white
        othersBuuton.backgroundColor = .white
        
        loanType = 3
    }
    
    @IBAction func exceptionalButtonTapped(_ sender: Any) {
        furnishingButton.backgroundColor = .white
        arrivalButton.backgroundColor = .white
        urgentButton.backgroundColor = .white
        exceptionalBuuton.backgroundColor = mainBackgroundColor
        othersBuuton.backgroundColor = .white
        
        loanType = 4
    }
    
    @IBAction func othersButtonTapped(_ sender: Any) {
        furnishingButton.backgroundColor = .white
        arrivalButton.backgroundColor = .white
        urgentButton.backgroundColor = .white
        exceptionalBuuton.backgroundColor = .white
        othersBuuton.backgroundColor = mainBackgroundColor
        
        loanType = 5
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to send loan request?",
            actionTitle: "Yes",
            onAction: {
                
                if let empText = self.empTextField.text,
                    let amtText = self.amtRequiredTextField.text,
                    let gaurantorText = self.gaurantorTextField.text,
                    let paymentText = self.paymnetPeriodTextField.text,
                    let commentText = self.commentTextView.text{
                    
                    if empText == self.empNamesArray[0] ||
                        amtText.isEmpty ||
                        gaurantorText == self.gaurantorsNamesArray[0] ||
                        paymentText.isEmpty{
                        
                        AlertMessage().showAlertMessage(
                            alertTitle: "Alert",
                            alertMessage: "Please fill all the fields",
                            actionTitle: nil,
                            onAction: nil,
                            cancelAction: "Cancel", self)
                    } else {
                        self.activityIndicator.startAnimating()
                        self.handleSuccessAction {
                            self.submit(paymentText: paymentText, amtText: amtText, commentText: commentText)
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
                
        }, cancelAction: "Cancel", self)
        
    }
}

extension LoanViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func setUpPickerView(){
        PickerviewAction().showPickView(
            txtfield: showEmpPickerTextField,
            pickerview: empPickerview,
            viewController: self,
            cancelSelector: #selector(didCancelButtonTapped),
            doneSelector: #selector(didDoneButtonTapped))
        
        PickerviewAction().showPickView(
            txtfield: showGaurantorPickerTextField,
            pickerview: gaurantorPickerview,
            viewController: self,
            cancelSelector: #selector(didCancelButtonTapped),
            doneSelector: #selector(didDoneButtonTapped))
    }
    
    @objc func didDoneButtonTapped(){
        if textField == showEmpPickerTextField{
            empTextField.text = empNamesArray[empSelectedRow]
            showEmpPickerTextField.resignFirstResponder()
        } else {
            gaurantorTextField.text = gaurantorsNamesArray[gaurantorSelectedRow]
            showGaurantorPickerTextField.resignFirstResponder()
            
        }
    }
    
    @objc func didCancelButtonTapped(){
        if textField == showGaurantorPickerTextField{
            showGaurantorPickerTextField.resignFirstResponder()
        } else {
            showEmpPickerTextField.resignFirstResponder()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == empPickerview{
            return empNamesArray.count
        }
        return gaurantorsNamesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == empPickerview{
            return empNamesArray[row]
        }
        return gaurantorsNamesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == empPickerview{
            empSelectedRow = row
        } else {
            gaurantorSelectedRow = row
        }
    }
}

extension LoanViewController: UITextFieldDelegate, UITextViewDelegate{
    func setUpToolBarButtons(){
        setUpKeyboardToolBar(
            textfield: amtRequiredTextField,
            viewController: self,
            cancelTitle: nil,
            cancelSelector: nil,
            doneTitle: "Done",
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
        paymnetPeriodTextField.resignFirstResponder()
    }
    
    @objc func didCancelToolBarButtonTapped(){
        amtRequiredTextField.resignFirstResponder()
        paymnetPeriodTextField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField = textField
        if let amtText = amtRequiredTextField.text, let paymentText = paymnetPeriodTextField.text {
            amtOldText = amtText
            paymentOldText = paymentText
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let amtText = amtRequiredTextField.text,
            let amtDouble = Double(amtText),
            let paymentText = paymnetPeriodTextField.text,
            let paymentDouble = Double(paymentText){
            
            if (amtText == amtOldText && paymentText == paymentOldText) || amtText.isEmpty || paymentText.isEmpty {return}
            let result = amtDouble / paymentDouble
            let resultFormatted = String(format: "%.2f", result)
            
            amyEachMonthLabel.text = "\(resultFormatted) " + "each month".localize()
            
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

extension LoanViewController{
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




