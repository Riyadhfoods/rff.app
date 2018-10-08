//
//  BusinessTripApprovalFormViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 13/08/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class BusinessTripApprovalFormViewController: UIViewController {

    // -- MARK: IBOutlets
    
    @IBOutlet weak var transMode: UILabel!
    @IBOutlet weak var exitReEntryVisaButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewForTitles: UITableView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var activityContainerView: UIView!
    @IBOutlet weak var activityIndictor: UIActivityIndicatorView!
    @IBOutlet weak var lodingLabel: UILabel!
    
    
    // -- MARK: Variables
    
    let webservice = BusinessTripApprovalService.instance
    let cellTitles = ["Business Leave Details".localize(),
                     "Travel & Residence Details".localize(),
                     "Travel Membership".localize(),
                     "User Comment".localize(),
                     "Work Flow".localize()]
    let cellId = "cell_businessTripApproval"
    var pid = ""
    var btAppDetails = [BusinessTrip_AppModel]()
    var btTravelDetails = [BusinessTrip_AppTravelModel]()
    var userComment = [CommentModul]()
    var workFlow = [WorkFlowModul]()
    var editWorkFlow = [WorkFlowModul]()
    var listFormId: Int = 0
    var cellRow = 0
    var categorySelected = 0
    var appliedEmpName = ""
    var appliedEmpId = ""
    var gridEmpId = ""
    var gridEmpId_next = ""
    var workFlowNames = [String]()
    var delegate: ApproveActionDelegate?
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if LanguageManger.isArabicLanguage{
            title = "نموذج الموافقة"
        } else {  title = "Approval Form" }
        setbackNavTitle(navItem: navigationItem)
        
        setUpView()
        setViewAlignment()
        lodingLabel.textAlignment = .center
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        CommonFunction.shared.getCurrentViewContoller(Target: self)
        setUpData()
        end()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: SetUps
    
    func setUpView(){
        tableViewForTitles.dataSource = self
        tableViewForTitles.delegate = self
        commentTextView.delegate = self
        
        buttonsStackView.isHidden = true
        
        stackViewWidth.constant = AppDelegate.shared.screenSize.width - 32
        tableViewHeight.constant = CGFloat(cellTitles.count * 44)
        commentTextView.text = ""
    }
    
    func setUpData(){
        btAppDetails = webservice.Bind_business_trip_Details(pid: pid, lang: LoginViewController.languageChosen)
        btTravelDetails = webservice.Bind_travel_details_grid(pid: pid, lang: LoginViewController.languageChosen)
        
        workFlow = webservice.BindApproversGrid(emp_id: appliedEmpId, formid: listFormId, pid: pid, lang: LoginViewController.languageChosen)
        for workflow in workFlow{
            workFlowNames.append(workflow.WorkFlow_EmpName)
        }
        
        userComment = webservice.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlow.count)
        
        setUpValues()
        if editWorkFlow.isEmpty{
            let updatedValues = CommonTrackFunctions.instance.updateWorkFlowPendingStatus(array: workFlow, editArray: &editWorkFlow)
            editWorkFlow = updatedValues.0
            gridEmpId = updatedValues.1
            gridEmpId_next = updatedValues.2
            buttonsStackView.isHidden = updatedValues.3
        }
        handleHeighOfTableView()
    }
    
    func setUpValues(){
        for btApp in btAppDetails{
            transMode.text = btApp.TransMode
            if btApp.ExitReEnteryVisa == true {
                exitReEntryVisaButton.setBackgroundImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            } else { exitReEntryVisaButton.setBackgroundImage(UIImage(), for: .normal) }
        }
    }
    
    // -- MARK: Helper Functions
    
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
                    buttonsStackView.isHidden = false
                }
            }
            
            if array[count].WorkFlow_EmpStatus == "" && !isRejected && !isOnHold{
                if !isPending{
                    gridEmpId = array[count].WorkFlow_Empid
                    gridEmpId_next = count + 1 < array.count ? array[count + 1].WorkFlow_Empid : ""
                    array[count].WorkFlow_EmpStatus = "Pending"
                    isPending = true
                    
                    if array[count].WorkFlow_Empid == AuthServices.currentUserId{
                        buttonsStackView.isHidden = false
                    }
                }
            }
            editArray.append(array[count])
        }
    }
    
    func start(){ startLoader(superView: self.activityContainerView, activityIndicator: self.activityIndictor) }
    func end(){ stopLoader(superView: self.activityContainerView, activityIndicator: self.activityIndictor) }
    
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
                login_empId: \(AuthServices.currentUserId),
                finalApp_EmpId: \(workFlowLast.WorkFlow_Empid),
                finalApp_Status: \(workFlowLast.WorkFlow_EmpStatus)
                gridEmpid_next: \(gridEmpId_next)
                """)
            
            let approveVacationResult = webservice.Approve_BusinessTrip(
                Emp_ID: appliedEmpId,
                pid: pid,
                buttonType: buttonType,
                FormId: listFormId,
                Comment: commentText,
                grid_empid: gridEmpId,
                totalgrd_rows: workFlow.count,
                login_empId: AuthServices.currentUserId,
                finalApp_EmpId: workFlowLast.WorkFlow_Empid,
                finalApp_Status: workFlowLast.WorkFlow_EmpStatus,
                gridEmpid_next: gridEmpId_next)
            
            if approveVacationResult == "" {
                AlertMessage().showAlertMessage(
                    alertTitle: "Success",
                    alertMessage: rMessage,
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
        start()
        DispatchQueue.main.async {
            self.workFlow = self.webservice.BindApproversGrid(emp_id: self.appliedEmpId, formid: self.listFormId, pid: self.pid, lang: LoginViewController.languageChosen)
            let result = CommonTrackFunctions.instance.saveToHistory(array: self.workFlow, btnType: buttonType, pid: self.pid, formId: self.listFormId)
            print(result)
            
            self.updateDelegateFunction(isSuccess: true)
            self.navigationController?.popViewController(animated: true)
            self.end()
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
                    self.end()
                })
                
        }, cancelAction: "Cancel", self)
    }
    
    // -- MARK: IBAction
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        print("Approve Button Tapped")
        let cMessage = "Do you want to approve the request?"
        let rMessage = "Business trip request approved successfully"
        runApprove(buttonType: "BtnApprove", cMessage: cMessage, rMessage: rMessage)
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        print("On Hold Button Tapped")
        let cMessage = "Do you want to put the request onhold?"
        let rMessage = "Business trip request put onhold successfully"
        runApprove(buttonType: "BtnHold", cMessage: cMessage, rMessage: rMessage)
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        print("Reject Button Tapped")
        let cMessage = "Do you want to reject the request?"
        let rMessage = "Business trip request rejected successfully"
        runApprove(buttonType: "BtnReject", cMessage: cMessage, rMessage: rMessage)
    }
    
}

// -- MARK: Table View Data Source

extension BusinessTripApprovalFormViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BusinessTripApprovalFormCell{
            cell.textLabel?.text = cellTitles[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: performSegue(withIdentifier: "showBTLeaveDetails", sender: nil)
        case 1: performSegue(withIdentifier: "showBTTravelAndResidenceDetails", sender: nil)
        case 2: performSegue(withIdentifier: "showBTTravelMembership", sender: nil)
        case 3: performSegue(withIdentifier: "showBTUserComment", sender: nil)
        case 4: performSegue(withIdentifier: "showBTWorkFlow", sender: nil)
        default: break}
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBTLeaveDetails" {
            if let vc = segue.destination as? BusinessLeaveDetailsViewController{
                vc.businessLeaveDtailsArray = btAppDetails
                vc.navigationItem.title = cellTitles[0]
            }
        } else if segue.identifier == "showBTTravelAndResidenceDetails" {
            if let vc = segue.destination as? TravelAndResidenceDetailsTableViewController{
                vc.travelAndResidenceDetailsArray = btTravelDetails
                vc.navigationItem.title = cellTitles[1]
            }
        } else if segue.identifier == "showBTTravelMembership" {
            if let vc = segue.destination as? TravelMembershipViewController{
                vc.travelMenebershipArray = btAppDetails
                vc.navigationItem.title = cellTitles[2]
            }
        } else if segue.identifier == "showBTUserComment" {
            if let vc = segue.destination as? BTUserCommentTableViewController{
                vc.userCommentArray = userComment
                vc.workFlowNames = workFlowNames
                vc.navigationItem.title = cellTitles[3]
            }
        } else if segue.identifier == "showBTWorkFlow" {
            if let vc = segue.destination as? BTWorkFlowTableViewController{
                vc.workFlow = editWorkFlow
                vc.navigationItem.title = cellTitles[4]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if btAppDetails.isEmpty { return 0 }
        } else if indexPath.row == 1 {
            if btTravelDetails.isEmpty { return 0 }
        } else if indexPath.row == 2 {
            if btAppDetails.isEmpty { return 0 }
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
        
        emptyArray.append(btAppDetails.isEmpty)
        emptyArray.append(btTravelDetails.isEmpty)
        emptyArray.append(btAppDetails.isEmpty)
        emptyArray.append(userComment.isEmpty)
        emptyArray.append(workFlow.isEmpty)
        
        for isEmpty in emptyArray{
            if isEmpty{
                emptyArrayCount += 1
            }
        }
        
        tableViewHeight.constant = CGFloat(44 * (cellTitles.count - emptyArrayCount))
        tableViewForTitles.reloadData()
    }
}

// -- MARK: Handling Text

extension BusinessTripApprovalFormViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            commentTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

// -- MARK: Cell Class

class BusinessTripApprovalFormCell: UITableViewCell{
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setViewAlignment()
    }
}

extension BusinessTripApprovalFormViewController{
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
