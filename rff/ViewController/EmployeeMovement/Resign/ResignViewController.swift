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
    
    // MARK: Variables
    
    let webserviceForVac = VacationService.instance
    let screenSize = AppDelegate.shared.screenSize
    let cellId = "cell_titles"
    let titles = ["Employee Information", "Increment/Decrement Details", "Evaluation Details"]
    
    var empsArray = [EmpInfoModul]()
    var empsPickerView = UIPickerView()
    var empIndex = 0
    var reasonsArray = ["reason 1", "reason 2", "reason 3", "reason 4"]
    var reasonsPickerView = UIPickerView()
    var reasonIndex = 0
    var pickerview = UIPickerView()
    var empId_SelectedValue = 0
    var resignValue = 0 // 1 --> resign , 2 --> end of service
    
    // MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setUpPickerView()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpData()
    }
    
    // MARK: SetUps
    
    func setUpView(){
        showEmpsTextField.tintColor = .clear
        showReasonsTextField.tintColor = .clear
        commentTextView.delegate = self
        commentTextView.text = ""
        stackViewWidth.constant = screenSize.width - 32
    }
    
    func setUpData(){
        empsArray = webserviceForVac.BindEmpsVacationsDropDown(langid: LoginViewController.languageChosen, Emp_no: AuthServices.currentUserId)
        
        initialAction()
    }
    
    func initialAction(){
        if !empsArray.isEmpty{
            empTextField.text = empsArray[empIndex].Emp_Ename
            empId_SelectedValue = empsArray[empIndex].Emp_Id
        }
        currentEmpToSetButtonEnable()
    }
    
    // -- MARK: Helper functions
    
    func handleButtonEnable(isResignEnabled: Bool, isEOSEnabled: Bool, enabledButton: UIButton, disabledButton: UIButton){
        resignButton.isEnabled = isResignEnabled
        endOfServiceButton.isEnabled = isEOSEnabled
        
        enabledButton.backgroundColor = AppDelegate.shared.mainBackgroundColor
        disabledButton.backgroundColor = .white
        
        reasonStackView.isHidden = !isEOSEnabled
    }
    
    func currentEmpToSetButtonEnable(){
        if "\(empId_SelectedValue)" == AuthServices.currentUserId{
            handleButtonEnable(isResignEnabled: true, isEOSEnabled: false, enabledButton: resignButton, disabledButton: endOfServiceButton)
        } else {
            handleButtonEnable(isResignEnabled: false, isEOSEnabled: true, enabledButton: endOfServiceButton, disabledButton: resignButton)
        }
    }
    
    func updateInfo(){
        currentEmpToSetButtonEnable()
    }
    
    // MARK: IBAction

    @IBAction func resignButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func endOfServiceButtonTapped(_ sender: Any) {
        
    }
    
}

extension ResignViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? resignTitlesCell{
            cell.textLabel?.text = titles[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = getId(row: indexPath.row)
        performSegue(withIdentifier: id, sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getId(row: Int) -> String{
        switch row{
        case 0: return "showEmpInfo"
        case 1: return "showIncAndDec"
        case 2: return "showEva"
        default: return "" }
    }
}

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
    
    @objc func doneButtonTapped(sender: UIBarButtonItem){
        if pickerview == empsPickerView{
            empTextField.text = empsArray[empIndex].Emp_Ename
            empId_SelectedValue = empsArray[empIndex].Emp_Id
            
            updateInfo()
            showEmpsTextField.resignFirstResponder()
        } else if pickerview == reasonsPickerView{
            reasonTextField.text = reasonsArray[reasonIndex]
            showReasonsTextField.resignFirstResponder()
        }
    }
    
    @objc func cancelButtonTapped(sender: UIBarButtonItem){
        if pickerview == empsPickerView{ showEmpsTextField.resignFirstResponder() }
        else if pickerview == reasonsPickerView{ showReasonsTextField.resignFirstResponder() }
    }
    
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
            return empsArray[row].Emp_Ename
        }
        return reasonsArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == empsPickerView{ empIndex = row }
        else if pickerView == reasonsPickerView{ reasonIndex = row }
    }
}

extension ResignViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

class resignTitlesCell: UITableViewCell{
    
}

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




