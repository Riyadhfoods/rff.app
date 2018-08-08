//
//  UserCommentViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class UserCommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var userCommentTableView: UITableView!
    
    
    // -- MARK: Variables
    
    let cellId = "cell_userComment"
    var orderId = ""
    var userCommentArray = [CommentModul]()
    var userCommentWithNoEmptyValue = [CommentModul]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Comment"
        
        for index in 0..<userCommentArray.count where index != 0{
            if userCommentArray[index].Name != ""{
                if userCommentArray[index].Comment != ""{
                    userCommentWithNoEmptyValue.append(userCommentArray[index])
                }
            }
        }
        
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: userCommentTableView, isEmpty: userCommentWithNoEmptyValue.count == 0)
        return userCommentWithNoEmptyValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserCommentCell{
            
            let userComment = userCommentWithNoEmptyValue[indexPath.row]
            
            cell.empName.text = userComment.Name
            cell.comment.text = userComment.Comment
            
            return cell
        }
        return UITableViewCell()
    }
    
}
