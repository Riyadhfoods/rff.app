//
//  ResignApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 28/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class ResignApprovalViewController: UIViewController {
    
    // -- MARK: IBOutlets

    @IBOutlet weak var resignType: UILabel!
    @IBOutlet weak var tableViewOfTitle: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var stackViewStack: NSLayoutConstraint!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // -- MARK: Variables
    
    let webservice = ResignService.instance
    let cellId = "cell_RATitles"
    let titles = ["Employee General Information".localize(),
                  "Increment/Decrement Details".localize(),
                  "Evaluation Details".localize(),
                  "User Comment".localize(),
                  "Work Flow".localize()]
    let lang = LoginViewController.languageChosen
    let currentUser = AuthServices.currentUserId
    var listFormId: Int = 0
    var savedEmpDetailsArray = [ResignEmpDetailsModul]()
    var empDetailsArray = [ResignEmpDetailsModul]()
    var IncDecrDetailsArray = [Inc_DecrDetailsModul]()
    var evaDetailsArray = [EvaDetailsModul]()
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
    
    // -- MARK: View kife Cycle
    
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
    
    // -- MARK: Setups
    
    func setUpView(){
        commentTextView.text = ""
        commentTextView.delegate = self
        
        stackViewStack.constant = AppDelegate.shared.screenSize.width - 32
    }
    
    func setUpData(){
        empDetailsArray = webservice.Get_Emp_Details(lang: lang, emp_id: appliedEmpId)
        IncDecrDetailsArray = webservice.Get_Inc_Desc_Details(lang: lang, emp_id: appliedEmpId)
        evaDetailsArray = webservice.Get_Eva_Details(lang: lang, emp_id: appliedEmpId)
        
        savedEmpDetailsArray = webservice.Get_Saved_Res_Details(lang: lang, pid: pid, formId: "\(listFormId)")
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
        if savedEmpDetailsArray.isEmpty{return}
        for savedemp in savedEmpDetailsArray{
            resignType.text = "EOS Type ".localize() + savedemp.Resign_type
        }
    }
    
    // -- MARK: Helper Functions
    
    func start(){ startLoader(superView: self.aiContainer, activityIndicator: self.ai) }
    func stop(){ stopLoader(superView: self.aiContainer, activityIndicator: self.ai) }
    
    func updateWorkFlowPendingStatus(array: [WorkFlowModul], editArray: inout [WorkFlowModul]){
        var isPending = false
        var isRejected = false
        var isOnHold = false
        for count in 0..<array.count{
            print(array[count].WorkFlow_EmpStatus)
            if array[count].WorkFlow_EmpStatus == "Rejected"{
                isRejected = true
            } else if array[count].WorkFlow_EmpStatus == "On Hold"{
                gridEmpId = array[count].WorkFlow_Empid
                gridEmpId_next = count + 1 < array.count ? array[count + 1].WorkFlow_Empid : ""
                isOnHold = true
                if array[count].WorkFlow_Empid == AuthServices.currentUserId{
                    buttonStack.isHidden = false
                }
            }
            
            if array[count].WorkFlow_EmpStatus == "" && !isRejected && !isOnHold{
                if !isPending{
                    gridEmpId = array[count].WorkFlow_Empid
                    gridEmpId_next = count + 1 < array.count ? array[count + 1].WorkFlow_Empid : ""
                    array[count].WorkFlow_EmpStatus = "Pending"
                    isPending = true
                    
                    if array[count].WorkFlow_Empid == AuthServices.currentUserId{
                        buttonStack.isHidden = false
                    }
                }
            }
            editArray.append(array[count])
        }
    }
    
    func approveAction(buttonType: String, rMessage: String){
        if let commentText = commentTextView.text,
            let workFlowLast = workFlow.last{
            
            if buttonType == "BtnHold" || buttonType == "BtnReject"{
                gridEmpId_next = gridEmpId
            }
            
            print("""
                Emp_ID: \(appliedEmpId),
                pid: \(pid),
                buttonType: \(buttonType),
                FormId: \(listFormId),
                Comment: \(commentText),
                grid_empid: \(gridEmpId),
                totalgrd_rows: \(workFlow.count),
                login_empId: \(currentUser),
                finalApp_EmpId: \(workFlowLast.WorkFlow_Empid),
                finalApp_Status: \(workFlowLast.WorkFlow_EmpStatus)
                gridEmpid_next: \(gridEmpId_next)
                """)
            
            let approveVacationResult = webservice.Approve_EOS(Emp_ID: appliedEmpId,
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
                    alertTitle: "Success".localize(),
                    alertMessage: rMessage,
                    actionTitle: "OK", onAction: {
                        self.saveAction(buttonType: buttonType)
                }, cancelAction: nil, self)
            } else {
                self.updateDelegateFunction(isSuccess: false)
                AlertMessage().showAlertMessage(
                    alertTitle: "Alert".localize(),
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
        start()
        DispatchQueue.main.async {
            self.workFlow = self.webservice.BindApproversGrid(emp_id: self.appliedEmpId, formid: self.listFormId, pid: self.pid, lang: self.lang)
            let result = CommonTrackFunctions.instance.saveToHistory(array: self.workFlow, btnType: buttonType, pid: self.pid, formId: self.listFormId)
            print(result)
            
            self.updateDelegateFunction(isSuccess: true)
            self.navigationController?.popViewController(animated: true)
            self.stop()
        }
    }
    
    func runApprove(buttonType: String, cMessage: String, rMessage: String){
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation".localize(),
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
    
    // -- MARK: IBActions

    @IBAction func approveButtonTapped(_ sender: Any) {
        print("Approve Button Tapped")
        let cMessage = "Do you want to approve the request?"
        let rMessage = "Resign request approved successfully"
        runApprove(buttonType: "BtnApprove", cMessage: cMessage, rMessage: rMessage)
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        print("On Hold Button Tapped")
        let cMessage = "Do you want to put the request onhold?"
        let rMessage = "Resign request put onhold successfully"
        runApprove(buttonType: "BtnHold", cMessage: cMessage, rMessage: rMessage)
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        print("Reject Button Tapped")
        let cMessage = "Do you want to reject the request?"
        let rMessage = "Resign request rejected successfully"
        runApprove(buttonType: "BtnReject", cMessage: cMessage, rMessage: rMessage)
    }
    
}

extension ResignApprovalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RATitlesCell{
            cell.textLabel?.text = titles[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = getId(row: indexPath.row)
        performSegue(withIdentifier: id, sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getId(row: Int) -> String{
        switch row{
        case 0: return "showRAEmpInfo"
        case 1: return "showRAIncDec"
        case 2: return "showRAEva"
        case 3: return "showRAUserComment"
        case 4: return "showRAWorkFlow"
        default: return ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRAEmpInfo" {
            if let vc = segue.destination as? RAEmpInfoViewController{
                vc.savedEmpDetailsArray = savedEmpDetailsArray
                vc.empDetailsArray = empDetailsArray
                vc.navigationItem.title = titles[0]
            }
        } else if segue.identifier == "showRAIncDec" {
            if let vc = segue.destination as? RAIncDecTableViewController{
                vc.IncDecrDetailsArray = IncDecrDetailsArray
                vc.navigationItem.title = titles[1]
            }
        } else if segue.identifier == "showRAEva" {
            if let vc = segue.destination as? RAEvaTableViewController{
                vc.evaDetailsArray = evaDetailsArray
                vc.navigationItem.title = titles[2]
            }
        } else if segue.identifier == "showRAUserComment" {
            if let vc = segue.destination as? RAUserCommentTableViewController{
                vc.userComment = userComment
                vc.workFlowNames = workFlowNames
                vc.navigationItem.title = titles[3]
            }
        } else if segue.identifier == "showRAWorkFlow" {
            if let vc = segue.destination as? RAWorkFlowTableViewController{
                vc.workFlow = editWorkFlow
                vc.navigationItem.title = titles[4]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if empDetailsArray.isEmpty { return 0 }
        } else if indexPath.row == 1 {
            if IncDecrDetailsArray.isEmpty { return 0 }
        } else if indexPath.row == 2 {
            if evaDetailsArray.isEmpty { return 0 }
        } else if indexPath.row == 3 {
            if userComment.isEmpty { return 0 }
        } else if indexPath.row == 4 {
            if workFlow.isEmpty{ return 0 }
        }
        return 44
    }
    
    func handleHeighOfTableView(){
        var emptyArray = [Bool]()
        var emptyArrayCount = 0
        
        emptyArray.append(empDetailsArray.isEmpty)
        emptyArray.append(IncDecrDetailsArray.isEmpty)
        emptyArray.append(evaDetailsArray.isEmpty)
        emptyArray.append(userComment.isEmpty)
        emptyArray.append(workFlow.isEmpty)
        
        for isEmpty in emptyArray{
            if isEmpty{
                emptyArrayCount += 1
            }
        }
        
        tableViewHeight.constant = CGFloat(44 * (titles.count - emptyArrayCount))
        tableViewOfTitle.reloadData()
    }
}

extension ResignApprovalViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

class RATitlesCell: UITableViewCell{
    
}


extension ResignApprovalViewController{
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












