//
//  RevealMenu.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation

extension UIViewController {
    func addObservers(onShow: @escaping (_ frame: CGRect) -> Void, onHide: @escaping (_ frame: CGRect) -> Void){
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            (notification) in
            self.keyboardWillShow(notification: notification, onShow: onShow)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            (notification) in
            self.keyboardWillHide(notification: notification, onHide: onHide)
        }
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification, onShow: @escaping (_ frame: CGRect) -> Void){
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        onShow(frame)
    }
    
    func keyboardWillHide(notification: Notification, onHide: @escaping (_ frame: CGRect) -> Void){
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        onHide(frame)
    }
    
    //Align Text Field
    func loopThroughSubViewAndAlignTextfieldText(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if subView is UITextField && subView.tag <= 0{
                    let textField = subView as! UITextField
                    textField.textAlignment = LanguageManger.isArabicLanguage ? .right: .left
                } else if subView is UITextView && subView.tag <= 0{
                    let textView = subView as! UITextView
                    textView.textAlignment = LanguageManger.isArabicLanguage ? .right: .left
                }
                loopThroughSubViewAndAlignTextfieldText(subviews: subView.subviews)
            }
        }
    }
    
    //Align Label Text
    func loopThroughSubViewAndAlignLabelText(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if subView is UILabel && subView.tag <= 0 {
                    let label = subView as! UILabel
                    label.textAlignment = LanguageManger.isArabicLanguage ? .right : .left
                }
                loopThroughSubViewAndAlignLabelText(subviews: subView.subviews)
            }
        }
    }
    
    func setViewAlignment(){
        loopThroughSubViewAndAlignTextfieldText(subviews: self.view.subviews)
        loopThroughSubViewAndAlignLabelText(subviews: self.view.subviews)
    }
    
    //Keeping Label Text appearance to left
    func loopThroughSubViewAndAlignLabelTextToLeft(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                subView.semanticContentAttribute = .forceLeftToRight
                loopThroughSubViewAndAlignLabelText(subviews: subView.subviews)
            }
        }
    }
    
    func setViewAppearanceToLeft(){
        loopThroughSubViewAndAlignLabelTextToLeft(subviews: self.view.subviews)
    }
}

extension UITableViewCell{
    //Align Text Field
    func loopThroughSubViewAndAlignTextfieldText(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if subView is UITextField && subView.tag <= 0{
                    let textField = subView as! UITextField
                    textField.textAlignment = LanguageManger.isArabicLanguage ? .right: .left
                } else if subView is UITextView && subView.tag <= 0{
                    let textView = subView as! UITextView
                    textView.textAlignment = LanguageManger.isArabicLanguage ? .right: .left
                }
                loopThroughSubViewAndAlignTextfieldText(subviews: subView.subviews)
            }
        }
    }
    
    //Align Label Text
    func loopThroughSubViewAndAlignLabelText(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if subView is UILabel && subView.tag <= 0 {
                    let label = subView as! UILabel
                    label.textAlignment = LanguageManger.isArabicLanguage ? .right : .left
                }
                loopThroughSubViewAndAlignLabelText(subviews: subView.subviews)
            }
        }
    }
    
    func setViewAlignment(){
        loopThroughSubViewAndAlignTextfieldText(subviews: self.contentView.subviews)
        loopThroughSubViewAndAlignLabelText(subviews: self.contentView.subviews)
    }
}

extension UIView{
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

