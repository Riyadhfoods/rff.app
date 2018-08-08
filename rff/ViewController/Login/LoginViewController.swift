//
//  ViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    // -- MARK: IBOutlets
    @IBOutlet weak var logoHolderView: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var companyDropdownImage: UIImageView!
    @IBOutlet weak var languangeTextfield: UITextField!
    @IBOutlet weak var languangeDropdownImage: UIImageView!
    @IBOutlet weak var activityContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityHolderView: UIView!
    
    // MARK: Constrians
    @IBOutlet weak var logoHeight: NSLayoutConstraint!
    @IBOutlet weak var logoWidth: NSLayoutConstraint!
    @IBOutlet weak var logoHolderHeight: NSLayoutConstraint!
    @IBOutlet weak var logoHolderWidth: NSLayoutConstraint!
    @IBOutlet weak var textfieldHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    
    // TextField Action
    @IBOutlet weak var showCompanyPickerTextField: UITextField!
    @IBOutlet weak var showLanguangePickerTextField: UITextField!
    
    let toolBar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.isTranslucent = true
        tb.tintColor = UIColor.black
        tb.sizeToFit()
        tb.isUserInteractionEnabled = true
        
        return tb
    }()
    
    // -- MARK: Variables
    
    let screenHeight = AppDelegate.shared.screenSize.height
    let pickerViewAction = PickerviewAction()
    let pickViewCompay: UIPickerView = UIPickerView()
    let pickViewLanguage: UIPickerView = UIPickerView()
    var pickview: UIPickerView = UIPickerView()
    
    let companyArray = ["RiyadhFoods - شركة الرياض لصناعات التغذية"]
    let languageArray = ["English - إنجليزي" , "Arabic - عربي"]
    let userDefault = UserDefaults.standard
    
    // 1 --> English, 2 --> Arabic
    static var languageChosen: Int = 1
    let screenSize = AppDelegate.shared.screenSize

    // -- MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.stopAnimating()
        
        logoHolderView.layer.cornerRadius = 153.41 / 2
        setUpActivityIndicatorHolder(view: activityHolderView)
        setUpLayout()
        
        // text field delegate
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        showCompanyPickerTextField.tintColor = .clear
        showLanguangePickerTextField.tintColor = .clear
        
        setUpPickerView()
        setUpUserNameToolBar()
        //setupDefaultLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let usernameText = userDefault.object(forKey: "username") as? String,
            let companyText = userDefault.object(forKey: "company") as? String,
            let languageText = userDefault.object(forKey: "language") as? String
        {
            usernameTextfield.text = usernameText
            if !companyText.isEmpty{ companyTextfield.text = companyText }
            if languageText.isEmpty{
                languangeTextfield.text = languageArray[0]
            } else {
                languangeTextfield.text = languageText
            }
        }
        
        passwordTextfield.text = ""
        setupDefaultLanguage()
    }
    
    func setupDefaultLanguage(){
        LoginViewController.languageChosen = 1
        setLanguage()
    }
    
    func isLoggedIn(){
        if AuthServices.currentUserId != "" {
            performSegue(withIdentifier: "showHomePage", sender: nil)
        }
    }
    
    // -- MARK: Pick view functions
    
    func setUpLayout(){
        let logoHolderSEScreen = screenHeight * 0.23
        let logoSEScreen = screenHeight * 0.215
        let textfieldbuttonSESecreen = screenHeight * 0.074
        
        if screenHeight == 568 {
            logoHolderHeight.constant = logoHolderSEScreen
            logoHolderWidth.constant = logoHolderSEScreen
            logoWidth.constant = logoSEScreen
            logoHeight.constant = logoSEScreen
            textfieldHeight.constant = textfieldbuttonSESecreen
            pickerViewHeight.constant = textfieldbuttonSESecreen
            buttonHeight.constant = textfieldbuttonSESecreen
            logoHolderView.layer.cornerRadius = logoHolderSEScreen / 2
        } else {
            logoHolderView.layer.cornerRadius = 153.41 / 2
        }
    }
    
    func setUpPickerView(){
        pickerViewAction.showPickView(txtfield: showCompanyPickerTextField, pickerview: pickViewCompay, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: nil)
        pickerViewAction.showPickView(txtfield: showLanguangePickerTextField, pickerview: pickViewLanguage, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: nil)
    }
    
    @objc func cancelClick(){
        if pickview == pickViewCompay{
            showCompanyPickerTextField.resignFirstResponder()
            return
        }
        showLanguangePickerTextField.resignFirstResponder()
    }
    
    func setUpUserNameToolBar(){
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, nextButton], animated: false)
        usernameTextfield.inputAccessoryView = toolBar
    }
    
    @objc func nextClick(){
        passwordTextfield.becomeFirstResponder()
    }
    
    // -- MARK: IBActions
    
    @IBAction func loginButton(_ sender: Any) {
        guard let usernametext = usernameTextfield.text, let passwordText = passwordTextfield.text else {
            return
        }
        
        if usernametext.isEmpty || passwordText.isEmpty {
            AlertMessage().showAlertMessage(alertTitle: "Alert!", alertMessage: "Username or password is empty", actionTitle: nil, onAction: nil, cancelAction: "Dismiss", self)
        } else {
            if let language = languangeTextfield.text{
                LoginViewController.languageChosen = setLanguageChosen(languagetextfield: language)
                userDefault.set(setLanguageChosen(languagetextfield: language), forKey: "langIndex")
            }
            
            startLoader(superView: activityContainerView, activityIndicator: activityIndicator)
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.01) {
                AuthServices().checkUserId(id: usernametext, password: passwordText, onSeccuss: {
                    self.setLanguage()
                    self.performSegue(withIdentifier: "showHomePage", sender: nil)
                }, onError: { (error) in
                    AlertMessage().showAlertMessage(alertTitle: "Alert!", alertMessage: error, actionTitle: nil, onAction: nil, cancelAction: "Dismiss", self)
                }, viewController: self)
                stopLoader(superView: self.activityContainerView, activityIndicator: self.activityIndicator)
            }
        }
    }
    
    // -- MARK: Pivker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickViewCompay{
            return companyArray.count
        }
        return languageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickViewCompay{
            self.pickview = pickViewCompay
            return companyArray[row]
        }
        self.pickview = pickViewLanguage
        return languageArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickViewCompay{
            companyTextfield.text = companyArray[row]
            userDefault.set(companyArray[row], forKey: "company")
            cancelClick()
        } else {
            languangeTextfield.text =  languageArray[row]
            userDefault.set(languageArray[row], forKey: "language")
            cancelClick()
        }
    }
    
    // -- MARK: Helper functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.usernameTextfield{
            passwordTextfield.becomeFirstResponder()
        } else if textField == self.passwordTextfield{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.usernameTextfield{
            if let username = usernameTextfield.text{
                userDefault.set(username, forKey: "username")
            }
        }
    }
    
    // -- MARK: helper function
    func setLanguageChosen(languagetextfield: String) -> Int{
        if languagetextfield == languageArray[1] {
            return 2
        }
        return 1
    }
    
    func showAlertMessage(withTitle title: String, andMessage message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(dismissButton)
        present(alert, animated: true, completion: nil)
    }
    
    func setLanguage(){
        let selectedLanguage: Languages = LoginViewController.languageChosen == 1 ? .en : .ar
        LanguageManger.shared.setLanguage(language: selectedLanguage)
    }
}

