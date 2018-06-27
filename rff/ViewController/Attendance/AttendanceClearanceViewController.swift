//
//  AttendanceClearanceViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AttendanceClearanceViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let screenSize = AppDelegate().screenSize
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func showButtonTapped(_ sender: Any) {
        
    }
}
