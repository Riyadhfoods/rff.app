//
//  EmployeeVacationViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class EmployeeVacationViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var addVacationButtonOutlet: UIButton!
    
    let screenSize = AppDelegate().screenSize
    let languageChosen = LoginViewController.languageChosen
    //let swrevealAction = SWRevealFunction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing the back button of the navigation contoller
        setCustomNav(navItem: navigationItem)
        addVacationButtonOutlet.setTitle(getString(englishString: "ADD VACATION", arabicString: "إضافة اجازه", language: languageChosen), for: .normal)
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
