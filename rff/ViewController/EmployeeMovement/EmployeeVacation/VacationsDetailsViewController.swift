//
//  VacationsDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class VacationsDetailsViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var empTextField: UITextField!
    @IBOutlet weak var showEmpPickerView: UITextField!
    @IBOutlet weak var empDropdown: UIImageView!
    @IBOutlet weak var delegateTextField: UITextField!
    @IBOutlet weak var showDelegatePickerView: UITextField!
    @IBOutlet weak var delegateDropdown: UIImageView!
    @IBOutlet weak var numOfDays: UITextField!
    @IBOutlet weak var balanceVacation: UILabel!
    @IBOutlet weak var leaveStartDatePickerView: UITextField!
    @IBOutlet weak var ReturnDatePickerView: UITextField!
    @IBOutlet weak var vacationTypeTextField: UITextField!
    @IBOutlet weak var showVacationTypePickerView: UITextField!
    @IBOutlet weak var vacationTypeDropdown: UIImageView!
    @IBOutlet weak var exitReEntryDays: UITextField!
    @IBOutlet weak var extraDays: UILabel!
    @IBOutlet weak var settlementAmount: UILabel!
    
    @IBOutlet weak var selectorByCompany: UIView!
    @IBOutlet weak var selectorCash: UIView!
    @IBOutlet weak var selectorExitYes: UIView!
    @IBOutlet weak var selectorExitNo: UIView!
    
    @IBOutlet weak var innerSelectorByCompany: UIView!
    @IBOutlet weak var innerSelectorCash: UIView!
    @IBOutlet weak var innerSelectorExitYes: UIView!
    @IBOutlet weak var innerSelectorExitNo: UIView!
    
    @IBOutlet weak var byCompanyButton: UIButton!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var ExitYesButton: UIButton!
    @IBOutlet weak var exitNoBuuton: UIButton!
    
    @IBOutlet weak var dependentTicket: UITextField!
    @IBOutlet weak var visaReuireTableView: UITableView!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Constrains
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.isTranslucent = true
        tb.tintColor = UIColor.black
        tb.sizeToFit()
        tb.isUserInteractionEnabled = true
        
        return tb
    }()
    
    let leaveDatePickerDatePicker: UIDatePicker = UIDatePicker()
    let returnDatePickerDatePicker: UIDatePicker = UIDatePicker()
    let pickViewEmpName: UIPickerView = UIPickerView()
    let pickViewEmpDelegate: UIPickerView = UIPickerView()
    let vacationTypePickerViewPikcer: UIPickerView = UIPickerView()
    
    var datePickerView: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    var textfield = UITextField()
    //static var i: Int = 0
    
    // -- MARK: Variables
    
    let cell_Id = "cell_visaRequires"
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    let screenSize = AppDelegate().screenSize
    let webservice = Login()
    
    var empVacationDetails = EmpVac()
    var vacationTypeArray = [EmpVac]()
    var empVacArray = [EmpVac]()
    var empDelegateArray = [EmpVac]()
    var ticketdependentArray = [DepVacTicket]()
    
    // To store vacation type id
    var vacationTypeId: String = ""
    var empNametextChosen: String?
    var empDelegatetextChosen: String?
    var vacationTypetextChosen: String?
    var empNameIndex: Int = 0
    var empDelegateIndex: Int = 0
    var vacationTypeIndex: Int = 0
    var languangeChosen: Int = LoginViewController.languageChosen
    var startDateChosen = Date()
    var ticketRequestRecieved: Int = 0
    var newSettlementRecieved: String = ""
    var delegateId: String = ""
    
    let cornerRadiusValueHolder: CGFloat = 12
    let cornerRadiusValueInner: CGFloat = 11
    let cornerRadiusValueView: CGFloat = 9
    
    // 0 --> no and 1 --> yes
    var requiredVisaSelected: Int = 0
    // 0 --> no and 1 --> yes
    var exitReEntryVisaSelected: Int = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setupArrays()
        setUpEmployeeDetails()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        startDateChosen = getStartDate()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if newSettlementRecieved != "" {
            settlementAmount.text = newSettlementRecieved
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // -- MARK: Set ups
    
    func setUpView(){
        stackViewWidth.constant = screenSize.width - 32
        setCustomDefaultNav(navItem: navigationItem)
        leaveStartDatePickerView.tintColor = .clear
        ReturnDatePickerView.tintColor = .clear
        showVacationTypePickerView.tintColor = .clear
        showEmpPickerView.tintColor = .clear
        showDelegatePickerView.tintColor = .clear
        
        comment.text = ""
        comment.delegate = self
        numOfDays.delegate = self
        exitReEntryDays.delegate = self
        
        setUpPickerView()
        setupDatePicker()
        setUpToolBar()
        setUpCommentDisplay()
        sutupTicketRequestSelector()
        sutupExitSelector()
    }
    
    func setUpCommentDisplay(){
        comment.layer.cornerRadius = 5.0
        comment.layer.borderColor = mainBackgroundColor.cgColor
        comment.layer.borderWidth = 1
    }
    
    func sutupTicketRequestSelector(){
        selectorByCompany.layer.cornerRadius = cornerRadiusValueHolder
        selectorCash.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorByCompany.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorCash.layer.cornerRadius = cornerRadiusValueInner
        
        byCompanyButton.layer.cornerRadius = cornerRadiusValueView
        byCompanyButton.backgroundColor = .white
        cashButton.layer.cornerRadius = cornerRadiusValueView
        cashButton.backgroundColor = mainBackgroundColor
    }
    
    func sutupExitSelector(){
        selectorExitYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorExitNo.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorExitYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorExitNo.layer.cornerRadius = cornerRadiusValueInner
        
        ExitYesButton.layer.cornerRadius = cornerRadiusValueView
        ExitYesButton.backgroundColor = .white
        exitNoBuuton.layer.cornerRadius = cornerRadiusValueView
        exitNoBuuton.backgroundColor = mainBackgroundColor
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setupArrays(){
        if let userId = AuthServices.currentUserId{
            empVacArray = webservice.BindEmpsVacationsDropDown(langid: languangeChosen, Emp_no: userId)
            if empVacArray.isEmpty{
                self.empTextField.text = "No Employee name available"
            } else { self.empTextField.text = empVacArray[0].Emp_Ename }
            
            empDelegateArray = webservice.BindDelegateVacationsDropDown(langid: languangeChosen, Emp_no: userId)
            
            vacationTypeArray = webservice.BindVacationType_DDL(langid: languangeChosen)
            
            if vacationTypeArray.isEmpty{
                self.vacationTypeTextField.text = "No Vacation Type available"
            } else {
                self.vacationTypeTextField.text = vacationTypeArray[2].Vac_Desc
                vacationTypeId = vacationTypeArray[2].Vac_Type
            }
            
            empVacationDetails = webservice.GetEmpVacationDetails(langid: languangeChosen, Emp_no: userId)
            ticketdependentArray = webservice.GetEmpVacationTickets(emp_id: userId, langId: languangeChosen)
        }
    }
    
    func setUpEmployeeDetails(){
        setValuesForEmployeeDetails(textField: numOfDays, text: empVacationDetails.Number_Days)
        setValuesForEmployeeDetails(label: balanceVacation, text:
            empVacationDetails.Balance_Vacation)
        setValuesForEmployeeDetails(textField: leaveStartDatePickerView, text: empVacationDetails.Leave_Start_Dt)
        setValuesForEmployeeDetails(textField: ReturnDatePickerView, text: empVacationDetails.Leave_Return_Dt)
        setValuesForEmployeeDetails(textField: exitReEntryDays, text: empVacationDetails.ExitReEntry)
        setValuesForEmployeeDetails(label: settlementAmount, text: empVacationDetails.TotalSettlementAmount)
        setValuesForEmployeeDetails(label: extraDays, text: empVacationDetails.ExtraDays)
    }
    
    func setValuesForEmployeeDetails(textField: UITextField, text: String){
        textField.text = text.isEmpty ? "    " : text
    }
    
    func setValuesForEmployeeDetails(label: UILabel, text: String){
        label.text = text.isEmpty ? "    " : text
    }
    
    // -- MARK: IBAction
    
    var ticketRequest: Int = 0
    @IBAction func byCompanyButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = mainBackgroundColor
        cashButton.backgroundColor = .white
        ticketRequest = 1
        
        changeSettlementAmount(ticket: ticketRequest)
        print(empVacationDetails.TotalSettlementAmount)
    }
    
    @IBAction func cashButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = .white
        cashButton.backgroundColor = mainBackgroundColor
        ticketRequest = 0
        
        changeSettlementAmount(ticket: ticketRequest)
        print(empVacationDetails.TotalSettlementAmount)
    }
    
    func changeSettlementAmount(ticket: Int){
        if let userId = AuthServices.currentUserId{
            let settlementAmountChange =  webservice.get_settlement_details(vacationtype: empVacationDetails.Vac_Type, langid: languangeChosen, emp_no: userId, startdate: empVacationDetails.Leave_Start_Dt, ticket: ticket)
            
            empVacationDetails.TotalSettlementAmount = settlementAmountChange.TotalSettlementAmount
            settlementAmount.text =  empVacationDetails.TotalSettlementAmount
        }
    }
    
    @IBAction func exitYesButtonTapped(_ sender: Any) {
        ExitYesButton.backgroundColor = mainBackgroundColor
        exitNoBuuton.backgroundColor = .white
        exitReEntryVisaSelected = 1
    }
    
    @IBAction func exitNoButtonTapped(_ sender: Any) {
        ExitYesButton.backgroundColor = .white
        exitNoBuuton.backgroundColor = mainBackgroundColor
        exitReEntryVisaSelected = 0
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if delegateTextField.text == "Your delegate".localize() {
            let alertMessage = "Choose your delegate".localize()
            let alertTitle = "Alert!".localize()
            
            AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
        } else {
            
        }
        
        if let numOfDays = numOfDays.text, let leaveStartDate = leaveStartDatePickerView.text, let returnDate = ReturnDatePickerView.text, let vacationType = vacationTypeTextField.text, let exitReEntryDays = exitReEntryDays.text{
            
            empVacationDetails.Number_Days = numOfDays
            empVacationDetails.Leave_Start_Dt = leaveStartDate
            empVacationDetails.Leave_Return_Dt = returnDate
            empVacationDetails.Vac_Type = vacationTypeId
            empVacationDetails.Vac_Desc = vacationType
            empVacationDetails.ExitReEntry = exitReEntryDays
        }
        performSegue(withIdentifier: "showTicketDetails", sender: nil)
    }
}

