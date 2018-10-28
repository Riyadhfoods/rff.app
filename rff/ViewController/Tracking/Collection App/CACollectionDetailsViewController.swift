//
//  CACollectionDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CACollectionDetailsViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var customerLabel: UILabel!
    @IBOutlet weak var salesPersonLabel: UILabel!
    @IBOutlet weak var collectionTypeLabel: UILabel!
    @IBOutlet weak var territoryLabel: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var checkNoAndBankNameTitle: UILabel!
    @IBOutlet weak var checkNoAndBankNameLabel: UILabel!
    @IBOutlet weak var checkNoAndBankNameStackView: UIStackView!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    var collectionDetails = [String]()
    
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
        customerLabel.text = ""
        salesPersonLabel.text = ""
        collectionTypeLabel.text = ""
        territoryLabel.text = ""
        amount.text = ""
        checkNoAndBankNameTitle.text = ""
        checkNoAndBankNameLabel.text = ""
    }
}
