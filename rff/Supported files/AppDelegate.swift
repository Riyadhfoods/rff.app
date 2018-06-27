//
//  AppDelegate.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 20/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let screenSize = UIScreen.main.bounds
    let mainBackgroundColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0)
    
    //UIApplication.shared.isNetworkActivityIndicatorVisible

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // To set a default language
        LanguageManger.shared.defaultLanguage = .en
        
        // To change the title's color of navigation bar
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
        
        return true
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

