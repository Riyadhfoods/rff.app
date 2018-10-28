//
//  CACreaterDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CACreaterDetailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mgrLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var joinDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var jobDescLabel: UILabel!
    @IBOutlet weak var subJobLabel: UILabel!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    var creatorDetails = [String]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUp()
    }
    
    // -- MARK: Set Ups
    
    func setUpView(){
        viewWidth.constant = AppDelegate.shared.screenSize.width - 32
    }
    
    func setUp(){
        nameLabel.text = ""
        mgrLabel.text = ""
        departmentLabel.text = ""
        nationalityLabel.text = ""
        joinDateLabel.text = ""
        startDateLabel.text = ""
        jobDescLabel.text = ""
        subJobLabel.text = ""
    }
    
}
