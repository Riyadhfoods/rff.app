//
//  AlertMessage.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 06/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

class AlertMessage{
    func showAlertMessage(alertTitle: String, alertMessage: String, actionTitle: String?, onAction: (() -> Void)?, cancelAction: String?, _ viewController: UIViewController){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        if let actionTitle = actionTitle{
            let action = UIAlertAction(title: actionTitle, style: .default) { (action) in
                onAction?() }
            alert.addAction(action)
        }
        
        if let cancelAction = cancelAction{
            let cancel = UIAlertAction(title: cancelAction, style: .cancel, handler: nil)
            alert.addAction(cancel)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForXTime(alertTitle: String, time: TimeInterval, tagert viewContoller: UIViewController){
        let alert = UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)
        viewContoller.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: time, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
}