// -- MARK: Picker View

extension VacationsDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func setUpPickerView(){
        PickerviewAction().showPickView(
            txtfield: showEmpPickerView,
            pickerview: pickViewEmpName,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(pickerViewDoneClick))
        
        PickerviewAction().showPickView(
            txtfield: showDelegatePickerView,
            pickerview: pickViewEmpDelegate,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(pickerViewDoneClick))
        
        PickerviewAction().showPickView(txtfield: showVacationTypePickerView, pickerview: vacationTypePickerViewPikcer, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(pickerViewDoneClick))
    }
    
    @objc func cancelClick(){
        if pickerView == pickViewEmpName{
            showEmpPickerView.resignFirstResponder()
            return
        } else if pickerView == pickViewEmpDelegate{
            showDelegatePickerView.resignFirstResponder()
            return
        }
        showVacationTypePickerView.resignFirstResponder()
    }
    
    @objc func pickerViewDoneClick(){
        if pickerView == pickViewEmpName{
            if empNameIndex == 0 {
                empTextField.text = empVacArray[0].Emp_Ename
            }else {
                empTextField.text = empNametextChosen
            }
            showEmpPickerView.resignFirstResponder()
            return
        }
            
        else if pickerView == pickViewEmpDelegate{
            if empDelegateIndex == 0 {
                delegateTextField.text = empDelegateArray[0].Emp_Ename
                delegateId = "\(empDelegateArray[0].Emp_Id)"
            }else {
                delegateTextField.text = empDelegatetextChosen
            }
            showDelegatePickerView.resignFirstResponder()
            
            print(delegateId)
            return
        }
            
        else if pickerView == vacationTypePickerViewPikcer{
            if vacationTypeIndex == 0 {
                vacationTypeTextField.text = vacationTypeArray[0].Vac_Desc
                vacationTypeId = vacationTypeArray[0].Vac_Type
            }else {
                vacationTypeTextField.text = vacationTypetextChosen
            }
            showVacationTypePickerView.resignFirstResponder()
            return
        }
    }
    
    // -- MARK: Picker view data souorce
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == vacationTypePickerViewPikcer{
            return vacationTypeArray.count
        } else if pickerView == pickViewEmpName {
            return empVacArray.count
        }
        return empDelegateArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == vacationTypePickerViewPikcer{
            self.pickerView = pickerView
            return vacationTypeArray[row].Vac_Desc
        } else if pickerView == pickViewEmpName{
            self.pickerView = pickViewEmpName
            return empVacArray[row].Emp_Ename
        }
        self.pickerView = pickViewEmpDelegate
        return empDelegateArray[row].Emp_Ename
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == vacationTypePickerViewPikcer{
            vacationTypetextChosen = vacationTypeArray[row].Vac_Desc
            vacationTypeId = vacationTypeArray[row].Vac_Type
            vacationTypeIndex = row
        } else if pickerView == pickViewEmpName {
            empNametextChosen = empVacArray[row].Emp_Ename
            empNameIndex = row
        } else {
            empDelegatetextChosen =  empDelegateArray[row].Emp_Ename
            delegateId = "\(empDelegateArray[row].Emp_Id)"
            empDelegateIndex = row
            
            print(delegateId)
        }
    }
}

