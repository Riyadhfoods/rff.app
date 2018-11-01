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
        customerLabel.text = creatorAndCollectionDetails.customer_name
        salesPersonLabel.text = creatorAndCollectionDetails.sales_person
        collectionTypeLabel.text = creatorAndCollectionDetails.coll_type
        territoryLabel.text = creatorAndCollectionDetails.territory
        amount.text = creatorAndCollectionDetails.amount
        //checkNoAndBankNameTitle.text = ""
        checkNoAndBankNameLabel.text = creatorAndCollectionDetails.check_book_no
    }
}
