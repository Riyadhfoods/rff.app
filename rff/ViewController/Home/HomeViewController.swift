//
//  HomeViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // -- MARK: IBOutlets
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var pendingInboxTableview: UITableView!
    
    // -- MARK: Variable
    let language = LoginViewController.languageChosen
    let screenSize = AppDelegate().screenSize
    let mainBackgroundColor = AppDelegate().mainBackgroundColor
    var greetingMessage: String = ""
    let cell_id = "cell_pendingInbox"
    var webservice: Login = Login()
    var taskInbox: [Task_Inbox] = [Task_Inbox]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(LanguageManger.isArabicLanguage)
        if let userId = AuthServices.currentUserId {
            taskInbox = webservice.Task_InboxM(langid: LoginViewController.languageChosen, emp_id: userId)
        }
        navigationItem.title = "Home".localize()
        view.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0)
        
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
    
    var storyboardName = ""
    var viewContollerId = ""
    @objc func clickViewButtonTapped(sender: UIButton){
        if taskInbox[sender.tag].FormId == "2102"{
            storyboardName = "SalesOrderApproval"
            viewContollerId = "salesOrderApprovalViewControllerNav"
        } else if taskInbox[sender.tag].FormId == "2081" {
            storyboardName = "SalesReturnApproval"
            viewContollerId = "salesReturnApprovalViewControllerNav"
        }
        
        if storyboardName == "" || viewContollerId == "" {return}
        moveTo(storyboard: storyboardName, withIdentifier: viewContollerId, viewController: self)
    }
    
    // -- MARK: IBActions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
