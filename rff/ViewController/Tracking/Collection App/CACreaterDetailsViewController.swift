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
    
    var creatorAndCollectionDetails = CreatorAndCollectionDetailsModul()
    
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
        nameLabel.text = creatorAndCollectionDetails.emp_name
        mgrLabel.text = creatorAndCollectionDetails.mgr_name
        departmentLabel.text = creatorAndCollectionDetails.dept_name
        nationalityLabel.text = creatorAndCollectionDetails.nationality
        joinDateLabel.text = creatorAndCollectionDetails.join_date
        startDateLabel.text = creatorAndCollectionDetails.start_date
        jobDescLabel.text = creatorAndCollectionDetails.job_desc
        subJobLabel.text = creatorAndCollectionDetails.sub_job_desc
    }
    
}
