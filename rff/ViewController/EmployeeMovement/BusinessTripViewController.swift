//
//  BusinessTripViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class BusinessTripViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let screenSize = AppDelegate.shared.screenSize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }

}
