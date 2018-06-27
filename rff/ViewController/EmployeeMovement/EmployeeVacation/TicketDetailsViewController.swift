//
//  TicketDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 12/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import NotificationCenter

protocol ticketRequestDelegate{
    func getTicketRequest(ticketRequest: Int)
    func changeSettlementBaseOnTicketRequest(newSettlmentAmount: String)
}

class TicketDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate {
    // -- MARK: IBOutlets
    
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
    
   // labels
    // Ticket Request
    @IBOutlet weak var ticketDetailsTitle: UILabel!
    @IBOutlet weak var ticketRequestTitle: UILabel!
    @IBOutlet weak var byCommpanyTitle: UILabel!
    @IBOutlet weak var cashTitle: UILabel!
    
    // Exit Re-Entry Visa
    @IBOutlet weak var exitReEntryVisaTitle: UILabel!
    @IBOutlet weak var exitYesTitle: UILabel!
    @IBOutlet weak var exitNoTitle: UILabel!
    
    // Dependent Ticket
    @IBOutlet weak var dependentTicketTitle: UILabel!
    
    // Comment
    @IBOutlet weak var commentTitle: UILabel!
    
    // Submit button
    @IBOutlet weak var submitOutlet: UIButton!
    
    // -- MARK: Constrains
    
    @IBOutlet weak var commentWidth: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var commentBottomAncher: NSLayoutConstraint!
    
    
    // -- MARK: Variables
    
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    let screenSize = AppDelegate().screenSize
    let cornerRadiusValueHolder: CGFloat = 12
    let cornerRadiusValueInner: CGFloat = 11
    let cornerRadiusValueView: CGFloat = 9
    
    let languageChosen = LoginViewController.languageChosen
    var empVacationDetails = EmpVac()
    let cell_Id = "cell_visaRequires"
    var webservice = Login()
    var ticketdependentArray = [DepVacTicket]()
    var isKeyboardPresent = false
    
    var delegate: ticketRequestDelegate?
    var delegateId: String = ""
    var newSettlementAmount: String = ""
    
    // 0 --> no and 1 --> yes
    var requiredVisaSelected: Int = 0
    // 0 --> no and 1 --> yes
    var exitReEntryVisaSelected: Int = 0
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comment.text = ""
        comment.delegate = self
        
        print(empVacationDetails.Dependent_Ticket)
        dependentTicket.text = empVacationDetails.Dependent_Ticket
        if let userId = AuthServices.currentUserId{
            ticketdependentArray = webservice.GetEmpVacationTickets(emp_id: userId, langId: languageChosen)
        }
        
        setViewAlignment()
        setupScreenLayout()
        sutupTicketRequestSelector()
        sutupExitSelector()
        setUpLanguageChosen()
        setUpCommentDisplay()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -- MARK: setUps
    
