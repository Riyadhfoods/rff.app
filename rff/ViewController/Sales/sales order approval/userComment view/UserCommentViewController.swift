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
    
    let webservice = Sales()
    let cellId = "cell_userComment"
    var orderId = ""
    var userCommentArray = [SalesModel]()
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "User Comment"
        setViewAlignment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: userCommentTableView, isEmpty: userCommentArray.count == 0)
        return userCommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserCommentCell{
            
            let userComment = userCommentArray[indexPath.row]
            
            cell.empName.text = userComment.SOA_EMPNAME
            cell.comment.text = userComment.SOA_COMMENT == "" ? AppDelegate.noComment : userComment.SOA_COMMENT
            
            return cell
        }
        return UITableViewCell()
    }
    
}
