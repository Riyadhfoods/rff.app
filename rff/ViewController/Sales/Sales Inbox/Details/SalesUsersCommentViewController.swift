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
    var userCommentArray = [SalesReturn]()
    var userCommentOrderArray = [SalesModel]()
    var userWithNotEmptyCommentArray = [SalesReturn]()
    var userWithNotEmptyCommentOrderArray = [SalesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !userCommentArray.isEmpty{
            for index in 0..<userCommentArray.count where index != 0{
                if userCommentArray[index].SRA_User_EmpComment != ""{
                    userWithNotEmptyCommentArray.append(userCommentArray[index])
                }
            }
        } else {
            for index in 0..<userCommentOrderArray.count where index != 0{
                if userCommentOrderArray[index].SOA_COMMENT != ""{
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
                cell.empName.text = userCommentOrder.SOA_EMPNAME
                cell.comment.text = userCommentOrder.SOA_COMMENT
            } else {
                let userComment = userWithNotEmptyCommentArray[indexPath.row]
                cell.empName.text = userComment.SRA_User_EmpName
                cell.comment.text = userComment.SRA_User_EmpComment
            }
            return cell
        }
        return UITableViewCell()
    }
}