// -- MARK: Table View

extension VacationsDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketdependentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_Id, for: indexPath) as? VisaRequiresCell{
            self.sutupVisaRequireCell(cell: cell, requireVisaSelected: ticketdependentArray[indexPath.row].RequireVisa)
            
            let ticket = ticketdependentArray[indexPath.row].Ticket
            let dependentName = ticketdependentArray[indexPath.row].DependentName
            
            cell.ticketNumberRight.text = ticket
            cell.dependentNameRight.text = dependentName
            cell.visaNoButton.addTarget(self, action: #selector(visaNoButtonTapped(sender:)), for: .touchUpInside)
            cell.visaNoButton.tag = indexPath.row
            
            cell.visaYesButton.addTarget(self, action: #selector(visaYesButtonTapped(sender:)), for: .touchUpInside)
            cell.visaYesButton.tag = indexPath.row
            
            return cell
        }
        return UITableViewCell()
    }
    
    func sutupVisaRequireCell(cell: VisaRequiresCell, requireVisaSelected: Int){
        cell.selectorVisaYes.layer.cornerRadius = cornerRadiusValueHolder
        cell.selectorVisaNo.layer.cornerRadius = cornerRadiusValueHolder
        
        cell.innerSelectorVisaYes.layer.cornerRadius = cornerRadiusValueInner
        cell.innerSelectorVisaNo.layer.cornerRadius = cornerRadiusValueInner
        
        cell.visaYesButton.layer.cornerRadius = cornerRadiusValueView
        cell.visaNoButton.layer.cornerRadius = cornerRadiusValueView
        
        if requireVisaSelected == 0 {
            cell.visaYesButton.backgroundColor = .white
            cell.visaNoButton.backgroundColor = mainBackgroundColor
        } else {
            cell.visaYesButton.backgroundColor = mainBackgroundColor
            cell.visaNoButton.backgroundColor = .white
        }
        
        cell.holderView.layer.cornerRadius = 5.0
        cell.holderView.layer.borderColor = mainBackgroundColor.cgColor
        cell.holderView.layer.borderWidth = 1
    }
    
