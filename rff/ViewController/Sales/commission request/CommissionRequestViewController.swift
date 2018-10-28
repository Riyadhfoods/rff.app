//
//  CommissionRequestViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CommissionRequestViewController: UIViewController {
    // -- MARK: IBOutlets
    
    
    
    // -- MARK: Variables
    
    var textfield = UITextField()
    var pickerview = UIPickerView()
    let pvInstance = PickerviewAction()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // -- MARK: Setups
    
    
    
    // -- MARK: Helper methods
    
    
    
    // -- MARK: IBAction
    

}

// -- MARK: Handle Picker View

extension CommissionRequestViewController{
    
}

// -- MARK: Handle TextField and TextView

extension CommissionRequestViewController: UITextViewDelegate, UITextFieldDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            commentTextView.resignFirstResponder()
//            return false
//        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
}

extension CommissionRequestViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 81, right: 0)
//            self.scrollView.contentInset = contentInset
        }, onHide: { _ in
//            self.scrollView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}



























