//
//  AttendanceDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AttendanceDetailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var timeSheet: UITextField!
    @IBOutlet weak var timeSheetDropdown: UIImageView!
    @IBOutlet weak var employeeName: UITextField!
    @IBOutlet weak var employeeNameDropdown: UIImageView!
    @IBOutlet weak var dateEnd: UIView!
    @IBOutlet weak var dateStart: UITextField!
    
    @IBOutlet weak var selectorHolderInOut: UIView!
    @IBOutlet weak var selectorHolderIn: UIView!
    @IBOutlet weak var selectorHolderOut: UIView!
    
    @IBOutlet weak var innerViewInOut: UIView!
    @IBOutlet weak var innerViewIn: UIView!
    @IBOutlet weak var innerViewOut: UIView!
    
    @IBOutlet weak var selectorButtonInOut: UIButton!
    @IBOutlet weak var selectorButtonIn: UIButton!
    @IBOutlet weak var selectorButtonOut: UIButton!
    
    // -- MARK: Variables
    
    let screenSize = AppDelegate().screenSize
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
        setUpSelectors()
    }
    
    // -- MARK: setUps
    
    func setUpSelectors(){
        let cornerRadiusValueHolder: CGFloat = 12
        let cornerRadiusValueInner: CGFloat = 11
        let cornerRadiusValueView: CGFloat = 9
        
        selectorHolderInOut.layer.cornerRadius = cornerRadiusValueHolder
        selectorHolderIn.layer.cornerRadius = cornerRadiusValueHolder
        selectorHolderOut.layer.cornerRadius = cornerRadiusValueHolder
        
        innerViewInOut.layer.cornerRadius = cornerRadiusValueInner
        innerViewIn.layer.cornerRadius = cornerRadiusValueInner
        innerViewOut.layer.cornerRadius = cornerRadiusValueInner
        
        selectorButtonInOut.layer.cornerRadius = cornerRadiusValueView
        selectorButtonInOut.backgroundColor = mainBackgroundColor
        
        selectorButtonIn.layer.cornerRadius = cornerRadiusValueView
        selectorButtonIn.backgroundColor = .white
        
        selectorButtonOut.layer.cornerRadius = cornerRadiusValueView
        selectorButtonOut.backgroundColor = .white
    }
    
    // -- MARK: IBActions
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectorButtonInOutTapped(_ sender: Any) {
        selectorButtonInOut.backgroundColor = mainBackgroundColor
        selectorButtonIn.backgroundColor = .white
        selectorButtonOut.backgroundColor = .white
    }
    
    @IBAction func selectorButtonInTapped(_ sender: Any) {
        selectorButtonInOut.backgroundColor = .white
        selectorButtonIn.backgroundColor = mainBackgroundColor
        selectorButtonOut.backgroundColor = .white
    }
    
    @IBAction func selectorButtonOutTapped(_ sender: Any) {
        selectorButtonInOut.backgroundColor = .white
        selectorButtonIn.backgroundColor = .white
        selectorButtonOut.backgroundColor = mainBackgroundColor
    }
    
}
