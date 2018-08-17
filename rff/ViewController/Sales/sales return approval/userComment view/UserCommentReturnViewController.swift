//
//  UserCommentReturnViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 02/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class UserCommentReturnViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var userCommentReturnTableView: UITableView!
    
    // -- MARK: Variables
    
    let cellId = "cell_returnUserComment"
    var orderId = ""
    var userCommentArray = [CommentModul]()
    var userWithNotEmptyCommentArray = [CommentModul]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Comment".localize()
        for comment in userCommentArray{
            if comment.Comment != ""{
                userWithNotEmptyCommentArray.append(comment)
            }
        }
        
        setViewAlignment()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: userCommentReturnTableView, isEmpty: userWithNotEmptyCommentArray.count == 0)
        return userWithNotEmptyCommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserCommentReturnCell{
            
            let userComment = userWithNotEmptyCommentArray[indexPath.row]
            cell.empNameReturn.text = userComment.Name
            cell.commentReturn.text = userComment.Comment
            return cell
            
        }
        return UITableViewCell()
    }
}
