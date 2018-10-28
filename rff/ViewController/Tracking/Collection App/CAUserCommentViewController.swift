//
//  CAUserCommentViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CAUserCommentViewController: UITableViewController {

    // -- MARK: IBOutlets
    
    
    
    // -- MARK: Variables
    
    let cellId = "cell_CAUserComment"
    var userComment = [CommentModul]()
    var workFlowNames = [String]()
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // -- MARK: Set Ups

}

extension CAUserCommentViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CAUserComment{
//            let comment = userComment[indexPath.row]
//            if let userId = Int(comment.Id){
//                let name = workFlowNames[userId]
//                cell.nameLabel.text = name
//                cell.commentLabel.text = comment.Comment
//            }
            return cell
        }
        
        return UITableViewCell()
    }
}

class CAUserComment: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
}
