//
//  ResignViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ResignViewController: UIViewController {

    // MARK: IBOutles
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var resignButton: UIButton!
    @IBOutlet weak var endOfServiceButton: UIButton!
    @IBOutlet weak var empTextField: UITextField!
    @IBOutlet weak var showEmpsTextField: UITextField!
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var showReasonsTextField: UITextField!
    @IBOutlet weak var tableViewOfTitles: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var reasonStackView: UIStackView!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    
    // MARK: Variables
    
    let webservice = ResignService.instance
    let screenSize = AppDelegate.shared.screenSize
    let cellId = "cell_titles"
    let titles = ["Employee Information".localize(),
                  "Increment/Decrement Details".localize(),
                  "Evaluation Details".localize()]
    let lang = LoginViewController.languageChosen
    let currentUser = AuthServices.currentUserId
    
    var empsArray = [Emp_InfoModul]()
    var empsPickerView = UIPickerView()
    var empIndex = 0
    var oldEmpIndex = 0
    var empId_SelectedValue = ""
    var reasonsArray = [ReasonModul]()
    var reasonsPickerView = UIPickerView()
    var reasonIndex = 0
    var reasonId = ""
    var empDetailsArray = [ResignEmpDetailsModul]()
    var IncDecrDetailsArray = [Inc_DecrDetailsModul]()
    var evaDetailsArray = [EvaDetailsModul]()
    
    var pickerview = UIPickerView()
    var resignValue = 0 // 1 --> resign , 2 --> end of service
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = setLocalizedNavTitle(arabocTxt: "استقاله", englishTxt: "Resign")
        
        setUpView()
        setUpPickerView()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        start()
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        setUpData()
        stop()
    }
    
    // MARK: SetUps
    
    func setUpView(){
        showEmpsTextField.tintColor = .clear
        showReasonsTextField.tintColor = .clear
        commentTextView.delegate = self
        stackViewWidth.constant = screenSize.width - 32
    }
    
    func setUpData(){
        empsArray = webservice.Bind_dllEmp(lang: lang, emp_id: currentUser, formid: 1003)
        
        initialAction()
        setInfo()
    }
    
    func setInfo(){
        reasonsArray = webservice.Bind_ddlReason(lang: lang)
        
        if empsArray.isEmpty {return}
        empDetailsArray = webservice.Get_Emp_Details(lang: lang, emp_id: empId_SelectedValue)
        IncDecrDetailsArray = webservice.Get_Inc_Desc_Details(lang: lang, emp_id: empId_SelectedValue)
        evaDetailsArray = webservice.Get_Eva_Details(lang: lang, emp_id: empId_SelectedValue)
        
        tableViewOfTitles.reloadData()
        handleHeighOfTableView()
        tableViewOfTitles.isHidden = false
    }
    
    func initialAction(){
        if !empsArray.isEmpty{
            empTextField.text = empsArray[empIndex].Emp_Name
            empId_SelectedValue = empsArray[empIndex].Emp_Id
        }
        if !reasonsArray.isEmpty{ reasonTextField.text = "Select Reason".localize() }
        commentTextView.text = ""
        currentEmpToSetButtonEnable()
    }
    
    // -- MARK: Helper functions
    
    func start(){startLoader(superView: aiContainer, activityIndicator: ai)}
    func stop(){stopLoader(superView: aiContainer, activityIndicator: ai)}
    
    func handleButtonEnable(isResignEnabled: Bool, isEOSEnabled: Bool, enabledButton: UIButton, disabledButton: UIButton){
        resignButton.isEnabled = isResignEnabled
        endOfServiceButton.isEnabled = isEOSEnabled
        
        enabledButton.backgroundColor = AppDelegate.shared.mainBackgroundColor
        disabledButton.backgroundColor = .white
        
        reasonStackView.isHidden = isEOSEnabled
        resignValue = isResignEnabled ? 1 : 2
    }
    
    func currentEmpToSetButtonEnable(){
        if empId_SelectedValue == currentUser{
            handleButtonEnable(isResignEnabled: true, isEOSEnabled: false, enabledButton: resignButton, disabledButton: endOfServiceButton)
        } else {
            handleButtonEnable(isResignEnabled: false, isEOSEnabled: true, enabledButton: endOfServiceButton, disabledButton: resignButton)
        }
    }
    
    func updateInfo(){
        currentEmpToSetButtonEnable()
        setInfo()
    }
    
    func handleHeighOfTableView(){
        var emptyArray = [Bool]()
        var emptyArrayCount = 0
        
        emptyArray.append(empDetailsArray.isEmpty)
        emptyArray.append(IncDecrDetailsArray.isEmpty)
        emptyArray.append(evaDetailsArray.isEmpty)
        for isEmpty in emptyArray{
            if isEmpty{
                emptyArrayCount += 1
            }
        }
        
        tableViewHeight.constant = CGFloat(44 * (titles.count - emptyArrayCount))
    }
    
    // MARK: IBAction

    @IBAction func resignButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func endOfServiceButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation".localize(),
            alertMessage: "Do you want to send resign request?".localize(),
            actionTitle: "Yes".localize(),
            onAction: {
                
                self.handleSend()
                
        }, cancelAction: "Cancel".localize(), self)
        
    }
    
    func handleSend(){
        var reason = ""
        
        if let _ = empTextField.text,
            let reasonTxt = reasonTextField.text,
            let commentTxt = commentTextView.text,
            !empDetailsArray.isEmpty{
            
            if !reasonStackView.isHidden && reasonTxt == "Select Reason".localize(){
                AlertMessage().showAlertMessage(
                    alertTitle: "Alert".localize(), alertMessage: "You did not select a reason".localize(),
                    actionTitle: nil, onAction: nil,
                    cancelAction: "OK", self)
            } else {
                reason = reasonStackView.isHidden ? "" : reasonTxt
                
                start()
                DispatchQueue.main.async {
                    self.sendReq(resignValue: "\(self.resignValue)", empId_SelectedValue: self.empId_SelectedValue,
                                 reason: reason, currentUser: self.currentUser, commentTxt: commentTxt)
                    self.stop()
                }
            }
        }
    }
    
    func sendReq(resignValue: String, empId_SelectedValue: String,
                 reason: String, currentUser: String, commentTxt: String){
        var workHrs = ""
        var absentDays = ""
        
        for emp in empDetailsArray{
            workHrs = emp.Work_Hrs
            absentDays = emp.Absent_Days
        }
        
        print("""
            resignType_value: \(resignValue)
            empId_selectedValue: \(empId_SelectedValue)
            reason: \(reason)
            workHrs: \(workHrs)
            absentDays: \(absentDays)
            formId: \(resign_formId)
            login_empId: \(currentUser)
            company: \(1)
            comment: \(commentTxt)
            """)
        
        let submitResult = webservice.Submit_Resign_Request(resignType_value: resignValue,
                                                            empId_selectedValue: empId_SelectedValue,
                                                            reason: reason, workHrs: workHrs,
                                                            absentDays: absentDays, formId: "\(resign_formId)",
                                                            login_empId: currentUser,
                                                            company: "1", comment: commentTxt)
        
        if submitResult != "" {
            AlertMessage().showAlertMessage(alertTitle: "Alert".localize(), alertMessage: submitResult,
                                            actionTitle: nil, onAction: nil,
                                            cancelAction: "OK", self)
        } else {
            AlertMessage().showAlertMessage(alertTitle: "Success".localize(), alertMessage: "Resign request for emp. no. ".localize() + empId_SelectedValue + " saved successfully..!!".localize(),
                                            actionTitle: "OK", onAction: {
                                                self.start()
                                                DispatchQueue.main.async {
                                                    self.tableViewOfTitles.isHidden = true
                                                    self.empIndex = 0
                                                    self.reasonIndex = 0
                                                    self.setInfo()
                                                    self.initialAction()
                                                    self.stop()
                                                }
            }, cancelAction: nil, self)
        }
        
    }
}

