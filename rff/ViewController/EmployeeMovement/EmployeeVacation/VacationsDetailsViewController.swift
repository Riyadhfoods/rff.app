//
//  VacationsDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class VacationsDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, ticketRequestDelegate {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var empPickerView: UITextField!
    @IBOutlet weak var empDropdown: UIImageView!
    @IBOutlet weak var delegatePickerView: UITextField!
    @IBOutlet weak var delegateDropdown: UIImageView!
    @IBOutlet weak var numOfDays: UITextField!
    @IBOutlet weak var balanceVacation: UILabel!
    @IBOutlet weak var leaveStartDatePickerView: UITextField!
    @IBOutlet weak var ReturnDatePickerView: UITextField!
    @IBOutlet weak var vacationTypePickerView: UITextField!
    @IBOutlet weak var vacationTypeDropdown: UIImageView!
    @IBOutlet weak var exitReEntryDays: UITextField!
    @IBOutlet weak var extraDays: UILabel!
    @IBOutlet weak var settlementAmount: UILabel!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var vacationDetailsStackViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var showVacationTypePickerTextField: UITextField!
    
    // -- labels
    @IBOutlet weak var vacationDetailsHeader: UILabel!
    @IBOutlet weak var settlementDetailsHeader: UILabel!
    
    @IBOutlet weak var numberOfDaysTitle: UILabel!
    @IBOutlet weak var balanceVacationTitle: UILabel!
    @IBOutlet weak var leaveStartDateTitle: UILabel!
    @IBOutlet weak var returnDateTitle: UILabel!
    @IBOutlet weak var vacationTypeTitle: UILabel!
    @IBOutlet weak var exitTitle: UILabel!
    @IBOutlet weak var extraDaysTitle: UILabel!
    @IBOutlet weak var settlementTitle: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    //static var i: Int = 0
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let webservice = Login()
    
    var empVacationDetails = EmpVac()
    var vacationTypeArray = [EmpVac]()
    var empVacArray = [EmpVac]()
    var empDelegateArray = [EmpVac]()
    
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
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArrays()
        
        // Change the width of vacation Details Stack View base of the screen size
        vacationDetailsStackViewWidth.constant = screenSize.width - 32
        
        // Changing the back button of the navigation contoller
        setCustomNav(navItem: navigationItem)
        
        leaveStartDatePickerView.tintColor = .clear
        ReturnDatePickerView.tintColor = .clear
        vacationTypePickerView.tintColor = .clear
        empPickerView.tintColor = .clear
        delegatePickerView.tintColor = .clear
        showVacationTypePickerTextField.tintColor = .clear
        
        numOfDays.delegate = self
        exitReEntryDays.delegate = self
        
        setUpPickerView()
        setupDatePicker()
        setupLanguagChange()
        setUpEmployeeDetails()
        setUpToolBar()
        
        startDateChosen = getStartDate()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if newSettlementRecieved != "" {
            setSettlementAmount(settlementAmountRecieved: newSettlementRecieved)
        }
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // -- MARK: Set ups
    
    func setupArrays(){
        if let userId = AuthServices.currentUserId{
            empVacArray = webservice.BindEmpsVacationsDropDown(langid: languangeChosen, Emp_no: userId)
            self.empPickerView.text = empVacArray[0].Emp_Ename
            
            empDelegateArray = webservice.BindDelegateVacationsDropDown(langid: languangeChosen, Emp_no: userId)
            vacationTypeArray = webservice.BindVacationType_DDL(langid: languangeChosen)
            self.vacationTypePickerView.text = vacationTypeArray[2].Vac_Desc
            vacationTypeId = vacationTypeArray[2].Vac_Type
            
            empVacationDetails = webservice.GetEmpVacationDetails(langid: languangeChosen, Emp_no: userId)
        }
    }
    
    func setUpEmployeeDetails(){
        numOfDays.text = empVacationDetails.Number_Days
        balanceVacation.text = empVacationDetails.Balance_Vacation
        leaveStartDatePickerView.text = empVacationDetails.Leave_Start_Dt
        ReturnDatePickerView.text = empVacationDetails.Leave_Return_Dt
        exitReEntryDays.text = empVacationDetails.ExitReEntry
        
        if empVacationDetails.ExtraDays == "" {
            extraDays.text = "       "
        } else {
           extraDays.text = empVacationDetails.ExtraDays
        }
        
        setSettlementAmount(settlementAmountRecieved: empVacationDetails.TotalSettlementAmount)
    }
    
    func setSettlementAmount(settlementAmountRecieved: String){
        if languangeChosen == 1 {
            settlementAmount.text = settlementAmountRecieved
        } else {
            settlementTitle.text = settlementAmountRecieved
        }
    }
    
    func setUpPickerView(){
        PickerviewAction().showPickView(
            txtfield: empPickerView,
            pickerview: pickViewEmpName,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(pickerViewDoneClick))
        
        PickerviewAction().showPickView(
            txtfield: delegatePickerView,
            pickerview: pickViewEmpDelegate,
            viewController: self,
            cancelSelector: #selector(cancelClick),
            doneSelector: #selector(pickerViewDoneClick))
        
        PickerviewAction().showPickView(txtfield: showVacationTypePickerTextField, pickerview: vacationTypePickerViewPikcer, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(pickerViewDoneClick))
    }
    
    func setupDatePicker(){
        let leaveTitle = getString(englishString: "Leave Start Date", arabicString: "تاريخ بداية الإجازة", language: languangeChosen)
        let returnTitle = getString(englishString: "Return Date", arabicString: "تاريخ نهاية الإجازة", language: languangeChosen)
        
        PickerviewAction().showDatePicker(txtfield: leaveStartDatePickerView, datePicker: leaveDatePickerDatePicker, title: leaveTitle, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
        PickerviewAction().showDatePicker(txtfield: ReturnDatePickerView, datePicker: returnDatePickerDatePicker, title: returnTitle, viewController: self, datePickerSelector: #selector(handleDatePicker(sender:)), doneSelector: #selector(datePickerDoneClick))
    }
    
    func setupLanguagChange(){
        setlanguageForTitle(label: vacationDetailsHeader, titleEnglish: "Vacations Details", titleArabic: "تفاصيل الإجازة", language: languangeChosen)
        setlanguageForTitle(label: settlementDetailsHeader, titleEnglish: "Settlement Details", titleArabic: "تفاصيل التصفية", language: languangeChosen)
        setlanguageForTitle(label: numberOfDaysTitle, titleEnglish: "No of Days", titleArabic: "الإجازة المطلوبة", language: languangeChosen)
        setlanguageForTitle(label: balanceVacationTitle, titleEnglish: "Balance Vacation", titleArabic: "الإجازة المستحقة", language: languangeChosen)
        setlanguageForTitle(label: leaveStartDateTitle, titleEnglish: "Leave Start Date", titleArabic: "تاريخ بداية الإجازة", language: languangeChosen)
        setlanguageForTitle(label: returnDateTitle, titleEnglish: "Return Date", titleArabic: "تاريخ نهاية الإجازة", language: languangeChosen)
        setlanguageForTitle(label: vacationTypeTitle, titleEnglish: "Vacation Type", titleArabic: "نوع الاجازة", language: languangeChosen)
        setlanguageForTitle(label: exitTitle, titleEnglish: "Exit Re-Entry Days", titleArabic: "عدد ايام الخروج والعودة", language: languangeChosen)
        setlanguageForTitle(label: extraDaysTitle, titleEnglish: "Extra Days", titleArabic: "ايام اضافية", language: languangeChosen)
        setSettlementLocalization()
        setupSubLabel()
        
        if languangeChosen == 1{
            nextButtonOutlet.setTitle("NEXT", for: .normal)
        } else {
            nextButtonOutlet.setTitle("التالي", for: .normal)
        }
    }
    
    func setupSubLabel(){
        setUpHeaderLabel(txt: numOfDays, language: languangeChosen)
        setUpHeaderLabel(label: balanceVacation, language: languangeChosen)
        setUpHeaderLabel(txt: leaveStartDatePickerView, language: languangeChosen)
        setUpHeaderLabel(txt: ReturnDatePickerView, language: languangeChosen)
        setUpHeaderLabel(txt: vacationTypePickerView, language: languangeChosen)
        setUpHeaderLabel(txt: exitReEntryDays, language: languangeChosen)
        setUpHeaderLabel(label: extraDays, language: languangeChosen)
    }
    
    func setSettlementLocalization(){
        if languangeChosen == 1{
            settlementTitle.text = "Settlement Amount:"
            settlementTitle.textAlignment = .left
            settlementAmount.text = "99999999"
            settlementAmount.textAlignment = .left
        } else {
            settlementAmount.text = "مبلغ التصفية:"
            settlementTitle.textAlignment = .right
            settlementTitle.text = "99999999"
            settlementAmount.textAlignment = .right
        }
        
        changeBoldFont(labelLeft: settlementTitle, labelRight: settlementAmount, langauge: languangeChosen)
    }
    
    var textfield = UITextField()
    func setUpToolBar(){
        let doneButton = UIBarButtonItem(title: getString(englishString: "Done", arabicString: "تم", language: languangeChosen), style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        numOfDays.inputAccessoryView = toolBar
        exitReEntryDays.inputAccessoryView = toolBar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
    }
    
    // -- MARK: objc function
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
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
    
    func getTicketRequest(ticketRequest: Int) {
        self.ticketRequestRecieved = ticketRequest
    }
    
    func changeSettlementBaseOnTicketRequest(newSettlmentAmount: String) {
        newSettlementRecieved = newSettlmentAmount
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
    
    func changeSettlementAmount(startDate: String){
        if let userId = AuthServices.currentUserId{
            let settlementAmountChange =  webservice.get_settlement_details(vacationtype: vacationTypeId, langid: languangeChosen, emp_no: userId, startdate: startDate, ticket: ticketRequestRecieved)
            
            empVacationDetails.TotalSettlementAmount = settlementAmountChange.TotalSettlementAmount
            setSettlementAmount(settlementAmountRecieved: empVacationDetails.TotalSettlementAmount)
        }
    }
    
    @objc func pickerViewDoneClick()
    {
        if pickerView == pickViewEmpName{
            if empNameIndex == 0 {
                 empPickerView.text = empVacArray[0].Emp_Ename
            }else {
                empPickerView.text = empNametextChosen
            }
            empPickerView.resignFirstResponder()
            return
        }
        
        else if pickerView == pickViewEmpDelegate{
            if empDelegateIndex == 0 {
                delegatePickerView.text = empDelegateArray[0].Emp_Ename
                delegateId = "\(empDelegateArray[0].Emp_Id)"
            }else {
                delegatePickerView.text = empDelegatetextChosen
            }
            delegatePickerView.resignFirstResponder()
            
             print(delegateId)
            return
        }
        
        else if pickerView == vacationTypePickerViewPikcer{
            if vacationTypeIndex == 0 {
                vacationTypePickerView.text = vacationTypeArray[0].Vac_Desc
                vacationTypeId = vacationTypeArray[0].Vac_Type
            }else {
                vacationTypePickerView.text = vacationTypetextChosen
            }
            showVacationTypePickerTextField.resignFirstResponder()
            return
        }
    }
    
    @objc func datePickerDoneClick(){
        leaveStartDatePickerView.resignFirstResponder()
        ReturnDatePickerView.resignFirstResponder()
    }
    
    @objc func cancelClick(){
        if pickerView == pickViewEmpName{
            empPickerView.resignFirstResponder()
            return
        } else if pickerView == pickViewEmpDelegate{
            delegatePickerView.resignFirstResponder()
            return
        }
        showVacationTypePickerTextField.resignFirstResponder()
    }
    
    @objc func doneClick(){
        if textfield == numOfDays{
            numOfDays.resignFirstResponder()
        } else {
            exitReEntryDays.resignFirstResponder()
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
    
    // -- MARK: IBAction
    @IBAction func nextButtonTapped(_ sender: Any) {
        if delegatePickerView.text == "Your delegate - الموظف البديل" {
            let alertMessage = getString(englishString: "Choose your delegate", arabicString: "اختر موظف البديل", language: languangeChosen)
            let alertTitle = getString(englishString: "Alert!", arabicString: "تنبيه", language: languangeChosen)
            
            AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: alertMessage, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
        }
        
        if let numOfDays = numOfDays.text, let leaveStartDate = leaveStartDatePickerView.text, let returnDate = ReturnDatePickerView.text, let vacationType = vacationTypePickerView.text, let exitReEntryDays = exitReEntryDays.text{
            empVacationDetails.Number_Days = numOfDays
            empVacationDetails.Leave_Start_Dt = leaveStartDate
            empVacationDetails.Leave_Return_Dt = returnDate
            empVacationDetails.Vac_Type = vacationTypeId
            empVacationDetails.Vac_Desc = vacationType
            empVacationDetails.ExitReEntry = exitReEntryDays
        }
        performSegue(withIdentifier: "showTicketDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTicketDetails"{
            if let vc = segue.destination as? TicketDetailsViewController{
                vc.empVacationDetails = self.empVacationDetails
                vc.delegate = self
                vc.delegateId = self.delegateId
            }
        }
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















