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
    var listFormId: Int = 0
    var appliedEmpName = ""
    var appliedEmpId = ""
    var gridEmpId = ""
    var gridEmpId_next = ""
    
    // -- MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setViewAlignment()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUpData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: SetUps
    
    func setUpView(){
        tableViewForTitles.dataSource = self
        tableViewForTitles.delegate = self
        commentTextView.delegate = self
        
        stackViewWidth.constant = AppDelegate.shared.screenSize.width - 32
        tableViewHeight.constant = CGFloat(cellTitle.count * 44)
        commentTextView.text = ""
    }
    
    func setUpData(){
        btAppDetails = webservice.Bind_business_trip_Details(pid: pid, lang: LoginViewController.languageChosen)
        btTravelDetails = webservice.Bind_travel_details_grid(pid: pid, lang: LoginViewController.languageChosen)
        workFlow = webservice.BindApproversGrid(formid: listFormId, pid: pid, lang: LoginViewController.languageChosen)
        userComment = webservice.BindCommentGrid(pid: pid, fid: listFormId, gvApp_RowCount: workFlow.count)
        
        setUpValues()
    }
    
    func setUpValues(){
        for btApp  in btAppDetails{
            transMode.text = btApp.TransMode
            if btApp.ExitReEnteryVisa == true {
                exitReEntryVisaButton.setBackgroundImage(#imageLiteral(resourceName: "checkBox"), for: .normal)
            } else { exitReEntryVisaButton.setBackgroundImage(UIImage(), for: .normal) }
        }
    }
    
    // -- MARK: IBAction
    
    @IBAction func approveButtonTapped(_ sender: Any) {
        print("Approve Button Tapped")
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
        print("On Hold Button Tapped")
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
        print("Reject Button Tapped")
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
            }
        } else if segue.identifier == "showBTWorkFlow" {
            if let vc = segue.destination as? BTWorkFlowTableViewController{
                vc.workFlow = workFlow
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
