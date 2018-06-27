//
//  CitrixViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CitrixViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let screenSize = AppDelegate().screenSize
    //let swrevealAction = SWRevealFunction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
    }
    
    //To show the slide menu
    func sideMenus () {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = screenSize.width * 0.75
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
