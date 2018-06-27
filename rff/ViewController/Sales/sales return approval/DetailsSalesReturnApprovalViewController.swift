//
//  DetailsSalesReturnApprovalViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 23/06/2018.
//  Copyright © 2018 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class DetailsSalesReturnApprovalViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    // -- MARK: IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackviewWidth: NSLayoutConstraint!
    @IBOutlet weak var DetailsSalesReturnTableview: UITableView!
    @IBOutlet weak var empCreated: UILabel!
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var salesPerson: UILabel!
    @IBOutlet weak var requestDate: UILabel!
    @IBOutlet weak var ReturnDate: UILabel!
    @IBOutlet weak var comment: UITextView!
    
    // -- MARK: Variable
    
    let screenSize = AppDelegate().screenSize
    let cellId = "cell_detailsSalesReturnRequest"
    let cellTitleArray = ["Item(s) Details", "Cutomer Aging", "Work Flow"]
    
    // -- MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAlignment()
        stackviewWidth.constant = screenSize.width - 32
        comment.delegate = self
        
        setUpCommentDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // -- MARK: Set ups
    
    func setUpCommentDisplay(){
        comment.text = ""
        comment.layer.cornerRadius = 5.0
        comment.layer.borderColor = mainBackgroundColor.cgColor
        comment.layer.borderWidth = 1
        
    }
    
    // -- MARK: TextView handle
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            comment.resignFirstResponder()
            return false
        }
        return true
    }
    
    // -- MARK: Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DetailsSalesReturnApprovalCell{
            cell.textLabel?.text = cellTitleArray[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            performSegue(withIdentifier: "showItemReturnApproval", sender: nil)
        case 1:
            performSegue(withIdentifier: "showCustomerAgingReturnApproval", sender: nil)
        case 2:
            performSegue(withIdentifier: "showWorkFlowReturnApproval", sender: nil)
        default:
            return
        }
    }
    
    // -- MARK: IBActions
    @IBAction func approveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func rejectAllButtonTapped(_ sender: Any) {
    }
    
    @IBAction func returnButtonTapped(_ sender: Any) {
    }
}

extension DetailsSalesReturnApprovalViewController{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers(onShow: { frame in
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height - 73, right: 0)
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