// -- MARK: Table view

extension ResignViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? resignTitlesCell{
            cell.textLabel?.text = titles[indexPath.row]
            cell.textLabel?.textAlignment = LanguageManger.isArabicLanguage ? .right : .left
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = getId(row: indexPath.row)
        performSegue(withIdentifier: id, sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEmpInfo" {
            if let vc = segue.destination as? ResignEmpInfoViewController{
                vc.empDetailsArray = empDetailsArray
            }
        } else if segue.identifier == "showIncAndDec" {
            if let vc = segue.destination as? ResignIncDecTableViewController{
                vc.IncDecrDetailsArray = IncDecrDetailsArray
            }
        } else if segue.identifier == "showEva" {
            if let vc = segue.destination as? ResignEvaTableViewController{
                vc.evaDetailsArray = evaDetailsArray
            }
        }
    }
    
    func getId(row: Int) -> String{
        switch row{
        case 0: return "showEmpInfo"
        case 1: return "showIncAndDec"
        case 2: return "showEva"
        default: return "" }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0: if empDetailsArray.isEmpty { return 0 }
        case 1: if IncDecrDetailsArray.isEmpty { return 0 }
        case 2: if evaDetailsArray.isEmpty { return 0 }
        default: return 44 }
        
        return 44
    }
}

