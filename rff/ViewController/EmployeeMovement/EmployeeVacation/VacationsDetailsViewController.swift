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
    @IBOutlet weak var activityIndicatorContainer: UIView!
    
    // -- MARK: Constrains
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    let vacationTypePickerViewPikcer: UIPickerView = UIPickerView()
    
    var datePickerView: UIDatePicker = UIDatePicker()
    var pickerView: UIPickerView = UIPickerView()
    var textfield = UITextField()
    //static var i: Int = 0
    
    // -- MARK: Variables
    
    let cell_Id = "cell_visaRequires"
    let mainBackgroundColor = AppDelegate.shared.mainBackgroundColor
    let screenSize = AppDelegate.shared.screenSize
    let webserviceForVacationDetails = VacationService.instance
    
    var empVacationDetails = EmpVacationDetailsModul()
    var vacationTypeArray = [VacTypeInfoModul]()
    
    var empInfoArray = [EmpInfoModul]()
    var empDelegateInfoArray = [EmpInfoModul]()
    var ticketdependentArray = [EmpDepVacTicketInfoModul]()
    var settlementDetails = settlmentDetailsModul()
    
    // To store vacation type id
    var selectedEmpId: String = ""
    var vacationTypeId: String = ""
    var leaveStartDate: String = ""
    var leaveReturnDate: String = ""
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
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        startDateChosen = getStartDate()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        setupArrays()
        stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // -- MARK: Set ups
    
    func setUpView(){
        stackViewWidth.constant = screenSize.width - 32
        setCustomDefaultNav(navItem: navigationItem)
        leaveStartDatePickerView.tintColor = .clear
        ReturnDatePickerView.tintColor = .clear
        showVacationTypePickerView.tintColor = .clear
        showEmpPickerView.tintColor = .clear
        
        comment.text = ""
        comment.delegate = self
        numOfDays.delegate = self
        exitReEntryDays.delegate = self
        
        setUpPickerView()
        setupDatePicker()
        setUpToolBar()
        setUpCommentDisplay()
        sutupSelectors()
    }
    
    func setUpCommentDisplay(){
        comment.layer.cornerRadius = 5.0
        comment.layer.borderColor = mainBackgroundColor.cgColor
        comment.layer.borderWidth = 1
    }
    
    func sutupSelectors(){
        selectorByCompany.layer.cornerRadius = cornerRadiusValueHolder
        selectorCash.layer.cornerRadius = cornerRadiusValueHolder
        selectorExitYes.layer.cornerRadius = cornerRadiusValueHolder
        selectorExitNo.layer.cornerRadius = cornerRadiusValueHolder
        
        innerSelectorByCompany.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorCash.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorExitYes.layer.cornerRadius = cornerRadiusValueInner
        innerSelectorExitNo.layer.cornerRadius = cornerRadiusValueInner
        
        byCompanyButton.layer.cornerRadius = cornerRadiusValueView
        cashButton.layer.cornerRadius = cornerRadiusValueView
        ExitYesButton.layer.cornerRadius = cornerRadiusValueView
        exitNoBuuton.layer.cornerRadius = cornerRadiusValueView
        
        setupDefaultSelector()
    }
    
    func setupDefaultSelector(){
        byCompanyButton.backgroundColor = .white
        cashButton.backgroundColor = mainBackgroundColor
        ExitYesButton.backgroundColor = .white
        exitNoBuuton.backgroundColor = mainBackgroundColor
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func setupArrays(){
        empInfoArray = webserviceForVacationDetails.BindEmpsVacationsDropDown(langid: languangeChosen,
                                                                              Emp_no: AuthServices.currentUserId)
        vacationTypeArray = webserviceForVacationDetails.BindVacationType_DDL(langid: languangeChosen)
        
        if !empInfoArray.isEmpty && !vacationTypeArray.isEmpty{
            setUpDataFromSelectedEmp(selectedEmpId: "\(empInfoArray[empNameIndex].Emp_Id)")
        } else { print("No data available") }
        
        initialValues()
    }
    
    func setUpDataFromSelectedEmp(selectedEmpId: String){
        vacationTypeId = vacationTypeArray[2].Vac_Type
        empDelegateInfoArray = webserviceForVacationDetails.BindDelegateVacationsDropDown(langid: languangeChosen,
                                                                                          Emp_no: selectedEmpId)
        empVacationDetails = webserviceForVacationDetails.GetEmpVacationDetails(langid: languangeChosen,
                                                                                Emp_no: selectedEmpId)
        ticketdependentArray = webserviceForVacationDetails.GetEmpVacationTickets(emp_id: selectedEmpId,
                                                                                  langId: languangeChosen)
        settlementDetails = webserviceForVacationDetails.get_settlement_details(vacationtype: vacationTypeId,
                                                                                langid: languangeChosen,
                                                                                emp_no: selectedEmpId,
                                                                                startdate: empVacationDetails.Leave_Start_Dt,
                                                                                ticket: 0)
        tableViewWidth.constant = CGFloat(120 * (ticketdependentArray.count))
        visaReuireTableView.reloadData()
    }
    
    func setUpEmployeeDetails(){
        setValuesForEmployeeDetails(textField: numOfDays, text: empVacationDetails.Number_Days)
        setValuesForEmployeeDetails(label: balanceVacation, text:
            empVacationDetails.Balance_Vacation)
        setValuesForEmployeeDetails(textField: leaveStartDatePickerView, text: empVacationDetails.Leave_Start_Dt)
        setValuesForEmployeeDetails(textField: ReturnDatePickerView, text: empVacationDetails.Leave_Return_Dt)
        setValuesForEmployeeDetails(textField: exitReEntryDays, text: empVacationDetails.ExitReEntry)
        setValuesForEmployeeDetails(label: settlementAmount, text: settlementDetails.TotalSettlementAmount)
        setValuesForEmployeeDetails(label: extraDays, text: empVacationDetails.ExtraDays)
        setValuesForEmployeeDetails(textField: dependentTicket, text: empVacationDetails.Dependent_Ticket)
    }
    
    func setValuesForEmployeeDetails(textField: UITextField, text: String){
        textField.text = text.isEmpty ? "    " : text
    }
    
    func setValuesForEmployeeDetails(label: UILabel, text: String){
        label.text = text.isEmpty ? "    " : text
    }
    
    func initialValues(){
        if empInfoArray.isEmpty{
            self.empTextField.text = "No Employee name available"
        } else {
            self.empTextField.text = empInfoArray[empNameIndex].Emp_Ename
            selectedEmpId = "\(empInfoArray[empNameIndex].Emp_Id)"
            pickViewEmpName.selectRow(0, inComponent: 0, animated: false)
        }
        
        if vacationTypeArray.isEmpty{
            self.vacationTypeTextField.text = "No Vacation Type available"
            vacationTypeId = ""
        } else {
            self.vacationTypeTextField.text = vacationTypeArray[2].Vac_Desc
            vacationTypeId = vacationTypeArray[2].Vac_Type
            vacationTypePickerViewPikcer.selectRow(2, inComponent: 0, animated: false)
        }
        
        leaveStartDate = empVacationDetails.Leave_Start_Dt
        leaveReturnDate = empVacationDetails.Leave_Return_Dt
        setUpEmployeeDetails()
        setInitDate()
    }
    
    func setInitDate(){
        let currentDate = Date()
        var dateComponents = DateComponents()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let balanceVacInt = Int(empVacationDetails.Balance_Vacation){
            dateComponents.day = balanceVacInt
            if let date = Calendar(identifier: Calendar.Identifier.gregorian).date(byAdding: dateComponents, to: currentDate){
                returnDatePickerDatePicker.setDate(date, animated: false)
            }
        }
    }
    
    // -- MARK: Helper functions
    
    func start(){startLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)}
    func stop(){stopLoader(superView: activityIndicatorContainer, activityIndicator: activityIndicator)}
    
    func changeSettlementAmount(){
        settlementDetails = webserviceForVacationDetails.get_settlement_details(
            vacationtype: vacationTypeId,
            langid: languangeChosen,
            emp_no: selectedEmpId,
            startdate: leaveStartDate,
            ticket: ticketRequest)
        settlementAmount.text =  settlementDetails.TotalSettlementAmount
    }
    
    func handleSuccessAction(action: @escaping () -> Void){
        self.start()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            action()
            self.stop()
        })
    }
    
    func setUpValueToDefault(empNameIndex: Int){
        delegateTextField.text = "Your delegate"
        comment.text = ""
        delegateId = ""
        ticketRequest = 0
        requiredVisaSelected = 0
        exitReEntryVisaSelected = 0
        
        self.empNameIndex = empNameIndex
        setupArrays()
        initialValues()
        setupDefaultSelector()
        scrollView.scrollTo(direction: .Top, animated: false)
    }
    
    func submit(numOfDays: String, leaveStartDate: String, returnDate: String, vacationType: String, exitReEntryDays: String){
        let editSettlementAmountString = (settlementDetails.TotalSettlementAmount).replacingOccurrences(of: ",", with: "")
        let settlementAmountDouble = (editSettlementAmountString as NSString).doubleValue
        
        let pid = webserviceForVacationDetails.SubmitEmpVacation(
            emp_no: selectedEmpId,
            delegateid: delegateId,
            vacationtype: vacationTypeId,
            tickekreq: ticketRequest,
            settlementamt: settlementAmountDouble,
            leavestartdate: leaveStartDate,
            leavertndate: returnDate,
            numberofdays: numOfDays,
            dependenttck: empVacationDetails.Dependent_Ticket,
            exitreentry: exitReEntryVisaSelected,
            comment: comment.text,
            error: "")

        print(empVacationDetails)

        if pid.Error == ""{
            let alertTitle = "Alert".localize()
            let messageTitle = "You have already applied for vacation".localize()
            AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: messageTitle, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)

        } else if pid.Error == "1"{
            for ticketdep in ticketdependentArray{
                _ = webserviceForVacationDetails.UpdateVisaReq(
                    emp_id: selectedEmpId,
                    dep_name: ticketdep.DependentName,
                    value: requiredVisaSelected,
                    error: "")
            }

            if vacationTypeId == "10" {
                _ = webserviceForVacationDetails.save_settlement(
                    emp_id: selectedEmpId,
                    pid: pid.PID,
                    sbasic: settlementDetails.SBasic,
                    sallowances: settlementDetails.SAllowances,
                    stotal: settlementDetails.STotal,
                    snet: settlementDetails.SNet,
                    vbasic: settlementDetails.VBasic,
                    vallowances: settlementDetails.VAllowances,
                    vtotal: settlementDetails.VTotal,
                    vnet: settlementDetails.VNet,
                    ticketprice: settlementDetails.TicketPrice,
                    ticketamount: settlementDetails.TicketAmount,
                    ticketpercent: settlementDetails.TicketPercent,
                    diffticketamount: settlementDetails.DiffTicketAmount,
                    netticketp: settlementDetails.NetTicketPrice,
                    error: "")
            }

            let alertMessage = "Vacation request sent successfully".localize()
            AlertMessage().showAlertMessage(alertTitle: "Success", alertMessage: alertMessage, actionTitle: "OK", onAction: {
                self.handleSuccessAction {
                    self.setUpValueToDefault(empNameIndex: 0)
                }
            }, cancelAction: nil, self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmpDelegateList" {
            if let vc = segue.destination as? searchEmpDeledateVacTableViewController{
                vc.emps = empDelegateInfoArray
                vc.delegate = self
            }
        }
    }
    
    // -- MARK: IBAction
    
    @IBAction func showDelegateButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showEmpDelegateList", sender: nil)
    }
    
    
    var ticketRequest: Int = 0
    @IBAction func byCompanyButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = mainBackgroundColor
        cashButton.backgroundColor = .white
        ticketRequest = 1
        
        changeSettlementAmount()
    }
    
    @IBAction func cashButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = .white
        cashButton.backgroundColor = mainBackgroundColor
        ticketRequest = 0
        
        changeSettlementAmount()
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
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to send vacation request?",
            actionTitle: "Yes",
            onAction: {
                
                if self.delegateTextField.text == "Your delegate".localize() {
                    let alertMessage = "Choose your delegate".localize()
                    let alertTitle = "Alert!".localize()
                    
                    AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
                } else {
                    if let numOfDays = self.numOfDays.text,
                        let leaveStartDate = self.leaveStartDatePickerView.text,
                        let returnDate = self.ReturnDatePickerView.text,
                        let vacationType = self.vacationTypeTextField.text,
                        let exitReEntryDays = self.exitReEntryDays.text{
                        
                        self.handleSuccessAction {
                            self.submit(numOfDays: numOfDays,
                                        leaveStartDate: leaveStartDate,
                                        returnDate: returnDate,
                                        vacationType: vacationType,
                                        exitReEntryDays: exitReEntryDays)
                        }
                    }
                }
                
        }, cancelAction: "Cancel", self)
    }
}

