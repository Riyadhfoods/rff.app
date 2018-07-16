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
    var userWithNotEmptyCommentArray = [SalesReturn]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<userCommentArray.count where index != 0{
            if userCommentArray[index].SRA_User_EmpComment != ""{
                userWithNotEmptyCommentArray.append(userCommentArray[index])
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userWithNotEmptyCommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell_salesUserComment", for: indexPath) as? SalesUsersCommentCell{
            
            let userComment = userWithNotEmptyCommentArray[indexPath.row]
            cell.empName.text = userComment.SRA_User_EmpName
            cell.comment.text = userComment.SRA_User_EmpComment
            
            return cell
        }
        return UITableViewCell()
    }
}
