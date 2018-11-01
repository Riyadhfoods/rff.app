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
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    let cellId = "cell_collectionApproval"
    var titles = ["Creator Details",
                  "Collection Details",
                  "User Commnet",
                  "Work Flow"]
    let filteredTitles = [String]()
    let webService = SalesCollectionApprovalService.instance
    let Btrip_webService = BusinessTripApprovalService.instance
    var creatorAndCollectionDetails = CreatorAndCollectionDetailsModul()
    var userComment = [CommentModul]()
    var workFlow = [WorkFlowModul]()
    var editWorkFlow = [WorkFlowModul]()
    var workFlowNames = [String]()
    var lang_int = 0
    var lang_string = ""
    
    // Variables that is received from the prev view
    
    var listFormId: Int = 0
    var cellRow = 0
    var categorySelected = 0
    var pid = ""
    var appliedEmpName = ""
    var appliedEmpId = ""
    var gridEmpId = ""
    var gridEmpId_next = ""
    
    var delegate: ApproveActionDelegate?
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isCreatorAndCollecitonEmpty()
            && workFlow.isEmpty
            && userComment.isEmpty{
            setUpArray()
            handleTableViewHeight()
        }
        stop()
    }
    
    // -- MARK: Set Ups
    
    func setUpView(){
        start()
        lang_int = LoginViewController.languageChosen
        lang_string = LoginViewController.languageChosen == 1 ? "eng" : "ar"
        
        stckViewWidth.constant = UIScreen.main.bounds.width - 32
        if LanguageManger.isArabicLanguage{
            title = "نموذج الموافقة"
        } else {  title = "Approval Form" }
        setbackNavTitle(navItem: navigationItem)
    }
    
    func setUpArray(){
        creatorAndCollectionDetails = webService.Get_Emps_Details(pid: pid, fid: "\(listFormId)", lang: lang_string)
        workFlow = webService.BindApproversGrid_SC(emp_id: appliedEmpId, formid: listFormId, pid: pid, langid: lang_int)
        if !workFlow.isEmpty
        { userComment = Btrip_webService.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlow.count) }
        
        for element in workFlow{ workFlowNames.append(element.WorkFlow_EmpName) }
        filterArrays()
    }
    
    // -- MARK: Helper methods
    
    func start(){ startLoader(superView: self.aiContainer, activityIndicator: self.ai) }
    func stop(){ stopLoader(superView: self.aiContainer, activityIndicator: self.ai) }
    
    func filterArrays(){
        if userComment.isEmpty{
            for i in 0..<titles.count{
                if titles[i] == "User Commnet" {
                    titles.remove(at: i)
                    handleTableViewHeight()
                    break
                }
            }
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
    
    func isCreatorAndCollecitonEmpty() -> Bool{
        return creatorAndCollectionDetails.emp_name == "" &&
            creatorAndCollectionDetails.mgr_name == "" &&
            creatorAndCollectionDetails.dept_name == "" &&
            creatorAndCollectionDetails.nationality == "" &&
            creatorAndCollectionDetails.join_date == "" &&
            creatorAndCollectionDetails.start_date == "" &&
            creatorAndCollectionDetails.job_desc == "" &&
            creatorAndCollectionDetails.sub_job_desc == "" &&
            creatorAndCollectionDetails.customer_name == "" &&
            creatorAndCollectionDetails.sales_person == "" &&
            creatorAndCollectionDetails.coll_type == "" &&
            creatorAndCollectionDetails.territory == "" &&
            creatorAndCollectionDetails.amount == ""
    }
    
    func approveAction(buttonType: String, rMessage: String){
        if let commentText = commentTextView.text,
            let workFlowLast = workFlow.last{
            
            if buttonType == "BtnHold" || buttonType == "BtnReject"{
                gridEmpId_next = gridEmpId
            }
            
            print("""
                Emp_ID: \(appliedEmpId),
                fid: "\(listFormId)"
                pid: \(pid),
                comment: \(commentText)
                buttonType: \(buttonType),
                FormId: \(listFormId),
                Comment: \(commentText),
                grid_empid: \(gridEmpId),
                totalgrd_rows: \(workFlow.count),
                login_empId: \(AuthServices.currentUserId),
                finalApp_EmpId: \(workFlowLast.WorkFlow_Empid),
                finalApp_Status: \(workFlowLast.WorkFlow_EmpStatus)
                gridEmpid_next: \(gridEmpId_next)
                """)
            
            let approveResault = webService.Approve_SalesCollection(
                Emp_ID: appliedEmpId,
                fid: "\(listFormId)",
                pid: pid,
                comment: commentText,
                buttonType: buttonType,
                FormId: listFormId,
                Comment: commentText,
                grid_empid: gridEmpId,
                totalgrd_rows: workFlow.count,
                login_empId: AuthServices.currentUserId,
                finalApp_EmpId: workFlowLast.WorkFlow_Empid,
                finalApp_Status: workFlowLast.WorkFlow_EmpStatus,
                gridEmpid_next: gridEmpId_next)
            
            if approveResault == "" {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success",
                    alertMessage: rMessage,
                    actionTitle: "OK", onAction: {
                        //self.saveAction(buttonType: buttonType)
                        self.updateDelegateFunction(isSuccess: true)
                        self.navigationController?.popViewController(animated: true)
                }, cancelAction: nil, self)
            } else {
                updateDelegateFunction(isSuccess: false)
                AlertMessage().showAlertMessage(
                    alertTitle: "Alert",
                    alertMessage: approveResault,
                    actionTitle: nil,
                    onAction: nil,
                    cancelAction: "OK",
                    self)
            }
        }
    }
    
    func saveAction(buttonType: String){
        start()
        DispatchQueue.main.async {
            self.workFlow = self.webService.BindApproversGrid_SC(emp_id: self.appliedEmpId, formid: self.listFormId, pid: self.pid, langid: self.lang_int)
            let result = CommonTrackFunctions.instance.saveToHistory(array: self.workFlow, btnType: buttonType, pid: self.pid, formId: self.listFormId)
            print(result)
            
            
            self.stop()
        }
    }
    
    func updateDelegateFunction(isSuccess: Bool){
        if let delegate = self.delegate{
            delegate.approveAction(isSuccess: isSuccess, row: self.cellRow, categorySelected: self.categorySelected)
        }
    }
    
    func runApprove(buttonType: String, cMessage: String, rMessage: String){
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: cMessage,
            actionTitle: "OK",
            onAction: {
                
                self.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                    self.approveAction(buttonType: buttonType, rMessage: rMessage)
                    self.stop()
                })
                
        }, cancelAction: "Cancel", self)
    }
    
    // -- MARK: IBAction
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        print("Approve Button Tapped")
        let cMessage = "Do you want to approve the request?"
        let rMessage = "Sales collection request approved successfully"
        runApprove(buttonType: "BtnApprove", cMessage: cMessage, rMessage: rMessage)
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        print("On Hold Button Tapped")
        let cMessage = "Do you want to put the request onhold?"
        let rMessage = "Sales collection request put onhold successfully"
        runApprove(buttonType: "BtnHold", cMessage: cMessage, rMessage: rMessage)
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        print("Reject Button Tapped")
        let cMessage = "Do you want to reject the request?"
        let rMessage = "Sales collection request rejected successfully"
        runApprove(buttonType: "BtnReject", cMessage: cMessage, rMessage: rMessage)
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
        case 2:
            userComment.isEmpty ?
                performSegue(withIdentifier: "showCAWorkFlow", sender: nil) :
                performSegue(withIdentifier: "showCAUserComment", sender: nil)
        case 3: performSegue(withIdentifier: "showCAWorkFlow", sender: nil)
        default: break}
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCACreatorDetails" {
            if let vc = segue.destination as? CACreaterDetailsViewController {
                vc.creatorAndCollectionDetails = creatorAndCollectionDetails
                vc.navigationItem.title = titles[0]
            }
        } else if segue.identifier == "showCACollectionDetails" {
            if let vc = segue.destination as? CACollectionDetailsViewController {
                vc.creatorAndCollectionDetails = creatorAndCollectionDetails
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
                vc.navigationItem.title = userComment.isEmpty ? titles[2] : titles[3]
            }
        }
    }
    
}

// -- MARK: Scroll View Up Keyboad appreance

extension CollectionApprovalViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 81, right: 0)
            self.scrollView.contentInset = contentInset
        }, onHide: { _ in
            self.scrollView.contentInset = UIEdgeInsets.zero
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}
