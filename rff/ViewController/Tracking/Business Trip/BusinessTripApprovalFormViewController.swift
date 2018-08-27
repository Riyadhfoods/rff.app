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
    let cellTitle = ["Business Leave Details",
                     "Travel & Residence Details",
                     "Travel Membership",
                     "User Comment",
                     "WorkFlow"]
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
        
        setUpView()
        setViewAlignment()
        lodingLabel.textAlignment = .center
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
        tableViewHeight.constant = CGFloat(cellTitle.count * 44)
        commentTextView.text = ""
    }
    
    func setUpData(){
        btAppDetails = webservice.Bind_business_trip_Details(pid: pid, lang: LoginViewController.languageChosen)
        btTravelDetails = webservice.Bind_travel_details_grid(pid: pid, lang: LoginViewController.languageChosen)
        
        workFlow = webservice.BindApproversGrid(formid: listFormId, pid: pid, lang: LoginViewController.languageChosen)
        for workflow in workFlow{
            workFlowNames.append(workflow.WorkFlow_EmpName)
        }
        
        userComment = webservice.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlow.count)
        
        setUpValues()
        if editWorkFlow.isEmpty{
            updateWorkFlowPendingStatus(array: workFlow, editArray: &editWorkFlow)
        }
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
    
    func approveAction(buttonType: String, actionTitle: String){
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
            
            let approveVacationResult = webservice.Approve_BusinessTrip(Emp_ID: appliedEmpId,
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
                    alertMessage: "Business trip request " + actionTitle + " successfully",
                    actionTitle: "OK", onAction: {
                        
                        self.start()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                            moveTo(storyboard: "Home", withIdentifier: "homeViewControllerNav", viewController: self)
                            self.end()
                        })

                }, cancelAction: nil, self)
            } else {
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
    
    func runApprove(buttonType: String, actionTitle: String){
        AlertMessage().showAlertMessage(
            alertTitle: "Confirmation",
            alertMessage: "Do you want to approve the request?",
            actionTitle: "OK",
            onAction: {
                
                self.start()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                    self.approveAction(buttonType: buttonType, actionTitle: actionTitle)
                    self.end()
                })
                
        }, cancelAction: "Cancel", self)
    }
    
    // -- MARK: IBAction
    
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

// -- MARK: Table View Data Source

extension BusinessTripApprovalFormViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? BusinessTripApprovalFormCell{
            cell.textLabel?.text = cellTitle[indexPath.row]
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
            }
        } else if segue.identifier == "showBTTravelAndResidenceDetails" {
            if let vc = segue.destination as? TravelAndResidenceDetailsTableViewController{
                vc.travelAndResidenceDetailsArray = btTravelDetails
            }
        } else if segue.identifier == "showBTTravelMembership" {
            if let vc = segue.destination as? TravelMembershipViewController{
                vc.travelMenebershipArray = btAppDetails
            }
        } else if segue.identifier == "showBTUserComment" {
            if let vc = segue.destination as? BTUserCommentTableViewController{
                vc.userCommentArray = userComment
                vc.workFlowNames = workFlowNames
            }
        } else if segue.identifier == "showBTWorkFlow" {
            if let vc = segue.destination as? BTWorkFlowTableViewController{
                vc.workFlow = editWorkFlow
            }
        }
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