    @objc func visaNoButtonTapped(sender: UIButton){
        visaButtonTapped(row: sender.tag, visaSelected: 0)
    }
    
    @objc func visaYesButtonTapped(sender: UIButton){
        visaButtonTapped(row: sender.tag, visaSelected: 1)
    }
    
    func visaButtonTapped(row: Int, visaSelected: Int){
        requiredVisaSelected = visaSelected
        ticketdependentArray[row].RequireVisa = requiredVisaSelected
    }
    
}

// -- MARK: Date Picker

extension VacationsDetailsViewController{
    
    func setupDatePicker(){
        let leaveTitle = "Leave Start Date".localize()
        let returnTitle = "Return Date".localize()
        
        PickerviewAction().showDatePicker(txtfield: leaveStartDatePickerView, datePicker: leaveDatePickerDatePicker, title: leaveTitle, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
        PickerviewAction().showDatePicker(txtfield: ReturnDatePickerView, datePicker: returnDatePickerDatePicker, title: returnTitle, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    @objc func datePickerDoneClick(){
        leaveStartDatePickerView.resignFirstResponder()
        ReturnDatePickerView.resignFirstResponder()
    }
    
    @objc func handleDatePicker(sender: UIDatePicker){
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let currentDate = Date()
        let startDate = getStartDate()
        var dateComponents = DateComponents()
        let leaveMinDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        dateComponents.day = 1
        let returnMinDate = calendar.date(byAdding: dateComponents, to: startDate)
        
        self.leaveDatePickerDatePicker.minimumDate = leaveMinDate
        self.returnDatePickerDatePicker.minimumDate = returnMinDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if sender == leaveDatePickerDatePicker {
            leaveStartDatePickerView.text = dateFormatter.string(from: sender.date)
            if let startReturnDate = calendar.date(byAdding: dateComponents, to: sender.date){
                ReturnDatePickerView.text = dateFormatter.string(from: startReturnDate)
                self.returnDatePickerDatePicker.minimumDate = startReturnDate
                getDifferance(fromDate: sender.date, toDate: startReturnDate)
                
                changeSettlementAmount(startDate: dateFormatter.string(from: sender.date))
            }
        } else {
            ReturnDatePickerView.text = dateFormatter.string(from: sender.date)
            getDifferance(fromDate: leaveMinDate, toDate: sender.date)
        }
    }
    
    // -- MARK: objc function
    
    func changeSettlementAmount(startDate: String){
        if let userId = AuthServices.currentUserId{
            let settlementAmountChange =  webservice.get_settlement_details(vacationtype: vacationTypeId, langid: languangeChosen, emp_no: userId, startdate: startDate, ticket: ticketRequestRecieved)
            
            empVacationDetails.TotalSettlementAmount = settlementAmountChange.TotalSettlementAmount
            settlementAmount.text =  empVacationDetails.TotalSettlementAmount
        }
    }
    
    func getDifferance(fromDate: Date?, toDate: Date?){
        guard let balanceDaysString = balanceVacation.text else { return }
        
        if let fromDate = fromDate, let toDate = toDate, let differenceInDay = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day{
            numOfDays.text = "\(differenceInDay)"
            
            if let balanceVacInt = Int(balanceDaysString){
                if differenceInDay > balanceVacInt{
                    let extraDayAdded = differenceInDay - balanceVacInt
                    extraDays.text = "\(extraDayAdded)"
                    empVacationDetails.ExtraDays = "\(extraDayAdded)"
                } else {
                    extraDays.text = "       "
                }
                exitReEntryDays.text = "\(15 + differenceInDay)"
            }
        }
    }
    
    func getStartDate() -> Date{
        if let date = leaveStartDatePickerView.text {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let formattedDate = dateFormatter.date(from: date){
                return formattedDate
            }
        }
        return Date()
    }
}

extension VacationsDetailsViewController: UITextFieldDelegate, UITextViewDelegate{
    func setUpToolBar(){
        let doneButton = UIBarButtonItem(title: "Done".localize(), style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        numOfDays.inputAccessoryView = toolBar
        exitReEntryDays.inputAccessoryView = toolBar
    }
    
    @objc func doneClick(){
        if textfield == numOfDays{
            numOfDays.resignFirstResponder()
        } else {
            exitReEntryDays.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
    }
}

extension VacationsDetailsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
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















