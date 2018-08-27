//
//  BTUserCommentTableViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class BTUserCommentTableViewController: UITableViewController {

    // -- MARK: Variables
    
    var userCommentArray = [CommentModul]()
    let cellId = "cell_userCommentBT"
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
        emptyMessage(viewController: self, tableView: tableView, isEmpty: userCommentArray.isEmpty)
        return userCommentArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BTUserCommentCell{
            
            let comment = userCommentArray[indexPath.row]
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

class BTUserCommentCell: UITableViewCell{
    
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
    }
}
