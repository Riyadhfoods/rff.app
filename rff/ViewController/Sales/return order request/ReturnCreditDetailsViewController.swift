//
//  ReturnCreditDetailsViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 01/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ReturnCreditDetailsViewController: UIViewController {

    @IBOutlet weak var creditLimitRight: UILabel!
    @IBOutlet weak var totalDueRight: UILabel!
    @IBOutlet weak var upTo31Right: UILabel!
    @IBOutlet weak var upTo60Right: UILabel!
    @IBOutlet weak var upTo90Right: UILabel!
    @IBOutlet weak var upTo120Right: UILabel!
    @IBOutlet weak var moreThan90Right: UILabel!
    @IBOutlet weak var statusRight: UILabel!
    @IBOutlet weak var viewHolder: UIView!
    
    // -- MARK: Variables
    
    let webservice = Sales()
    var creditDetailsArray = [SalesReturn]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if LanguageManger.isArabicLanguage{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        setbackNavTitle(navItem: navigationItem)
        viewHolder.layer.cornerRadius = 5.0
        viewHolder.layer.borderColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0).cgColor
        viewHolder.layer.borderWidth = 1
        setupCreditDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCreditDetails(){
        creditLimitRight.text = creditDetailsArray[0].CreditLimit
        totalDueRight.text = creditDetailsArray[0].TotalDue
        upTo31Right.text = creditDetailsArray[0].ZeroTo31Days
        upTo60Right.text = creditDetailsArray[0].ThirtyOneto60Days
        upTo90Right.text = creditDetailsArray[0].SixtyOneTo90Days
        upTo120Right.text = creditDetailsArray[0].Nineoneto120Days
        moreThan90Right.text = creditDetailsArray[0].Above120Days
        statusRight.text = creditDetailsArray[0].Status
    }
    
    // -- MARK: IBActions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        //performSegue(withIdentifier: "showAddItems", sender: nil)
    }

}