    func setupScreenLayout(){
        commentWidth.constant = screenSize.width * 0.85
        tableViewWidth.constant = CGFloat(140 * (ticketdependentArray.count))
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
        ExitYesButton.backgroundColor = mainBackgroundColor
        exitNoBuuton.layer.cornerRadius = cornerRadiusValueView
        exitNoBuuton.backgroundColor = .white
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
    
    func setUpLanguageChosen(){
        setlanguageForTitle(label: ticketDetailsTitle, titleEnglish: "Ticket Details", titleArabic: "تفاصيل التذاكر", language: languageChosen)
        setlanguageForTitle(label: ticketRequestTitle, titleEnglish: "Ticket Request", titleArabic: "طلب تذكر", language: languageChosen)
        setlanguageForTitle(label: exitReEntryVisaTitle, titleEnglish: "Exit Re-Entry Visa", titleArabic: "تأشيرة خروج وعودة", language: languageChosen)
        setlanguageForTitle(label: dependentTicketTitle, titleEnglish: "Dependent Ticket", titleArabic: "إعتماد التذكرة", language: languageChosen)
        setlanguageForTitle(label: commentTitle, titleEnglish: "Comment", titleArabic: "ملاحظات", language: languageChosen)
        submitOutlet.setTitle(getString(englishString: "SUBMIT", arabicString: "تسليم", language: languageChosen), for: .normal)
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketdependentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_Id, for: indexPath) as? VisaRequiresCell{
            self.sutupVisaRequireCell(cell: cell, requireVisaSelected: ticketdependentArray[indexPath.row].RequireVisa)
            
            let ticket = ticketdependentArray[indexPath.row].Ticket
            let dependentName = ticketdependentArray[indexPath.row].DependentName
            
            cell.ticketNumberRight.text = getString(englishString: ticket, arabicString: "بدل تذكرة:", language: languageChosen)
            cell.dependentNameRight.text = getString(englishString: dependentName, arabicString: "اسم الموظف:", language: languageChosen)
            
            cell.ticketNumberLeft.text = getString(englishString: "Ticket:", arabicString: ticket, language: languageChosen)
            cell.dependentNameLeft.text = getString(englishString: "Name:", arabicString: dependentName, language: languageChosen)
            
            cell.visaNoButton.addTarget(self, action: #selector(visaNoButtonTapped(sender:)), for: .touchUpInside)
            cell.visaNoButton.tag = indexPath.row
            
            cell.visaYesButton.addTarget(self, action: #selector(visaYesButtonTapped(sender:)), for: .touchUpInside)
            cell.visaYesButton.tag = indexPath.row
            
            changeBoldFont(labelLeft: cell.ticketNumberLeft, labelRight: cell.ticketNumberRight, langauge: languageChosen)
            changeBoldFont(labelLeft: cell.dependentNameLeft, labelRight: cell.dependentNameRight, langauge: languageChosen)
            
            return cell
        }
        return UITableViewCell()
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
    
    
    // -- MARK: IBActions
    var ticketRequest: Int = 0
    @IBAction func byCompanyButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = mainBackgroundColor
        cashButton.backgroundColor = .white
        ticketRequest = 1
        
        delegate?.getTicketRequest(ticketRequest: ticketRequest)
        changeSettlementAmount(ticket: ticketRequest)
        print(empVacationDetails.TotalSettlementAmount)
    }
    
    @IBAction func cashButtonTapped(_ sender: Any) {
        byCompanyButton.backgroundColor = .white
        cashButton.backgroundColor = mainBackgroundColor
        ticketRequest = 0
        
        delegate?.getTicketRequest(ticketRequest: ticketRequest)
        changeSettlementAmount(ticket: ticketRequest)
        print(empVacationDetails.TotalSettlementAmount)
    }
    
    func changeSettlementAmount(ticket: Int){
        if let userId = AuthServices.currentUserId{
            let settlementAmountChange =  webservice.get_settlement_details(vacationtype: empVacationDetails.Vac_Type, langid: languageChosen, emp_no: userId, startdate: empVacationDetails.Leave_Start_Dt, ticket: ticket)
            
            newSettlementAmount = settlementAmountChange.TotalSettlementAmount
            delegate?.changeSettlementBaseOnTicketRequest(newSettlmentAmount: newSettlementAmount)
            empVacationDetails.TotalSettlementAmount = settlementAmountChange.TotalSettlementAmount
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
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        empVacationDetails.DependentVactionTicket = ticketdependentArray
        print(empVacationDetails)
        print("Ticket Request = \(ticketRequest)")
        print("Delegate Id = \(delegateId)")
        
        let editSettlementAmountString = (empVacationDetails.TotalSettlementAmount).replacingOccurrences(of: ",", with: "")
        let settlementAmountDouble = (editSettlementAmountString as NSString).doubleValue
        
        let pid = webservice.SubmitEmpVacation(
            emp_no: "\(empVacationDetails.Emp_Id)",
            delegateid: delegateId,
            vacationtype: empVacationDetails.Vac_Type,
            tickekreq: ticketRequest,
            settlementamt: settlementAmountDouble,
            leavestartdate: empVacationDetails.Leave_Start_Dt,
            leavertndate: empVacationDetails.Leave_Return_Dt,
            numberofdays: empVacationDetails.Number_Days,
            dependenttck: empVacationDetails.Dependent_Ticket,
            exitreentry: exitReEntryVisaSelected,
            comment: comment.text,
            error: "")
        
        empVacationDetails.PID = pid.PID
        empVacationDetails.Error = pid.Error
        
        print(empVacationDetails)
        
        if empVacationDetails.Error == ""{
            let alertTitle = getString(englishString: "Alert", arabicString: "تنبيه", language: languageChosen)
            let messageTitle = getString(englishString: "You have already applied for vacation", arabicString: "لقد تقدمت بطلب عطله مسبقاً", language: languageChosen)
            AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: messageTitle, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
            
        } else if empVacationDetails.Error == "1"{
            for ticketdep in empVacationDetails.DependentVactionTicket{
                _ = webservice.UpdateVisaReq(
                    emp_id: "\(empVacationDetails.Emp_Id)",
                    dep_name: ticketdep.DependentName,
                    value: requiredVisaSelected, error: "")
            }
        }
        
        if empVacationDetails.Vac_Type == "10" {
            _ = webservice.save_settlement(
                emp_id: "\(empVacationDetails.Emp_Id)",
                pid: empVacationDetails.PID,
                sbasic: empVacationDetails.SBasic,
                sallowances: empVacationDetails.SAllowances,
                stotal: empVacationDetails.STotal,
                snet: empVacationDetails.SNet,
                vbasic: empVacationDetails.VBasic,
                vallowances: empVacationDetails.VAllowances,
                vtotal: empVacationDetails.VTotal,
                vnet: empVacationDetails.VNet,
                ticketprice: empVacationDetails.TicketPrice,
                ticketamount: empVacationDetails.TicketAmount,
                ticketpercent: empVacationDetails.TicketPercent,
                diffticketamount: empVacationDetails.DiffTicketAmount,
                netticketp: empVacationDetails.NetTicketPrice,
                error: "")
        }
        
        let alertTitle = getString(englishString: "Vacation applied successfully", arabicString: "تم تسليم طلب الاجازة بنجاح", language: languageChosen)
        AlertMessage().showAlertMessage(alertTitle: alertTitle, alertMessage: "", actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
    }
    
    // -- MARK: Handle Keyboard
   
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        }
        return true
    }
    
}

extension TicketDetailsViewController{
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





















