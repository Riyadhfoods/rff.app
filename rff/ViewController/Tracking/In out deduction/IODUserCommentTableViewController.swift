//
//  IODUserCommentTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 03/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class IODUserCommentTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_IOBUserComment"
    var userComment = [CommentModul]()
    var workFlowNames = [String]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userComment.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? IOBUserCommentCell{
            let comment = userComment[indexPath.row]
            if let userId = Int(comment.Id){
                let name = workFlowNames[userId]
                cell.nameLabel.text = name
                cell.commentLabel.text = comment.Comment
            }
            return cell
        }
        return UITableViewCell()
    }
}

class IOBUserCommentCell: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
}



