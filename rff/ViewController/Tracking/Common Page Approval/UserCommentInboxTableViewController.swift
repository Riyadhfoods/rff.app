//
//  UserCommentInboxTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class UserCommentInboxTableViewController: UITableViewController {
    
    // -- MARK: Variables

    let cellId = "cell_userCommentInbox"
    var userComment = [CommentModul]()
    var workFlowNames = [String]()
    var empName = ""
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: tableView, isEmpty: userComment.isEmpty)
        return userComment.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserCommentInbox{
            
            let comment = userComment[indexPath.row]
            if let userId = Int(comment.Id){
                let name = workFlowNames[userId]
                cell.empName.text = name
                cell.comment.text = comment.Comment
            }
            return cell
        }
        return UITableViewCell()
    }
 
}


class UserCommentInbox: UITableViewCell{
    
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
        holderView.layer.cornerRadius = 5.0
        holderView.layer.borderColor = AppDelegate.shared.mainBackgroundColor.cgColor
        holderView.layer.borderWidth = 1
        
    }
}
