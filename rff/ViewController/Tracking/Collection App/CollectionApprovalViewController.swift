//
//  collectionApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/10/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class CollectionApprovalViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var titlesTableView: UITableView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    @IBOutlet weak var stckViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonStack: UIStackView!
    
    // -- MARK: Variables
    
    let cellId = "cell_collectionApproval"
    let titles = ["Creator Details",
                  "Collection Details",
                  "User Commnet",
                  "Work Flow"]
    var creatorDetails = [String]()
    var collectionDetails = [String]()
    var userComment = [CommentModul]()
    var workFlow = [WorkFlowModul]()
    var editWorkFlow = [WorkFlowModul]()
    var workFlowNames = [String]()
    
    // Variables that is received from the prev view
    
    var listFormId: Int = 0
    var cellRow = 0
    var categorySelected = 0
    var pid = ""
    var appliedEmpName = ""
    var appliedEmpId = ""
    var gridEmpId = ""
    var gridEmpId_next = ""
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleTableViewHeight()
    }
    
    // -- MARK: Set Ups
    
    func setUpView(){
        stckViewWidth.constant = UIScreen.main.bounds.width - 32
    }
    
    func setUpArray(){
        
        for element in workFlow{
            workFlowNames.append(element.WorkFlow_EmpName)
        }
        if editWorkFlow.isEmpty{
            let updatedValues = CommonTrackFunctions.instance.updateWorkFlowPendingStatus(array: workFlow, editArray: &editWorkFlow)
            editWorkFlow = updatedValues.0
            gridEmpId = updatedValues.1
            gridEmpId_next = updatedValues.2
            buttonStack.isHidden = updatedValues.3
        }
    }
    
    func handleTableViewHeight(){
        tableViewHieght.constant = titlesTableView.contentSize.height
        titlesTableView.reloadData()
    }
    
    // -- MARK: Helper methods
    
    
    
    // -- MARK: IBAction
    
    @IBAction func approveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
    }
    
}

// -- MARK: Table View Data Source

extension CollectionApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0: performSegue(withIdentifier: "showCACreatorDetails", sender: nil)
        case 1: performSegue(withIdentifier: "showCACollectionDetails", sender: nil)
        case 2: performSegue(withIdentifier: "showCAUserComment", sender: nil)
        case 3: performSegue(withIdentifier: "showCAWorkFlow", sender: nil)
        default: break}
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCACreatorDetails" {
            if let vc = segue.destination as? CACreaterDetailsViewController {
                vc.creatorDetails = creatorDetails
                vc.navigationItem.title = titles[0]
            }
        } else if segue.identifier == "showCACollectionDetails" {
            if let vc = segue.destination as? CACollectionDetailsViewController {
                vc.collectionDetails = collectionDetails
                vc.navigationItem.title = titles[1]
            }
        } else if segue.identifier == "showCAUserComment" {
            if let vc = segue.destination as? CAUserCommentViewController {
                vc.userComment = userComment
                vc.workFlowNames = workFlowNames
                vc.navigationItem.title = titles[2]
            }
        } else if segue.identifier == "showCAWorkFlow" {
            if let vc = segue.destination as? CAWorkFlowViewController {
                vc.workFlow = editWorkFlow
                vc.navigationItem.title = titles[3]
            }
        }
    }
    
}

// -- MARK: Scroll View Up Keyboad appreance

extension CollectionApprovalViewController{
    
}
