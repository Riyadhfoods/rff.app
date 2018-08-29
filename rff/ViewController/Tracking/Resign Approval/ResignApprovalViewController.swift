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

    @IBOutlet weak var tableViewOfTitle: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var stackViewStack: NSLayoutConstraint!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var aiContainer: UIView!
    @IBOutlet weak var ai: UIActivityIndicatorView!
    
    // -- MARK: Variables
    
    let cellId = "cell_RATitles"
    let titles = ["Employee General Information",
                  "Increment/Decrement Details",
                  "Evaluation Details",
                  "User Comment",
                  "Work Flow"]
    
    // -- MARK: View kife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Setups
    
    func setUpView(){
        commentTextView.text = ""
        commentTextView.delegate = self
    }
    
    // -- MARK: Helper Functions
    
    
    
    // -- MARK: IBActions

    @IBAction func approveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func onHoldButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rejectButtonTapped(_ sender: Any) {
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















