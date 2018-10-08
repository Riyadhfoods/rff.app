//
//  RAUserCommentTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class RAUserCommentTableViewController: UITableViewController {

    // -- MARK: Variables
    
    let cellId = "cell_RAUserComment"
    var userComment = [CommentModul]()
    var workFlowNames = [String]()
    
    // -- MARK: View kife Cycle
    
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RAUserCommentCell {
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

class RAUserCommentCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
}













