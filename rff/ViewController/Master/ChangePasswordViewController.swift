//
//  ChangePasswordViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController, UITextFieldDelegate {

    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var oldPasswordLabel: UILabel!
    @IBOutlet weak var oldPasswordTextfield: UITextField!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var newPasswordTextfield: UITextField!
    @IBOutlet weak var changeButtonOutlet: UIButton!
    
    // -- MARK: Variable
    let screenSize = AppDelegate().screenSize
    
    // 1 --> English, 2 --> Arabic
    let languageChosen = LoginViewController.languageChosen
    var buttonTitle: String = ""
    var successfulAlertTitle: String = ""
    var errorAlertTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding the text field delegate
        oldPasswordTextfield.delegate = self
        newPasswordTextfield.delegate = self
        
        setCustomNav(navItem: navigationItem)
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: IBActions
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        successfulAlertTitle = getString(englishString: "Password Change Successfully", arabicString: "تم تغيير الرقم السري بنجاح", language: languageChosen)
        errorAlertTitle = getString(englishString: "Error!", arabicString: "خطأ", language: languageChosen)
        
        if let currentUserId = AuthServices.currentUserId, let oldPassword = oldPasswordTextfield.text, let newPassword = newPasswordTextfield.text{
            AuthServices().changePassword(id: currentUserId, oldPassword: oldPassword, newPassword: newPassword, onSeccuss: {
                AlertMessage().showAlertMessage(alertTitle: self.successfulAlertTitle, alertMessage: "", actionTitle: "Ok", onAction: {
                    self.oldPasswordTextfield.text = ""
                    self.newPasswordTextfield.text = ""
                    
                    self.oldPasswordTextfield.resignFirstResponder()
                    self.newPasswordTextfield.resignFirstResponder()
                }, cancelAction: nil, self)
            }) { (error) in
                AlertMessage().showAlertMessage(alertTitle: self.errorAlertTitle, alertMessage: error, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
            }
            self.view.endEditing(true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.oldPasswordTextfield{
            newPasswordTextfield.becomeFirstResponder()
        } else if textField == self.newPasswordTextfield{
            textField.resignFirstResponder()
        }
        return true
    }
}