// -- MARK: Picker view

extension ResignViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showEmpsTextField,
                                        pickerview: empsPickerView,
                                        viewController: self,
                                        cancelSelector: #selector(cancelButtonTapped(sender:)),
                                        doneSelector: #selector(doneButtonTapped(sender:)))
        
        PickerviewAction().showPickView(txtfield: showReasonsTextField,
                                        pickerview: reasonsPickerView,
                                        viewController: self,
                                        cancelSelector: #selector(cancelButtonTapped(sender:)),
                                        doneSelector: #selector(doneButtonTapped(sender:)))
    }
    
    // -- MARK: Objc functions
    
    @objc func doneButtonTapped(sender: UIBarButtonItem){
        if pickerview == empsPickerView{
            empTextField.text = empsArray[empIndex].Emp_Name
            empId_SelectedValue = empsArray[empIndex].Emp_Id
            
            if empIndex != oldEmpIndex{
                start()
                DispatchQueue.main.async {
                    self.updateInfo()
                    self.stop()
                }
            }
            
            oldEmpIndex = empIndex
            showEmpsTextField.resignFirstResponder()
        } else if pickerview == reasonsPickerView{
            reasonTextField.text = reasonIndex == 0 ? "Select Reason".localize() :  reasonsArray[reasonIndex].Reason
            reasonId = reasonsArray[reasonIndex].ID
            showReasonsTextField.resignFirstResponder()
        }
    }
    
    @objc func cancelButtonTapped(sender: UIBarButtonItem){
        if pickerview == empsPickerView{
            empIndex = oldEmpIndex
            showEmpsTextField.resignFirstResponder()
        }
        else if pickerview == reasonsPickerView{ showReasonsTextField.resignFirstResponder() }
    }
    
    // -- MARK: Picker view data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == empsPickerView{
            return empsArray.count
        }
        return reasonsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerview = pickerView
        if pickerView == empsPickerView{
            return empsArray[row].Emp_Name
        }
        return row == 0 ? "Select Reason".localize() : reasonsArray[row].Reason
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == empsPickerView{ empIndex = row }
        else if pickerView == reasonsPickerView{ reasonIndex = row }
    }
}

// -- MARK: Text View Delegate

extension ResignViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

// -- MARK: KeyBoard appeance

extension ResignViewController{
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

class resignTitlesCell: UITableViewCell{
    
}



