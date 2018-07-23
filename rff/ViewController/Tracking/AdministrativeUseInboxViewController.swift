//
//  AdministrativeUseInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class AdministrativeUseInboxViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var vacationType: UILabel!
    @IBOutlet weak var vacationDays: UILabel!
    @IBOutlet weak var used: UILabel!
    @IBOutlet weak var requested: UILabel!
    @IBOutlet weak var remainimg: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    // -- MARK: Variables
    
    
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
        setupCommentView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    func setupCommentView(){
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
    }

}