// -- MARK: Update Emp Delegate value

extension VacationsDetailsViewController: UpdateEmpTextDelegate{
    func updateEmp(newName: String, newId: String) {
        delegateTextField.text = newName == "" ? "Your delegate" : newName
        delegateId = newId == "0" ? "" : "\(newId)"
        
        print("Vacation view -> Emp name = \(newName)\nEmp id = \(newId)")
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
        
        PickerviewAction().showPickView(txtfield: showVacationTypePickerView, pickerview: vacationTypePickerViewPikcer, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(pickerViewDoneClick))
    }
    
    @objc func cancelClick(){
        if pickerView == pickViewEmpName{
            showEmpPickerView.resignFirstResponder()
            return
        }
        showVacationTypePickerView.resignFirstResponder()
    }
    
    @objc func pickerViewDoneClick(){
        if pickerView == pickViewEmpName{
            empTextField.text = empInfoArray[self.empNameIndex].Emp_Ename
            handleSuccessAction {
                self.setUpDataFromSelectedEmp(selectedEmpId: "\(self.empInfoArray[self.empNameIndex].Emp_Id)")
                self.setUpValueToDefault(empNameIndex: self.empNameIndex)
            }
            showEmpPickerView.resignFirstResponder()
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
            return empInfoArray.count
        }
        return empDelegateInfoArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == vacationTypePickerViewPikcer{
            self.pickerView = pickerView
            return vacationTypeArray[row].Vac_Desc
        }
        self.pickerView = pickViewEmpName
        return empInfoArray[row].Emp_Ename
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == vacationTypePickerViewPikcer{
            vacationTypetextChosen = vacationTypeArray[row].Vac_Desc
            vacationTypeId = vacationTypeArray[row].Vac_Type
            vacationTypeIndex = row
        } else if pickerView == pickViewEmpName {
            empNametextChosen = empInfoArray[row].Emp_Ename
            empNameIndex = row
        } else {
            empDelegatetextChosen =  empDelegateInfoArray[row].Emp_Ename
            delegateId = "\(empDelegateInfoArray[row].Emp_Id)"
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
            
            cell.ticketNumber.text = ticket
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
        
        if sender == leaveDatePickerDatePicker {
            leaveStartDate = sender.date.dateToString()
            leaveStartDatePickerView.text = leaveStartDate
            updateVacDetails(leaveDate: leaveStartDate)
            changeSettlementAmount()
            
            if let startReturnDate = calendar.date(byAdding: dateComponents, to: sender.date){
                ReturnDatePickerView.text = startReturnDate.dateToString()
                self.returnDatePickerDatePicker.minimumDate = startReturnDate
                self.returnDatePickerDatePicker.setDate(startReturnDate, animated: false)
                getDifferance(fromDate: sender.date, toDate: startReturnDate)
            }
        } else {
            ReturnDatePickerView.text = sender.date.dateToString()
            getDifferance(fromDate: getStartDate(), toDate: sender.date)
        }
    }
    
    // -- MARK: objc function
    
    func getDifferance(fromDate: Date?, toDate: Date?){
        guard let balanceDaysString = balanceVacation.text else { return }
        
        if let fromDate = fromDate,
            let toDate = toDate,
            let differenceInDay = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day{
            
            numOfDays.text = "\(differenceInDay)"
            
            if let balanceVacInt = Int(balanceDaysString){
                updateExtraDaysAndReEntry(numOfDays: differenceInDay, balanceDays: balanceVacInt)
            }
        }
    }
    
    func updateVacDetails(leaveDate: String){
        if let empolyeeId = Int(selectedEmpId){
            let updateVacationValues = webserviceForVacationDetails.calculateActualVacatioDays(
                employee_id: empolyeeId,
                startdate: empVacationDetails.StartDate,
                leavedate: leaveDate)
            
            empVacationDetails.Balance_Vacation = updateVacationValues.Balance_Vacation
            empVacationDetails.ExitReEntry = updateVacationValues.ExitReEntry
            
            balanceVacation.text = empVacationDetails.Balance_Vacation
            exitReEntryDays.text = empVacationDetails.ExitReEntry
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
    
    func updateExtraDaysAndReEntry(numOfDays: Int, balanceDays: Int){
        if numOfDays > balanceDays{
            let extraDayAdded = numOfDays - balanceDays
            extraDays.text = "\(extraDayAdded)"
            empVacationDetails.ExtraDays = "\(extraDayAdded)"
        } else {
            extraDays.text = "       "
        }
        exitReEntryDays.text = "\(15 + numOfDays)"
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
            
            if let numOfDayText = numOfDays.text,
                let numOfDayInt = Int(numOfDayText),
                let balanceText = balanceVacation.text,
                let balanceInt = Int(balanceText){
                
                updateExtraDaysAndReEntry(numOfDays: numOfDayInt, balanceDays: balanceInt)
                
                let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
                let startDate = getStartDate()
                var dateComponents = DateComponents()
                
                dateComponents.day = numOfDayInt
                if let newReturnDate = calendar.date(byAdding: dateComponents, to: startDate){
                    ReturnDatePickerView.text = newReturnDate.dateToString()
                    returnDatePickerDatePicker.setDate(newReturnDate, animated: false)
                }
            }
            
            numOfDays.resignFirstResponder()
        } else {
            exitReEntryDays.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        }
        return true
    }
}

extension VacationsDetailsViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 68, right: 0)
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















