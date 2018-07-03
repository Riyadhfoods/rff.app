//
//  NavigationBar.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 09/09/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import Foundation
import NotificationCenter

let mainBackgroundColor = AppDelegate().mainBackgroundColor

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

func emptyMessage(message: String, viewController: UIViewController, tableView: UITableView) {
    let rect = CGRect(origin: CGPoint(x: 16,y :16), size: CGSize(width: viewController.view.bounds.size.width - 16, height: viewController.view.bounds.size.height - 16))
    let messageLabel = UILabel(frame: rect)
    messageLabel.text = message
    messageLabel.textColor = mainBackgroundColor
    messageLabel.backgroundColor = .clear
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont.systemFont(ofSize: 20)
    messageLabel.sizeToFit()
    
    tableView.backgroundView = messageLabel;
    tableView.separatorStyle = .none;
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
        
        if LanguageManger.shared.currentLanguage == .en {
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        } else {
            menuButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        }
        
        controller.revealViewController().rearViewRevealWidth = AppDelegate().screenSize.width * 0.75
        controller.revealViewController().rightViewRevealWidth = AppDelegate().screenSize.width * 0.75
        controller.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
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











