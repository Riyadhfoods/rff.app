//
//  InOutDeductionApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 03/09/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class InOutDeductionApprovalViewController: UIViewController {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sTimeLabel: UILabel!
    @IBOutlet weak var eTimeLabel: UILabel!
    @IBOutlet weak var delayMinLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    let webservice = InOutDeductionService.instance
    let cellId = "cell_IODTitles"
    let cellTitles = ["Employee Information".localize(),
                      "User Comment".localize(),
                      "Work Flow".localize()]
    let lang = LoginViewController.languageChosen
    let currentUser = AuthServices.currentUserId
    var listFormId: Int = 0
    var IODDetailsArray = [In_Ou_Deduction_Modul]()
    var empDetailsArray = [Emp_Details_Modul]()
    var userComment = [CommentModul]()
    var workFlow = [WorkFlowModul]()
    var editWorkFlow = [WorkFlowModul]()
    var workFlowNames = [String]()
    
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
        
        if LanguageManger.isArabicLanguage{
            title = "نموذج الموافقة"
        } else {  title = "Approval Form" }
        setbackNavTitle(navItem: navigationItem)
        
        setUpView()
        start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        setUpData()
        stop()
    }
    
    // -- MARK: Set ups
    
    func setUpView(){
        commentTextView.text = ""
        commentTextView.delegate = self
        
        stackViewWidth.constant = AppDelegate.shared.screenSize.width - 32
    }
    
    func setUpData(){
        IODDetailsArray = webservice.Get_In_Out_Deduction_Data(lang: lang, pid: pid)
        empDetailsArray = webservice.Get_Emp_Details(lang: lang, emp_id: appliedEmpId)
        workFlow = webservice.BindApproversGrid(emp_id: appliedEmpId, formid: listFormId, pid: pid, lang: lang)
        for workflow in workFlow{
            workFlowNames.append(workflow.WorkFlow_EmpName)
        }
        userComment = webservice.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlow.count)
        if editWorkFlow.isEmpty{
            let updatedValues = CommonTrackFunctions.instance.updateWorkFlowPendingStatus(array: workFlow, editArray: &editWorkFlow)
            editWorkFlow = updatedValues.0
            gridEmpId = updatedValues.1
            gridEmpId_next = updatedValues.2
            buttonStack.isHidden = updatedValues.3
        }
        setInitailValue()
        handleHeighOfTableView()
    }
    
    func setInitailValue(){
        for iod in IODDetailsArray{
            if isError(error: iod.Error, target: self) {
                navigationController?.popViewController(animated: true)
                break
            }
            dateLabel.text = iod.Date
            sTimeLabel.text = iod.FromTime
            eTimeLabel.text = iod.ToTime
            delayMinLabel.text = iod.TotalMin
        }
        
    }
    
    // -- MARK: Helper functions
    
    func start(){ startLoader(superView: self.aiContainer, activityIndicator: self.ai) }
    func stop(){ stopLoader(superView: self.aiContainer, activityIndicator: self.ai) }
    
    func approveAction(buttonType: String, actionTitle: String){
        if let commentText = commentTextView.text,
            let workFlowLast = workFlow.last{
            
            if buttonType == "BtnHold" || buttonType == "BtnReject"{  gridEmpId_next = gridEmpId }
            
            let approveVacationResult = webservice.Approve_IOD(Emp_ID: appliedEmpId,
                                                               pid: pid,
                                                               buttonType: buttonType,
                                                               FormId: listFormId,
                                                               Comment: commentText,
                                                               grid_empid: gridEmpId,
                                                               totalgrd_rows: workFlow.count,
                                                               login_empId: currentUser,
                                                               finalApp_EmpId: workFlowLast.WorkFlow_Empid,
                                                               finalApp_Status: workFlowLast.WorkFlow_EmpStatus,
                                                               gridEmpid_next: gridEmpId_next)

            if approveVacationResult == "" {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success",
                    alertMessage: "In-out dedcution request " + actionTitle + " successfully",
                    actionTitle: "OK", onAction: {
                        self.saveAction(buttonType: buttonType)
                }, cancelAction: nil, self)
            } else {
                updateDelegateFunction(isSuccess: false)
                AlertMessage().showAlertMessage(
                    alertTitle: "Alert",
                    alertMessage: approveVacationResult,
                    actionTitle: nil,
                    onAction: nil,
                    cancelAction: "OK",
                    self)
            }
        }
    }
    
    func updateDelegateFunction(isSuccess: Bool){
        if let delegate = self.delegate{
            delegate.approveAction(isSuccess: isSuccess, row: self.cellRow, categorySelected: self.categorySelected)
        }
    }
    
    func saveAction(buttonType: String){
        self.start()
        DispatchQueue.main.async {
            self.workFlow = self.webservice.BindApproversGrid(emp_id: self.appliedEmpId, formid: self.listFormId, pid: self.pid, lang: self.lang)
            let result = CommonTrackFunctions.instance.saveToHistory(array: self.workFlow, btnType: buttonType, pid: self.pid, formId: self.listFormId)
            print(result)
            
            self.updateDelegateFunction(isSuccess: true)
            self.navigationController?.popViewController(animated: true)
            self.stop()
        }
    }
    
    func runApprove(buttonType: String, actionTitle: String){
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to \(actionTitle) the request?",
            actionTitle: "OK",
            onAction: {
                
                self.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                    self.approveAction(buttonType: buttonType, actionTitle: actionTitle)
                    self.stop()
                })
                
        }, cancelAction: "Cancel", self)
    }
    
    // -- MARK: IBActions

    @IBAction func approveButtonTapped(_ sender: Any) {
        print("Approve Button Tapped")
        runApprove(buttonType: "BtnApprove", actionTitle: "approved")
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        print("On Hold Button Tapped")
        runApprove(buttonType: "BtnHold", actionTitle: "put onhold")
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        print("Reject Button Tapped")
        runApprove(buttonType: "BtnReject", actionTitle: "rejected")
    }
}

