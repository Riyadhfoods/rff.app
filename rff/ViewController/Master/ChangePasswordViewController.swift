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
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    
    // -- MARK: Variable
    let screenSize = AppDelegate.shared.screenSize
    
    // 1 --> English, 2 --> Arabic
    let languageChosen = LoginViewController.languageChosen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPasswordTextfield.delegate = self
        newPasswordTextfield.delegate = self
        
        setCustomDefaultNav(navItem: navigationItem)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: IBActions
    
    @IBAction func changeButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        if let oldPassword = oldPasswordTextfield.text, let newPassword = newPasswordTextfield.text{
            startLoader(superView: aiContainer, activityIndicator: ai)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.changePassword(oldPassword: oldPassword, newPassword: newPassword)
                stopLoader(superView: self.aiContainer, activityIndicator: self.ai)
            }
        }
    }
    
    func changePassword(oldPassword: String, newPassword: String){
        AuthServices().changePassword(id: AuthServices.currentUserId, oldPassword: oldPassword, newPassword: newPassword, onSeccuss: {
            AlertMessage().showAlertMessage(alertTitle: "Success".localize(), alertMessage: "Password Change Successfully".localize(), actionTitle: "Ok", onAction: {
                self.oldPasswordTextfield.text = ""
                self.newPasswordTextfield.text = ""
                
                self.oldPasswordTextfield.resignFirstResponder()
                self.newPasswordTextfield.resignFirstResponder()
            }, cancelAction: nil, self)
        }) { (error) in
            AlertMessage().showAlertMessage(alertTitle: "Alert".localize(), alertMessage: error, actionTitle: nil, onAction: nil, cancelAction: "Ok", self)
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














