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
        if taskInbox.count == 0 {
            emptyMessage(message: "No data".localize(), viewController: self, tableView: pendingInboxTableview)
        }
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
        if taskInbox[sender.tag].FormId == "2102"{
            let storyboard = UIStoryboard(name: "SalesOrderApproval", bundle: nil)
            let SOAStoryboard = storyboard.instantiateViewController(withIdentifier: "salesOrderApprovalViewControllerNav")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.revealViewController().pushFrontViewController(SOAStoryboard, animated: true)
            }
        }
    }
    
    // -- MARK: IBActions
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
