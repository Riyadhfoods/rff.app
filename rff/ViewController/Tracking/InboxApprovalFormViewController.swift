//
//  InboxApprovalFormViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InboxApprovalFormViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    // -- MARK: Variables
    
    let cellId = "cell_inboxApprovalForm"
    let cellTitleArray = ["Employee General Information", "Leave Details", "For Administrative Use Only", "Companions Details", "Settlement and Ticket Details", "User Comment", "Work Flow"]
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Approval Form"
        
        setViewAlignment()
        setupCommentView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // -- MARK: Set ups
    
    func setupCommentView(){
        commentTextView.text = ""
        commentTextView.layer.cornerRadius = 5.0
        commentTextView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        commentTextView.layer.borderWidth = 1
    }
    
    // MARK: IBActions

    @IBAction func approveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
    }
    
}

extension InboxApprovalFormViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? InboxApprovalFormCell{
            
            let cellTitle = cellTitleArray[indexPath.row]
            cell.textLabel?.text = cellTitle
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: performSegue(withIdentifier: "showInboxEmpDetails", sender: nil)
        case 1: performSegue(withIdentifier: "showInboxLeaveDetails", sender: nil)
        case 2: performSegue(withIdentifier: "showAdministrativeUseDetails", sender: nil)
        case 3: performSegue(withIdentifier: "showCompanionsDetailsInbox", sender: nil)
        case 4: performSegue(withIdentifier: "showSettlementandTicketDetails", sender: nil)
        case 5: performSegue(withIdentifier: "showUserCommentInbox", sender: nil)
        case 6: performSegue(withIdentifier: "showWorkFlowInbox", sender: nil)
        default: break}
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// -- MARK: Table View Cell

class InboxApprovalFormCell: UITableViewCell{
    
}
