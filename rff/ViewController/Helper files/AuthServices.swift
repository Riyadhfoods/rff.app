//
//  AuthServices.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 05/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import UIKit

class AuthServices{
    let loginService = LoginService.instance
    var arrayOfResult: [String?] = [String]()
    var result: String?
    static var currentUserId: String = ""
    static var currentUserName: String?
    let language = LoginViewController.languageChosen
    
    func checkUserId(id: String, password: String, onSeccuss: @escaping () -> Void, onError: @escaping (_ ErrorMessage: String) -> Void, viewController: UIViewController)
    {
        arrayOfResult = loginService.CheckLogin(username: id, password: password, error: "", langid: language)
        
        if !arrayOfResult.isEmpty{
            if arrayOfResult[0] == "0"{
                AuthServices.currentUserId = id
                AuthServices.currentUserName = arrayOfResult[1]
                onSeccuss()
            } else {
                if let error = arrayOfResult[0]{
                    onError(error)
                }
            }
        } else {
            AlertMessage().showAlertMessage(alertTitle: "Oops!", alertMessage: "Something went wrong, please try again", actionTitle: nil, onAction: nil, cancelAction: "Dismiss", viewController)
            print("Oops, something went wrong!")
        }
    }
    
    func logout(_ UIViewController: UIViewController){
        let title: String = "SignOut".localize()
        let message: String = "Are you sure you want to sign out?".localize()
        let actionTitle: String = "Yes".localize()
        let cancelTitle: String = "Cancel".localize()
        
        AlertMessage().showAlertMessage(alertTitle: title, alertMessage: message, actionTitle: actionTitle, onAction: {
            AuthServices.currentUserId = ""
            UIViewController.dismiss(animated: true, completion: nil)
        }, cancelAction: cancelTitle, UIViewController)
    }
    
    func changePassword(id: String, oldPassword: String, newPassword: String, onSeccuss: @escaping () -> Void, onError: @escaping (_ ErrorMessage: String) -> Void){
        result = loginService.ChangePassword(emp_id: id, oldpassword: oldPassword, newpassword: newPassword, error: "")
        if result == "0"{
            onSeccuss()
        } else {
            if let error = result{
                onError(error)
            }
        }
    }
}






