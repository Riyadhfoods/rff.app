//
//  AppDelegate.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics


class AppDelegate: UIResponder, UIApplicationDelegate {

    static let shared = AppDelegate()
    var window: UIWindow?
    let screenSize = UIScreen.main.bounds
    let mainBackgroundColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0)
    static let noComment = "No comment ...".localize()
    
    //UIApplication.shared.isNetworkActivityIndicatorVisible

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // To get crashed report
        logUser()
        Fabric.with([Crashlytics.self])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationDidTimeout(notification:)),
                                               name: .appTimeout,
                                               object: nil
        )
        
        // To set a default language
        LanguageManger.shared.defaultLanguage = .en
        
        // To change the title's color of navigation bar
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        
        return true
    }
    
    @objc func applicationDidTimeout(notification: NSNotification) {
        var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
        topWindow?.rootViewController = UIViewController()
        topWindow?.windowLevel = UIWindowLevelAlert + 1
        
        if UIApplication.topViewController() is LoginViewController{
            return
        }
        
        print("application did timeout, perform actions")
        
        let alert = UIAlertController(title: "Session Timeout", message: "Timeout due to inactivity, please login again.", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            topWindow?.isHidden = true // if you want to hide the topwindow then use this
            topWindow = nil
            self.window?.rootViewController?.dismiss(animated: true, completion: nil)
        })
        alert.addAction(cancelButton)
        
        topWindow?.makeKeyAndVisible()
        topWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func logUser(){
        Crashlytics.sharedInstance().setUserIdentifier(AuthServices.currentUserId)
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
