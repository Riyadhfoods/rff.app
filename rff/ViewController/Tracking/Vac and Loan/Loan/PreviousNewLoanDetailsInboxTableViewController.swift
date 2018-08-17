//
//  PreviousNewLoanDetailsInboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 24/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class PreviousNewLoanDetailsInboxTableViewController: UITableViewController {
    
    // -- MARK: Variables

    let cellId = "cell_previousNewLoanDetailsInbox"
    var prevLoanForLoan = [LastLoan]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set up
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prevLoanForLoan.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PreviousNewLoanDetailsInbox{
            
            let prevLoan = prevLoanForLoan[indexPath.row]
            cell.date.text = prevLoan.L_Date
            cell.startDate.text = prevLoan.L_StartDate
            cell.guarantor.text = prevLoan.L_Guarantor
            cell.loanType.text = prevLoan.L_LoanType
            cell.amount.text = prevLoan.L_Amount
            cell.monthlyPayment.text = prevLoan.L_MonthlyPay
            cell.deductedValue.text = prevLoan.L_DeductedValue
            cell.balAmount.text = prevLoan.L_BalAmount
            
            return cell
        }
        return UITableViewCell()
    }

}

class PreviousNewLoanDetailsInbox: UITableViewCell{
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var guarantor: UILabel!
    @IBOutlet weak var loanType: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var monthlyPayment: UILabel!
    @IBOutlet weak var deductedValue: UILabel!
    @IBOutlet weak var balAmount: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
    }
}





