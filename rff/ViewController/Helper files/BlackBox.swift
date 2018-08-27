//
//  NavigationBar.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import NotificationCenter

let mainBackgroundColor = AppDelegate.shared.mainBackgroundColor

func setCustomDefaultNav(navItem: UINavigationItem){
    navItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navItem.title = SlideMenuViewController.selectedItem.localize()
}

func setCustomNav(navItem: UINavigationItem, title: String){
    navItem.title = title.localize()
    navItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
}

func setCustomNavAndBackButton(navItem: UINavigationItem, title: String, backTitle: String?){
    navItem.title = title.localize()
    if let backTitle = backTitle{
        navItem.backBarButtonItem = UIBarButtonItem(title: backTitle, style: .plain, target: nil, action: nil)
    } else {
        navItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

func setbackNavTitle(navItem: UINavigationItem){
    navItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
}

func emptyMessage(viewController: UIViewController, tableView: UITableView, isEmpty: Bool) {
    let rect = CGRect(origin: CGPoint(x: 16,y :16), size: CGSize(width: viewController.view.bounds.size.width - 16, height: viewController.view.bounds.size.height - 16))
    let messageLabel = UILabel(frame: rect)
    messageLabel.text = isEmpty ? "No Data".localize() : ""
    messageLabel.textColor = mainBackgroundColor
    messageLabel.backgroundColor = .clear
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont.systemFont(ofSize: 20)
    messageLabel.sizeToFit()
    
    tableView.backgroundView = messageLabel
    tableView.separatorStyle = .none
}

let tb: UIToolbar = {
    let tb = UIToolbar()
    tb.barStyle = .default
    tb.isTranslucent = true
    tb.tintColor = UIColor.black
    tb.sizeToFit()
    tb.isUserInteractionEnabled = true
    
    return tb
}()

func setUpKeyboardToolBar(textfield: UITextField, viewController: Any?, cancelTitle: String?, cancelSelector: Selector?, doneTitle: String?, doneSelector: Selector?){
    
    var items: [UIBarButtonItem] = [UIBarButtonItem]()
    var doneButton = UIBarButtonItem()
    var cancelButton = UIBarButtonItem()
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    if doneSelector != nil {
        doneButton = UIBarButtonItem(title: doneTitle, style: .plain, target: viewController, action: doneSelector)
        items.append(doneButton)
    }
    
    if cancelTitle != nil && cancelSelector != nil {
        cancelButton = UIBarButtonItem(title: cancelTitle, style: .plain, target: viewController, action: cancelSelector)
        items.append(spaceButton)
        items.append(cancelButton)
    }
    tb.setItems(items, animated: false)
    textfield.inputAccessoryView = tb
}

// Slide Menu
func setSlideMenu(controller: UIViewController, menuButton: UIBarButtonItem){
    if controller.revealViewController() != nil{
        menuButton.target = controller.revealViewController()
        
        if !LanguageManger.isArabicLanguage {
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            controller.revealViewController().rearViewRevealWidth = AppDelegate.shared.screenSize.width * 0.75
            controller.revealViewController().rightViewController = nil
        } else {
            menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            controller.revealViewController().rightViewRevealWidth = AppDelegate.shared.screenSize.width * 0.75
            controller.revealViewController().rearViewController = nil
        }
        controller.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
        controller.view.addGestureRecognizer(controller.revealViewController().tapGestureRecognizer())
    }
}

//Moving to that storyboard

func moveTo(storyboard name: String, withIdentifier id: String, viewController: UIViewController){
    let storyboard = UIStoryboard(name: name, bundle: nil)
    let viewControllerStoryboard = storyboard.instantiateViewController(withIdentifier: id)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        viewController.revealViewController().pushFrontViewController(viewControllerStoryboard, animated: true)
    }
}

// setUp the views

func setUpCellHolderViewAndCellBackground(holderView: UIView, contentView: UIView?){
    holderView.layer.cornerRadius = 5.0
    holderView.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
    holderView.layer.borderWidth = 1
    contentView?.backgroundColor =  UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
    
}

enum ScrollDirection {
    case Top
    case Right
    case Bottom
    case Left
    
    func contentOffsetWith(scrollView: UIScrollView) -> CGPoint {
        var contentOffset = CGPoint.zero
        switch self {
        case .Top:
            contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        case .Right:
            contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
        case .Bottom:
            contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        case .Left:
            contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
        }
        return contentOffset
    }
}

func ActivityIndicatorDisplayAndAction(activityIndicator: UIActivityIndicatorView, action: @escaping () -> Void){
    activityIndicator.startAnimating()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
        action()
        activityIndicator.stopAnimating()
    })
}

func ActivityIndicatorDisplayAndActionAfterward(start: (), end: (), action: @escaping () -> Void){
    start
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
        action()
        end
    })
}

func getStringDate(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: date)
}

func setUpActivityIndicatorHolder(view: UIView){
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 1
    view.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
}

func startLoader(superView: UIView, activityIndicator: UIActivityIndicatorView){
    superView.isHidden = false
    activityIndicator.startAnimating()
}

func stopLoader(superView: UIView, activityIndicator: UIActivityIndicatorView){
    superView.isHidden = true
    activityIndicator.stopAnimating()
}





