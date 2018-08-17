//
//  HomeViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit
import Crashlytics

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var pendingInboxTableview: UITableView!
    
    // -- MARK: Variable
    let language = LoginViewController.languageChosen
    let screenSize = AppDelegate.shared.screenSize
    let mainBackgroundColor = AppDelegate.shared.mainBackgroundColor
    var greetingMessage: String = ""
    let cell_id = "cell_pendingInbox"
    var taskInbox: [Task_InboxModul] = [Task_InboxModul]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formId = ""
        taskInbox = HomeService.instance.Task_Inbox(langid: LoginViewController.languageChosen, emp_id: AuthServices.currentUserId)
        navigationItem.title = "Home".localize()
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
        //addObserver()
        setViewAlignment()
        setSlideMenu(controller: self, menuButton: menuBtn)
    }
    
    // -- MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyMessage(viewController: self, tableView: pendingInboxTableview, isEmpty: taskInbox.count == 0)
        return taskInbox.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? PendingInboxCell{
            cell.contentView.backgroundColor = UIColor.clear
            
            let english_description = taskInbox[indexPath.row].EnglishDes
            let arabic_description = taskInbox[indexPath.row].ArabicDesc
            let count = taskInbox[indexPath.row].Count
            
            cell.englishDescriptionLeft.text = english_description.localize()
            cell.arabicDescriptionLeft.text = arabic_description.localize()
            cell.countLeft.text = "\(count)".localize()
            
            cell.viewButton.tag = indexPath.row
            cell.viewButton.addTarget(self, action: #selector(clickViewButtonTapped(sender:)), for: .touchUpInside)
            
            return cell
        }
        return UITableViewCell()
    }
    
    // -- MARK: objc Functions
    
    @objc func clickViewButtonTapped(sender: UIButton){
        var storyboardName = ""
        var viewContollerId = ""
        switch taskInbox[sender.tag].FormId{
        case "2102":
            storyboardName = "SalesOrderApproval"
            viewContollerId = "salesOrderApprovalViewControllerNav"
        case "2081":
            storyboardName = "SalesReturnApproval"
            viewContollerId = "salesReturnApprovalViewControllerNav"
        case "10", "1001", "1002", "1003", "1004", "1005", "1006", "1008", "1009", "1010", "1011", "1012", "1013", "2079", "2083", "2093":
            storyboardName = "Tracking"
            viewContollerId = "trackingInboxViewControllerNav"
            formId = taskInbox[sender.tag].FormId
        default:
            break
        }

        if storyboardName == "" || viewContollerId == "" {return}
        moveTo(storyboard: storyboardName, withIdentifier: viewContollerId, viewController: self)
    }
    
    // -- MARK: IBActions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