extension InOutDeductionApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = getId(row: indexPath.row)
        performSegue(withIdentifier: id, sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getId(row: Int) -> String{
        switch row{
        case 0: return "showIODEmpDetails"
        case 1: return "showIODUserComment"
        case 2: return "showIODWorkFlow"
        default: return ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showIODEmpDetails" {
            if let vc = segue.destination as? IODEmpDetailsViewController{
                vc.empDetailsArray = empDetailsArray
                vc.navigationItem.title = cellTitles[0]
            }
        } else if segue.identifier == "showIODUserComment" {
            if let vc = segue.destination as? IODUserCommentTableViewController{
                vc.userComment = userComment
                vc.workFlowNames = workFlowNames
                vc.navigationItem.title = cellTitles[1]
            }
        } else if segue.identifier == "showIODWorkFlow" {
            if let vc = segue.destination as? IODWorkFlowTableViewController{
                vc.workFlow = editWorkFlow
                vc.navigationItem.title = cellTitles[2]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if empDetailsArray.isEmpty { return 0 }
        } else if indexPath.row == 1 {
            if userComment.isEmpty { return 0 }
        } else if indexPath.row == 2 {
            if workFlow.isEmpty{ return 0 }
        }
        return 44
    }
    
    func handleHeighOfTableView(){
        var emptyArray = [Bool]()
        var emptyArrayCount = 0
        
        emptyArray.append(empDetailsArray.isEmpty)
        emptyArray.append(userComment.isEmpty)
        emptyArray.append(workFlow.isEmpty)
        
        for isEmpty in emptyArray{
            if isEmpty{
                emptyArrayCount += 1
            }
        }
        
        tableViewHeight.constant = CGFloat(44 * (cellTitles.count - emptyArrayCount))
        tableView.reloadData()
    }
}

extension InOutDeductionApprovalViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}


extension InOutDeductionApprovalViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 164, right: 0)
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



















