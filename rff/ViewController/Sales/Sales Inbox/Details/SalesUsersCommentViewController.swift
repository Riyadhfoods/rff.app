//
//  SalesUsersCommentViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 15/07/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesUsersCommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userCommentTableView: UITableView!
    var userCommentArray = [CommentModul]()
    var userCommentOrderArray = [CommentModul]()
    var userWithNotEmptyCommentArray = [CommentModul]()
    var userWithNotEmptyCommentOrderArray = [CommentModul]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userCommentArray.isEmpty{
            for index in 0..<userCommentArray.count where index != 0{
                if userCommentArray[index].Comment != ""{
                    userWithNotEmptyCommentArray.append(userCommentArray[index])
                }
            }
        } else {
            for index in 0..<userCommentOrderArray.count where index != 0{
                if userCommentOrderArray[index].Comment != ""{
                    userWithNotEmptyCommentOrderArray.append(userCommentOrderArray[index])
                }
            }
        }
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !userWithNotEmptyCommentOrderArray.isEmpty { return userWithNotEmptyCommentOrderArray.count }
        return userWithNotEmptyCommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesUserComment", for: indexPath) as? SalesUsersCommentCell{
            
            if !userWithNotEmptyCommentOrderArray.isEmpty{
                let userCommentOrder = userWithNotEmptyCommentOrderArray[indexPath.row]
                cell.empName.text = userCommentOrder.Name
                cell.comment.text = userCommentOrder.Comment
            } else {
                let userComment = userWithNotEmptyCommentArray[indexPath.row]
                cell.empName.text = userComment.Name
                cell.comment.text = userComment.Comment
            }
            return cell
        }
        return UITableViewCell()
    }
}
